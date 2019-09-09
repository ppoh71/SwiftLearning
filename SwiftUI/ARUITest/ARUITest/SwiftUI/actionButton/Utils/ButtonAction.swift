//
//  ButtonAnimationValues.swift
//  ARUITest
//
//  Created by Peter Pohlmann on 09.09.19.
//  Copyright © 2019 Peter Pohlmann. All rights reserved.
//

import Foundation
import SwiftUI

struct ButtonAction: Identifiable {
  var id: Int
  var type: ButtonType
  var sides: Double = 8
  var scale: Double = 1
  var opacity: Double = 0
  var imageName: String { type.imageName }
  
  var axisX: CGFloat = 0
  var axisY: CGFloat = 0
  var axisZ: CGFloat = 0
  
  // on/off properties
  var _rotation3DOn: Double = 0
  var _rotationOn: Double = 0
  var _rotation3DOff: Double = 0
  var _rotationOff: Double = 90
  
  // binding props
  var rotationDegrees: Double = 0
  var rotation3D: Double = 0
  
  init(id: Int, type: ButtonType) {
    self.id = id
    self.type = type
    self.rotationDegrees = _rotation3DOff
    self.rotation3D = _rotationOff
  }
  
  mutating func buttonOn() {
    self.rotationDegrees = _rotationOn
    self.rotation3D = _rotation3DOn
    self.scale = 1
    self.opacity = 1
  }
  
  mutating func buttonOff() {
    self.rotationDegrees = _rotationOff
    self.rotation3D = _rotation3DOff
    self.scale = 0.4
    self.opacity = 0
  }
}
