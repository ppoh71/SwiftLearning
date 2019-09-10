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
  var sides: Double = 40
  var scale: Double = 1
  var opacity: Double = 1
  
  private var _scaleOff: Double = 0
  private var _scaleOn: Double = 1
  private var _opacityOff: Double = 0.4
  
  var disabled: Bool = false
  var imageName: String { type.imageName }

  // button sizw constants
  var buttonWidth: Double = 90
  
  // on/off properties
  var _rotation3DOn: Double = 0
  var _rotationOn: Double = 0
  
  var _rotation3DOff: Double = 0
  var _rotationOff: Double = 25
  
  // binding props
  var rotationDegrees: Double = 0
  var rotation3D: Double = 0
  
  
  init(id: Int, type: ButtonType) {
    self.id = id
    self.type = type
    self.rotationDegrees = _rotation3DOff
    self.rotation3D = _rotationOff
    
    switch type {
    
    case .NextToSetHeightGreenscreen, .NextToMaterialGreenscreen:
      _scaleOn = 0.85
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
    self.rotation3D = _rotation3DOn
    self.scale = _scaleOn
    self.opacity = 1
    self.disabled = false
  }
  
  mutating func buttonOff() {
    self.rotationDegrees = _rotationOff
    self.rotation3D = _rotation3DOff
    self.scale = _scaleOff
    self.opacity = _opacityOff
    self.disabled = true
  }
}
