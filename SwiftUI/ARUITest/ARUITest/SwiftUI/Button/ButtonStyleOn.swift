//
//  ButtonStyleOn.swift
//  ARUITest
//
//  Created by Peter Pohlmann on 31.08.19.
//  Copyright © 2019 Peter Pohlmann. All rights reserved.
//

import Foundation

import SwiftUI

struct ButtonStyleOn: ButtonStyle {

  func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(width: 50, height: 50, alignment: .center)
            .background(Image(systemName: "plus"))
            .rotationEffect(Angle(degrees: Double(-280)))
            .rotation3DEffect(Angle(degrees: -289), axis: (x: -10, y: -10, z: 0))
            .scaleEffect(CGFloat(1))
            //.offset(x: self.xOffset, y: 0)
            .animation(.easeInOut(duration: 0.6))
    }
}
  
