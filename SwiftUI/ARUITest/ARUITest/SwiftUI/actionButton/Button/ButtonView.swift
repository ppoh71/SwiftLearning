//
//  ButtonSUI.swift
//  ARUITest
//
//  Created by Peter Pohlmann on 30.08.19.
//  Copyright © 2019 Peter Pohlmann. All rights reserved.
//

import SwiftUI
import Combine

struct ButtonView: View {
  @EnvironmentObject var navController: actionButtonObserver
  @Binding var buttonAction: ButtonAction // binding comes from navController too
  
  @State private var active: Bool = false
  @State private var sides: Double = 8
  @State private var rotationDegrees: Double = 0
  @State private var scaleInnerButton: Double = 1
  @State private var scaleOuterButton: Double = 1
  
  var body: some View {
    let circle = Circle().stroke(Color.white, lineWidth: 3)
    let circleShape = Circle()
    let gradientBackground = Color.white.modifier(AnimatableGradient(from: buttonAction.type.gradient1, to:  buttonAction.type.gradient2, pct: self.active ? 1 : 0 ))
    let gradientOutline = Color.white.modifier(CircleGradient(from:  buttonAction.type.gradient1, to:  buttonAction.type.gradient2, pct: self.active ? 1 : 0 ))
    let buttonWidth = CGFloat(buttonAction.buttonWidth)
    
    return Button(action: {
      withAnimation(.easeInOut(duration: 1.0)) {
        self.active.toggle()
      }
      self.clickAction()
    }
    ) {
      /// Button Design
      ZStack {
        circle
          .frame(width: buttonWidth - 14, height: buttonWidth - 14, alignment: .center)
          .background(gradientBackground)
          .clipShape(circleShape)
          
          /// animate click on button (inner)
          .scaleEffect(CGFloat(self.scaleInnerButton))
          .rotationEffect(Angle(degrees: self.rotationDegrees))
          .animation(.easeInOut(duration: 0.15))
        
        gradientOutline
          .frame(width: buttonWidth - 5, height: buttonWidth - 5, alignment: .top)
          .background(gradientOutline)
          
          /// animate click on button (outer)
          .scaleEffect(CGFloat(self.scaleOuterButton))
          .rotationEffect(Angle(degrees: self.rotationDegrees))
          .animation(.easeInOut(duration: 0.25))
          .background(Image(systemName: self.buttonAction.type.imageName)).foregroundColor(.white)
      }
        //.shadow(color: .black, radius: 30, x: 5, y: 5)
        
        /// animate external events from navController
        .rotationEffect(Angle(degrees: self.buttonAction.rotationDegrees))
        .scaleEffect(CGFloat(self.buttonAction.scale))
        .opacity(self.buttonAction.opacity)
        .frame(width: buttonWidth, height: buttonWidth, alignment: .center)
        .animation(.easeInOut(duration: 0.4))
        
    }.disabled(self.buttonAction.disabled) /// disable button for ZStack
  }
  
  func clickAction() {
    print("click but1")
    clickAnimation()
    
    ///
    ///  navController click action trigger for
    ///
    switch  buttonAction.type {
      
    case .AddBasepointsGreenscreen:
      navController.actionAddBasepointsGreenscreen()
      print("create baseline")
      
    case .SetHeightGreenscreen:
      print("set height")
      navController.actionSetHeightGreenscreen()
      
    case .NextToSetHeightGreenscreen:
      navController.showButtonSetHeightGreenscreen()
      print("next")
      
    case .NextToMaterialGreenscreen:
      print("next to material")
      navController.showMaterial()
      
    case .SpacerButton:
      print("SpacerButton")
    }
    navController.printMessage()
  }
  
  func clickAnimation() {
    self.rotationDegrees += 120
    self.scaleInnerButton = 0.95
    self.scaleOuterButton = 0.85
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
      self.scaleInnerButton = 1
      self.scaleOuterButton = 1
    }
  }
}

struct ButtonAddBasePoints_Previews: PreviewProvider {
  static var previews: some View {
    //.constant(ButtonAction(id: 10, type: .AddGroundPointsButton))
    ButtonView( buttonAction: .constant(ButtonAction(id: 10, type: .AddBasepointsGreenscreen))).environmentObject(actionButtonObserver())
      .previewDevice(PreviewDevice(rawValue: "iPhone X"))
      .previewDisplayName("iPhone X")
  }
}
