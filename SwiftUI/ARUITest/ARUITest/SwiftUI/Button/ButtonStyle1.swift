//
//  ButtonStyles.swift
//  ARUITest
//
//  Created by Peter Pohlmann on 30.08.19.
//  Copyright © 2019 Peter Pohlmann. All rights reserved.
//

import Foundation

import SwiftUI

struct ButtonStyle1: ButtonStyle {
  //  @Binding var rotation: Double
  //  @Binding var rotation3D: Double
  //  @Binding var scale: Double
  //  @Binding var imageName: String
  @Binding var buttonCrt: ButtonControll
  
  func makeBody(configuration: Configuration) -> some View {
    configuration.label
      .frame(width: 50, height: 50, alignment: .center)
      //.background(Image(systemName: self.buttonCrt.imageName))
      .rotationEffect(Angle(degrees: self.buttonCrt.rotationDegrees))
      .rotation3DEffect(Angle(degrees: self.buttonCrt.rotation3D), axis: (x: -10, y: -10, z: 0))
      .scaleEffect(CGFloat(self.buttonCrt.scale))
      .opacity(self.buttonCrt.opacity)
      .animation(.easeInOut(duration: 0.6))
  }
}



