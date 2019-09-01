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
  
  @State private var toggle = false
  @State private var sides: Double = 8


//  @State private var rotationDegrees: Double = -40
//  @State private var rotation3D: Double = -190
  
    var body: some View {
      
      Button(action: {
        self.doThings()
      }
      ) {
        PolygonShape(sides: sides, scale: 0.5).stroke(Color.blue, lineWidth: 3)
              .frame(width: 50, height: 50, alignment: .center)
             .background(Image(systemName: navController.imageName))
             .rotationEffect(Angle(degrees: navController.rotationDegrees))
             .rotation3DEffect(Angle(degrees: navController.rotation3D), axis: (x: -10, y: -10, z: 0))
             .scaleEffect(CGFloat(navController.scale))
             .animation(.easeInOut(duration: 0.8))
      }
  }
  
  
  public func doThings() {
    print("click but1")
    
    switch navController.actionState {
      case .createBaselinesForGreenscreen:
        print("create baseline")
      case .setHeightForGreenscreen:
         print("set height")
      default:
        print("Default")
    }
    navController.printMessage()
  }
  
}

struct ButtonAddBasePoints_Previews: PreviewProvider {
    var navC = NavController()
    static var previews: some View {
      ButtonAddBasePoints().environmentObject(NavController())
    }
}
