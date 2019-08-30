//
//  ButtonStyles.swift
//  ARUITest
//
//  Created by Peter Pohlmann on 30.08.19.
//  Copyright © 2019 Peter Pohlmann. All rights reserved.
//

import Foundation

import SwiftUI

struct OutlineStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            //.foregroundColor(Color.green)
            //.background(RoundedRectangle(cornerRadius: 8).fill(Color.green))
    }
}
