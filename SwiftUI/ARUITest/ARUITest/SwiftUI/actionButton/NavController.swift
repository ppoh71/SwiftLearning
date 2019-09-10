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
  
  var basePoints = [Int]()
  var heightIsSet = false
  
  @Published var test = "Test String"
  @Published var actionState: ActionState = .none
  @Published var buttonsGreenscreenOffsetX: CGFloat = 0
  
  @Published var buttonSpacer: ButtonAction = ButtonAction(id: 0, type: .SpacerButton)
  @Published var buttonAddBasepointsGreenscreen: ButtonAction = ButtonAction(id: 1, type: .AddBasepointsGreenscreen)
  @Published var buttonSetHeightGreenscreen: ButtonAction = ButtonAction(id: 2, type: .SetHeightGreenscreen)
  @Published var buttonNextSetHeightGreenscreen: ButtonAction = ButtonAction(id: 3, type: .NextToSetHeightGreenscreen)
  @Published var buttonNextMaterialGreenscreen: ButtonAction = ButtonAction(id: 4, type: .NextToMaterialGreenscreen)
  
  @Published var showNextButtonToHeight = false
  
  func printMessage() {
    print("Message Print from xxx")
  }
  
  func showButtonAddBasepointsGreenscreen() {
    self.buttonsGreenscreenOffsetX = 0
    self.buttonSetHeightGreenscreen.buttonOff()
    self.buttonNextSetHeightGreenscreen.buttonOff()
    self.buttonNextMaterialGreenscreen.buttonOff()
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.32) {
      self.buttonAddBasepointsGreenscreen.buttonOn()
    }
  }
  
  func showButtonSetHeightGreenscreen() {
    self.buttonsGreenscreenOffsetX = -220
    buttonAddBasepointsGreenscreen.buttonOff()
    buttonNextSetHeightGreenscreen.buttonOff()
    buttonNextMaterialGreenscreen.buttonOff()
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.32) {
      self.buttonSetHeightGreenscreen.buttonOn()
    }
  }
  
  /// Action Button Greenscreen
  func actionAddBasepointsGreenscreen() {
    print("Add basepoint")
    basePoints.append(212) //debug
    
    if basePoints.count > 1 {
      self.buttonNextSetHeightGreenscreen.buttonOn()
      self.buttonNextMaterialGreenscreen.buttonOff()
    }
  }
  
  func actionSetHeightGreenscreen() {
    self.heightIsSet.toggle()
    
    switch self.heightIsSet {
    case true:
      self.buttonNextSetHeightGreenscreen.buttonOff()
      self.buttonNextMaterialGreenscreen.buttonOn()
    case false:
      //do action to set height
      self.buttonNextSetHeightGreenscreen.buttonOff()
      self.buttonNextMaterialGreenscreen.buttonOff()
    }
  }
  
  func showMaterial() {
    self.buttonsGreenscreenOffsetX = -380
  }
  
  

  
  
  func switchActionToNone() {
    self.actionState = .none
  }
  
}



