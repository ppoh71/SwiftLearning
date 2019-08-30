//
//  Mapper.swift
//  ARUITest
//
//  Created by Peter Pohlmann on 27.08.19.
//  Copyright © 2019 Peter Pohlmann. All rights reserved.
//
import SwiftUI
import Combine


class NavController: ObservableObject {
  var didChange = PassthroughSubject<Void, Never>()
  
  @Published var test = "Test String"
  
  func printMessage() {
    print("Message Print from xxx")
  }
}


