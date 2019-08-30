//
//  ButtonSUI.swift
//  ARUITest
//
//  Created by Peter Pohlmann on 30.08.19.
//  Copyright © 2019 Peter Pohlmann. All rights reserved.
//

import SwiftUI

struct ButtonSUI: View {
  @EnvironmentObject var navController: NavController
  @State private var switchU = false
  @State private var sides: Double = 4
  @State private var duration: Double = 1.3
  @State private var scale: Double = 1.0
  
    var body: some View {
      
      Button(action: {
        self.doThings()
      }
      ) {
        

        PolygonShape(sides: self.sides, scale: self.scale).stroke(Color.blue, lineWidth: 3)
          .frame(width: 50, height: 50, alignment: .center)
          .transition(.offset(x: CGFloat(sides), y: CGFloat(sides) ))
          .animation(.easeInOut(duration: duration))
          


      }   
    }
  
  func doThings() {
    print("click")
    
    self.sides = Double.random(in: 3..<36)
    self.scale = Double.random(in: 0.2..<2)
    
    navController.printMessage()
  }
  
}

struct ButtonSUI_Previews: PreviewProvider {
    var navC = NavController()
    static var previews: some View {
      ButtonSUI().environmentObject(NavController())
    }
}
