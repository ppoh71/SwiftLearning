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

  enum ActionState {
    case none
    case createBaselinesForGreenscreen
    case setHeightForGreenscreen
    case finishedCreatingGreenscreen
    case greenscreenAspectRatioResize
    case displayAspectRatioResize
    case prepareToAddDisplay
    case addDisplay
    case moveActiveDisplay
    case finishedMoveDisplay
    case prepareForResizeDisplay
    case resizeDisplay
  }
  
  @Published var test = "Test String"
  @Published var actionState:ActionState = .none
  
  
  func printMessage() {
    print("Message Print from xxx")
  }
  
  func setHeightForGreenscreen() {
    self.actionState = .setHeightForGreenscreen
  }
  
  func createGreenscreenBasePoints() {
    self.actionState = .createBaselinesForGreenscreen
  }
  
  func switchActionAddGreenscreenBasePoints() {
    self.actionState = .createBaselinesForGreenscreen
  }
  
  func switchActionToNone() {
    self.actionState = .none
  }
  
}


