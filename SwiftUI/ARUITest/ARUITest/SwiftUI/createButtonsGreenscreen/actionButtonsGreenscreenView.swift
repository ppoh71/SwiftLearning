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

/// This view defines the basic buttons to create a greenscreen
struct actionButtonsGreenscreenView: View {
  @EnvironmentObject var navController: actionButtonObserver
  
  var body: some View {
    let buttonAddBasepoints = ButtonView(buttonAction:$navController.buttonAddBasepointsGreenscreen)
    let buttonNextToHeight = ButtonView(buttonAction:$navController.buttonNextSetHeightGreenscreen)
    let buttonNextToMaterial = ButtonView(buttonAction:$navController.buttonNextMaterialGreenscreen)
    let widthDelta = CGFloat(navController.buttonAddBasepointsGreenscreen.buttonWidth/2)
    
    return GeometryReader { geometry in
      
      HStack(spacing: 40) {
        buttonAddBasepoints
        buttonNextToHeight
        buttonNextToMaterial
        Circle()
      }
      .position(x: geometry.size.width - widthDelta + self.navController.buttonsGreenscreenOffsetX, y: 80)
      .animation(.easeInOut(duration: 0.4))
      .frame(maxWidth: .infinity)
    }
  }
}

struct GSBasicActionButton_Previews: PreviewProvider {
  static var previews: some View {
    
    Group {
      actionButtonsGreenscreenView().environmentObject(actionButtonObserver())
        .previewDevice(PreviewDevice(rawValue: "iPhone X"))
        .previewDisplayName("iPhone X")
      
    }
    
  }
}
