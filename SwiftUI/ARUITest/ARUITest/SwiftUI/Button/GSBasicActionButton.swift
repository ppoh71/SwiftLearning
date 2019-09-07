//
//  GSBasicActionButton.swift
//  ARUITest
//
//  Created by Peter Pohlmann on 07.09.19.
//  Copyright © 2019 Peter Pohlmann. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

struct GSBasicActionButton: View {
  @EnvironmentObject var navController: NavController
  
  let but1 = ButtonAddBasePoints(buttonType: ButtonType.AddGroundPointsButton)
  let but2 = ButtonAddBasePoints(buttonType: ButtonType.SetHeightButton)
  let but3 = ButtonAddBasePoints(buttonType: ButtonType.NextToHeight)
  
  var body: some View {
    
    ZStack {
      but1
        .buttonStyle(ButtonStyle1(buttonCrt: $navController.button1))

      but2
        .buttonStyle(ButtonStyle1(buttonCrt: $navController.button2))

      HStack {
        Spacer()
        Spacer()
        Spacer()
        Spacer()
        Spacer()
        Spacer()
        
        but3
          .buttonStyle(ButtonStyle1(buttonCrt: $navController.button3 ))

        Spacer()
      }
      
    }
  }
}

struct GSBasicActionButton_Previews: PreviewProvider {
  static var previews: some View {
    
    
    Group {
      GSBasicActionButton().environmentObject(NavController())
        .previewDevice(PreviewDevice(rawValue: "iPhone XS Max"))
        .previewDisplayName("iPhone XS Max")
      
    }
    
  }
}
