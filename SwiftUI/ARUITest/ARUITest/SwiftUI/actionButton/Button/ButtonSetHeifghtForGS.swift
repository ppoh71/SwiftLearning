//
//  ButtonSUI.swift
//  ARUITest
//
//  Created by Peter Pohlmann on 30.08.19.
//  Copyright © 2019 Peter Pohlmann. All rights reserved.
//

import SwiftUI

struct ButtonSetHeightForGS: View {
  @EnvironmentObject var navController: NavController
  
  @State private var toggle = false
  @State private var sides: Double = 8
  @State private var scale: Double = 1
    
  let shape =  PolygonShape(sides: 8, scale: 1)
  
    var body: some View {
      
      Button(action: {
        self.doThings()

      }
      ) {
          PolygonShape(sides: sides, scale: scale).stroke(Color.blue, lineWidth: 3)
      }
    }
  
  func doThings() {
    print("click set height")
    
    self.toggle.toggle()
    sides = self.toggle ? 12 : 8
    scale = self.toggle ? 1 : 0.8
    navController.printMessage()
  }
  
}

struct ButtonSetHeightForGS_Previews: PreviewProvider {
    var navC = NavController()
    static var previews: some View {
      ButtonSetHeightForGS().environmentObject(NavController())
    }
}
