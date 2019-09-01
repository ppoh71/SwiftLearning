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
  
  @Published var rotationDegrees: Double = -40
  @Published var rotation3D: Double = -190
  @Published var scale: Double = 0.6
  @Published var imageName: String = "trash"
  
  func changeValues(actionState: ActionState) {
    print("navController 1")
    self.rotationDegrees = Double.random(in: -270..<360)
    self.rotation3D = Double.random(in: -270..<360)
    self.scale = 0.01
  
    let deadlineTime = DispatchTime.now() + 0.3
    DispatchQueue.main.asyncAfter(deadline: deadlineTime) {
      print("navController 2")
      self.actionState = actionState
      self.setImageName(state: self.actionState)
      self.rotationDegrees = 360
      self.rotation3D = 0
      self.scale = 1.2
    }
  }
  
  func setImageName(state: ActionState) {
    switch state {
      case .createBaselinesForGreenscreen:
        self.imageName = "plus"
      case .setHeightForGreenscreen:
         self.imageName = "link"
      default:
        print("Default")
    }
  }
  
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


