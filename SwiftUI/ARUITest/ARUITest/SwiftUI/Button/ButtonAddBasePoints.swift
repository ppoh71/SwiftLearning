//
//  ButtonSUI.swift
//  ARUITest
//
//  Created by Peter Pohlmann on 30.08.19.
//  Copyright © 2019 Peter Pohlmann. All rights reserved.
//

import SwiftUI
import Combine

struct ButtonAddBasePoints: View {
  @EnvironmentObject var navController: NavController
  var buttonType: ButtonType
  

  @State private var sides: Double = 8
  @State private var rotationDegrees: Double = 0
  @State private var scaleBut: Double = 1

  var body: some View {
    
    Button(action: {
      self.doThings()
    }
    ) {
      PolygonShape(sides: sides, scale: scaleBut).stroke(Color.blue, lineWidth: 1)
          .frame(width: 50, height: 50, alignment: .center)
          .rotationEffect(Angle(degrees: self.rotationDegrees))
          .background(Image(systemName: self.buttonType.imageName))
          .scaleEffect(CGFloat(self.scaleBut))
          .animation(.easeInOut(duration: 0.3))
    }
}
  
  
   func doThings() {
    print("click but1")
    
    // button on click animation
    self.scaleBut = 1.01
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
      self.scaleBut = 1
    }
    
    
    //self.sides =  Double.random(in: 9..<13)
    self.rotationDegrees += 90
    
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
  
}

struct ButtonAddBasePoints_Previews: PreviewProvider {
    var navC = NavController()
    static var previews: some View {
      ButtonAddBasePoints(buttonType: ButtonType.AddGroundPointsButton).environmentObject(NavController())
    }
}
