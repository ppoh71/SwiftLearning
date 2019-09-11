//
//  Mapper.swift
//  ARUITest
//
//  Created by Peter Pohlmann on 27.08.19.
//  Copyright © 2019 Peter Pohlmann. All rights reserved.
//
import SwiftUI
import Combine

/// Source of Truth for buttons to create the greenscreen shape

class actionButtonObserver: ObservableObject {
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
  
  var basePoints = [Int]()
  var heightIsSet = false
  var animationDuration = 0.32
  
  @Published var test = "Test String"
  @Published var actionState: ActionState = .none
  @Published var buttonsGreenscreenOffsetX: CGFloat = 0
  
  @Published var buttonSpacer: ButtonAction = ButtonAction(id: 0, type: .SpacerButton)
  @Published var buttonAddBasepointsGreenscreen: ButtonAction = ButtonAction(id: 1, type: .AddBasepointsGreenscreen)
  @Published var buttonNextSetHeightGreenscreen: ButtonAction = ButtonAction(id: 3, type: .NextToSetHeightGreenscreen)
  @Published var buttonNextMaterialGreenscreen: ButtonAction = ButtonAction(id: 4, type: .NextToMaterialGreenscreen)
  
  @Published var showNextButtonToHeight = false
  

  /// Show button  for adding basepoint
  /// & hide others
  func showButtonAddBasepointsGreenscreen() {
    self.buttonsGreenscreenOffsetX = 0
    self.buttonNextSetHeightGreenscreen.type = .SetHeightGreenscreen
   
    DispatchQueue.main.asyncAfter(deadline: .now() + animationDuration) {
      self.buttonAddBasepointsGreenscreen.buttonOn()
      self.buttonNextSetHeightGreenscreen.buttonOff()
    }
  }
  
  /// Show button  for setting height of greenscreen
  /// & hide others
  func showButtonSetHeightGreenscreen() {
    // actionState = .setHeightForGreenscreen
    self.buttonsGreenscreenOffsetX = -130

    DispatchQueue.main.asyncAfter(deadline: .now() + animationDuration) {
      self.buttonNextSetHeightGreenscreen.type = .SetHeightGreenscreen
      self.buttonNextSetHeightGreenscreen.buttonOn()
      
      self.buttonNextMaterialGreenscreen.buttonOff()
      self.buttonAddBasepointsGreenscreen.buttonOff()
    }
  }
  
  /// Action when new basepoint for greenscreen was added
  /// by tapping on buttonAddBasepointsGreenscreen
  ///
  /// Set actionState for arView and handle button states
  func actionAddBasepointsGreenscreen() {
    print("Add basepoint")
    basePoints.append(212) //debug
    
    if basePoints.count > 1 {
      self.buttonNextSetHeightGreenscreen.type = .NextToSetHeightGreenscreen
      self.buttonNextSetHeightGreenscreen.buttonOn()
      self.buttonNextMaterialGreenscreen.buttonOff()
    }
  }
  
  /// Action when height for greenscreen was set
  /// by tapping on buttonNextSetHeightGreenscreen
  ///
  /// Set actionState for arView and handle button states
  func actionSetHeightGreenscreen() {
    // action State finish set height
    self.heightIsSet.toggle()
    
    switch self.heightIsSet {
    case true:
      self.buttonNextMaterialGreenscreen.buttonOn()
    case false:
      //do action to set height
      self.buttonNextMaterialGreenscreen.buttonOff()
    }
  }
  
  func showMaterial() {
    self.buttonsGreenscreenOffsetX = -260
    
    DispatchQueue.main.asyncAfter(deadline: .now() + animationDuration) {
      self.buttonNextSetHeightGreenscreen.buttonOff()
      self.buttonAddBasepointsGreenscreen.buttonOff()
    }
  }
  
  func switchActionToNone() {
    self.actionState = .none
  }
  
  func printMessage() {
    print("Message Print from xxx")
  }
}



