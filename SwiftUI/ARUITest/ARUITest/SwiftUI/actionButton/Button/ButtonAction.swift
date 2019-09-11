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
  var scale: Double = 1
  var opacity: Double = 1
  
  /// internal animation properties
  /// will be assigned to binding properties
  private var _scaleOff: Double = 0
  private var _scaleOn: Double = 1
  private var _opacityOff: Double = 0.4
  private var _rotationOn: Double = 0
  private var _rotationOff: Double = 125
  
  /// binding properties
  var rotationDegrees: Double = 0
  var rotation3D: Double = 0
  var disabled: Bool = false
  var imageName: String { type.imageName }
  var buttonWidth: Double = 90
  
  init(id: Int, type: ButtonType) {
    self.id = id
    self.type = type
    self.rotation3D = _rotationOff
    
    switch type {
    
    case .NextToSetHeightGreenscreen, .NextToMaterialGreenscreen:
      _scaleOn = 1
      _scaleOff = 0.5
      _opacityOff = 0
    default:
      _scaleOn = 1
      _scaleOff = 0.5
      _opacityOff = 0
    }
  }
  
  mutating func buttonInactive() {
    self.rotationDegrees = _rotationOn
    self.scale = _scaleOff
    self.opacity = 0.5
    self.disabled = false
  }
  
  mutating func buttonOn() {
    self.rotationDegrees = _rotationOn
    self.scale = _scaleOn
    self.opacity = 1
    self.disabled = false
  }
  
  mutating func buttonOff() {
    self.rotationDegrees = _rotationOff
    self.scale = _scaleOff
    self.opacity = _opacityOff
    self.disabled = true
  }
}
