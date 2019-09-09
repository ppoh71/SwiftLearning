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
  @EnvironmentObject var navController: NavController
  var buttonType: ButtonType
  
  @State private var active: Bool = false
  @State private var sides: Double = 8
  @State private var rotationDegrees: Double = 0
  @State private var scaleBut: Double = 1
  @State private var gradient1: [UIColor] = [.blue, .green]
  @State private var gradient2: [UIColor] = [.red, .yellow]
  
  var body: some View {
    let buttonShape = PolygonShape(sides: sides, scale: scaleBut)
    let buttonShapeView = PolygonShape(sides: sides, scale: scaleBut).stroke(Color.white, lineWidth: 3)
    let gradientBackground = Color.clear.modifier(AnimatableGradient(from: gradient1, to: gradient2, pct: self.active ? 1 : 0 ))
    let gradientOutline = Color.clear.modifier(AnimatableGradient2(from: gradient1, to: gradient2, pct: self.active ? 1 : 0 ))
    
    return Button(action: {
      withAnimation(.easeInOut(duration: 1.0)) {
        self.active.toggle()
      }
      self.doThings()
    }
    ) {
      
      ZStack {
        buttonShapeView
          .frame(width: 660, height: 66, alignment: .center)
          .clipShape(buttonShape)
          .shadow(color: .black, radius: 10, x: 2, y: 2)
          .background(gradientBackground)
          .clipShape(buttonShape)
          .scaleEffect(CGFloat(self.scaleBut))
          .rotationEffect(Angle(degrees: self.rotationDegrees))
          .animation(.easeInOut(duration: 0.5))
        
        gradientOutline
          .frame(width: 75, height: 75, alignment: .center)
          .background(gradientOutline)
          .background(Image(systemName: self.buttonType.imageName)).foregroundColor(.white)
          .animation(.easeInOut(duration: 1.5))
      }
      .shadow(color: .black, radius: 30, x: 5, y: 5)
    }
  }
  
  func doThings() {
    print("click but1")
    
    clickAnimation()
    
    //self.sides =  Double.random(in: 9..<13)
    self.rotationDegrees += 45
    
    /// click action trigger for
    ///  navController
    ///
    switch buttonType {
    case .AddGroundPointsButton:
      navController.createGreenscreenBasePoints()
      print("create baseline")
    case .SetHeightButton:
      print("set height")
      navController.setHeight()
    case .NextToHeight:
      navController.showHeightSettingsButton()
      print("next")
    case .NextToMaterial:
      print("next to material")
    }
    navController.printMessage()
  }
  
  func clickAnimation() {
    if buttonType != .NextToHeight && buttonType != .NextToMaterial {
      self.scaleBut = 0.95
      DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
        self.scaleBut = 1
      }
    }
  }
}


struct ButtonAddBasePoints_Previews: PreviewProvider {
  var navC = NavController()
  static var previews: some View {
    ButtonView(buttonType: ButtonType.AddGroundPointsButton).environmentObject(NavController())
      .previewDevice(PreviewDevice(rawValue: "iPhone X"))
      .previewDisplayName("iPhone X")
  }
}


