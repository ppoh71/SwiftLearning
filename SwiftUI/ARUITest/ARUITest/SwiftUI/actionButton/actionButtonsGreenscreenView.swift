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

struct actionButtonsGreenscreenView: View {
  @EnvironmentObject var navController: NavController
  
  let but1 = ButtonView(buttonType: ButtonType.AddGroundPointsButton)
  let but2 = ButtonView(buttonType: ButtonType.SetHeightButton)
  let but3 = ButtonView(buttonType: ButtonType.NextToHeight)
  
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
      actionButtonsGreenscreenView().environmentObject(NavController())
        .previewDevice(PreviewDevice(rawValue: "iPhone XS Max"))
        .previewDisplayName("iPhone XS Max")
      
    }
    
  }
}
