//
//  CircleImage.swift
//  SwiftUI-Basics1
//
//  Created by Peter Pohlmann on 26.08.19.
//  Copyright © 2019 Peter Pohlmann. All rights reserved.
//

import SwiftUI

struct CircleImage: View {
    var body: some View {
      Image("turtlerock")
      .clipShape(Circle())
      .overlay(
        Circle().stroke(Color.white, lineWidth: 5))
      .shadow(radius: 10)
    }
}

struct CircleImage_Previews: PreviewProvider {
    static var previews: some View {
        CircleImage()
    }
}
