//
//  SwiftUITest1.swift
//  ARUITest
//
//  Created by Peter Pohlmann on 27.08.19.
//  Copyright © 2019 Peter Pohlmann. All rights reserved.
//

import SwiftUI

struct SwiftUITest1: View {
  @ObservedObject var navController: NaVController
  
    var body: some View {
      
      ZStack{
    
       Image("1")
        .scaledToFill()
        .frame(height: 200)
        .clipped()
        
        Button(action: {
          self.doThings()
          print("Button pressed")
        }
        
        ) {
          if navController.test == "x" {
          Text("Button")
           .background(Color.red)
          } else {
             Text("Button")
            .background(Color.green)
          }
        }
        
      }
    }
  
  func doThings() {
    navController.printMessage()
  }
  
}

struct SwiftUITest1_Previews: PreviewProvider {
    static var previews: some View {
      SwiftUITest1(navController: NaVController())
    }
}
