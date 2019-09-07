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
  @State private var showGSBasic = false

  var body: some View {
    
    VStack {
      
      HStack {
        Button(action: {
          self.navController.showGreensceenAddBasePoints()
        
        }) {
          Text("Add BasePoints")
        }
        
        Button(action: {
          
        }) {
          Text("Set Height")
        }
        
        Button(action: {
          
        }) {
          Text("Reset")
        }
      }
      
        HStack {
            GSBasicActionButton()
        }
      }
    }
  

}



struct SwiftUITest1_Previews: PreviewProvider {
  static var previews: some View {
    
    
    Group {
       SwiftUITest1().environmentObject(NavController())
      .previewDevice(PreviewDevice(rawValue: "iPhone XS Max"))
      .previewDisplayName("iPhone XS Max")
      
//      SwiftUITest1().environmentObject(NavController())
//      .previewDevice(PreviewDevice(rawValue: "iPhone SE"))
//      .previewDisplayName("iPhone SE")

      
         
    }
    
  }
}

