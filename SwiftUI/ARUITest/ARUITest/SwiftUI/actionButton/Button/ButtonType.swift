//
//  ButtonTypeEnum.swift
//  ARUITest
//
//  Created by Peter Pohlmann on 10.09.19.
//  Copyright © 2019 Peter Pohlmann. All rights reserved.
//

import Foundation
import UIKit

enum ButtonType {
  case AddBasepointsGreenscreen
  case SetHeightGreenscreen
  case NextToSetHeightGreenscreen
  case NextToMaterialGreenscreen
  case SpacerButton
  
  var imageName: String{
    switch self {
    case .AddBasepointsGreenscreen:
      return "plus"
    case .SetHeightGreenscreen:
      return "heart"
    case .NextToSetHeightGreenscreen:
      return "arrow.right"
    case .NextToMaterialGreenscreen:
      return "arrow.right"
    case .SpacerButton:
      return "trash"
    }
  }
  
  var gradient1: [UIColor] {
    switch self {
    case .AddBasepointsGreenscreen:
      return [Utils.hexStringToUIColor(hex: "#dd3e54"), Utils.hexStringToUIColor(hex: "#6be585")]
    case .SetHeightGreenscreen:
       return [Utils.hexStringToUIColor(hex: "#22c1c3"), Utils.hexStringToUIColor(hex: "#fdbb2d")]
    case .NextToSetHeightGreenscreen, .NextToMaterialGreenscreen:
       return [Utils.hexStringToUIColor(hex: "#11998e"), Utils.hexStringToUIColor(hex: "#38ef7d")]
    case .SpacerButton:
      return [Utils.hexStringToUIColor(hex: "#ffffff"), Utils.hexStringToUIColor(hex: "#ffffff")]
    }
  }
  
  var gradient2: [UIColor] {
    switch self {
    case .AddBasepointsGreenscreen:
      return [Utils.hexStringToUIColor(hex: "#e1eec3"), Utils.hexStringToUIColor(hex: "#f05053")]
    case .SetHeightGreenscreen:
      return [Utils.hexStringToUIColor(hex: "#8A2387"), Utils.hexStringToUIColor(hex: "#E94057")]
     
    case .NextToSetHeightGreenscreen, .NextToMaterialGreenscreen:
       return [Utils.hexStringToUIColor(hex: "#1D976C"), Utils.hexStringToUIColor(hex: "#93F9B9")]
    case .SpacerButton:
      return [Utils.hexStringToUIColor(hex: "#ffffff"), Utils.hexStringToUIColor(hex: "#ffffff")]
    }
  }
  
}
