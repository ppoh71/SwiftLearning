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
  @Binding var rotation: Double
  @Binding var rotation3D: Double
  @Binding var scale: Double

  func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(width: 50, height: 50, alignment: .center)
            .background(Image(systemName: "plus"))
            .rotationEffect(Angle(degrees: self.rotation))
            .rotation3DEffect(Angle(degrees: self.rotation3D), axis: (x: -10, y: -10, z: 0))
            .scaleEffect(CGFloat(self.scale))
            .animation(.easeInOut(duration: 0.6))
    }
}
  


