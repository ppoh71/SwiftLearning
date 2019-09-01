//
//  SwiftUITest1.swift
//  ARUITest
//
//  Created by Peter Pohlmann on 27.08.19.
//  Copyright © 2019 Peter Pohlmann. All rights reserved.
//

import SwiftUI

struct SwiftUITest1: View {
  @EnvironmentObject var navController: NavController
  
  @State private var rotationDegrees: Double = -40
  @State private var rotation3D: Double = -190
  @State private var scale: Double = 1

  let but1 =  ButtonAddBasePoints()
  
  var body: some View {
    
    VStack {
      
      HStack {
        Button(action: {
          self.navController.changeValues(actionState: .createBaselinesForGreenscreen)
        }) {
          Text("Add BasePoints")
        }
        
        Button(action: {
          self.navController.changeValues(actionState: .setHeightForGreenscreen)
            }) {
              Text("Set Height")
            }
        
        Button(action: {
          //self.resetActionState()
          self.switchButton(type: true)
        }) {
          Text("Reset")
        }
      }
      
      HStack {
        but1
      }
    }
  }
  

  func switchButton(type: Bool) {
    
    // hide button first
//    self.rotationDegrees = -270
//    self.rotation3D = 0
//    self.scale = 0.7
    
//    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { // Change `2.0` to the desired number of seconds.
//       // Code you want to be delayed
//      self.rotationDegrees = 30
//      self.rotation3D = -360
//      self.scale = 1
//    }
    
  }
  
  func setHeight() {
    navController.switchActionToNone()
    //navController.setHeightForGreenscreen()
    print("set height")
    //self.rotationDegrees = -270
    //self.rotation3D = 0
    //self.scale = 1

    
  }
  
  func resetActionState() {
    navController.switchActionToNone()

    
  }
  
  func greenscreenMakeBasePoints() {
    //but1.doThings()
    
    navController.switchActionAddGreenscreenBasePoints()

  }
  
  func doThings() {
    

    navController.printMessage()
  }
  
}



struct SwiftUITest1_Previews: PreviewProvider {
  static var previews: some View {
    SwiftUITest1().environmentObject(NavController())
  }
}
