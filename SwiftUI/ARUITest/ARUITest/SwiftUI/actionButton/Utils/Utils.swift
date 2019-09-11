//
//  Utils.swift
//  ARUITest
//
//  Created by Peter Pohlmann on 10.09.19.
//  Copyright © 2019 Peter Pohlmann. All rights reserved.
//

import Foundation
import UIKit
import SwiftUI

class Utils {
  class func hexStringToUIColor (hex:String) -> UIColor {
      var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
      
      if (cString.hasPrefix("#")) {
          cString.remove(at: cString.startIndex)
      }
      
      if ((cString.count) != 6) {
          return UIColor.gray
      }
      
      var rgbValue:UInt32 = 0
      Scanner(string: cString).scanHexInt32(&rgbValue)
      
      return UIColor(
          red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
          green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
          blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
          alpha: CGFloat(1.0)
      )
  }
  
  // This is a very basic implementation of a color interpolation
  // between two values.
  class func colorMixer(c1: UIColor, c2: UIColor, pct: CGFloat) -> Color {
      guard let cc1 = c1.cgColor.components else { return Color(c1) }
      guard let cc2 = c2.cgColor.components else { return Color(c1) }
      
      let r = (cc1[0] + (cc2[0] - cc1[0]) * pct)
      let g = (cc1[1] + (cc2[1] - cc1[1]) * pct)
      let b = (cc1[2] + (cc2[2] - cc1[2]) * pct)

      return Color(red: Double(r), green: Double(g), blue: Double(b))
  }
  
}
