//
//  ButtonStyles.swift
//  ARUITest
//
//  Created by Peter Pohlmann on 30.08.19.
//  Copyright © 2019 Peter Pohlmann. All rights reserved.
//

import Foundation

import SwiftUI

struct BasicButtonStyle: ButtonStyle {

  @Binding var buttonCrt: ButtonAction
  
  func makeBody(configuration: Configuration) -> some View {
    configuration.label
      //
      //.rotationEffect(Angle(degrees: self.buttonCrt.rotationDegrees))
      //.rotation3DEffect(Angle(degrees: self.buttonCrt.rotation3D), axis: (x: buttonCrt.axisX, y: buttonCrt.axisY, z: buttonCrt.axisZ))
    //  .scaleEffect(CGFloat(self.buttonCrt.scale))
    //  .opacity(self.buttonCrt.opacity)
    //  .frame(width: 80, height: 80, alignment: .center)
    //  .animation(.easeInOut(duration: 0.4))
  }
}



