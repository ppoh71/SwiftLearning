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
  @Published var buttonNextOffsetX: CGFloat = 0
  
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
    self.buttonNextOffsetX = 0
    self.buttonNextSetHeightGreenscreen.type = .SetHeightGreenscreen
   
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.32) {
      self.buttonAddBasepointsGreenscreen.buttonOn()
      self.buttonNextSetHeightGreenscreen.buttonOff()
    }
  }
  
  func showButtonSetHeightGreenscreen() {
    self.buttonsGreenscreenOffsetX = -130
    
    
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.32) {
      self.buttonNextMaterialGreenscreen.buttonOff()
      self.buttonNextSetHeightGreenscreen.type = .SetHeightGreenscreen
      self.buttonNextSetHeightGreenscreen.buttonOn()
      self.buttonAddBasepointsGreenscreen.buttonOff()
    }
  }
  
  /// Action Button Greenscreen
  func actionAddBasepointsGreenscreen() {
    print("Add basepoint")
    basePoints.append(212) //debug
    
    if basePoints.count > 1 {
      self.buttonNextSetHeightGreenscreen.type = .NextToSetHeightGreenscreen
      self.buttonNextSetHeightGreenscreen.buttonOn()
      self.buttonNextMaterialGreenscreen.buttonOff()
    }
  }
  
  func actionSetHeightGreenscreen() {
    self.heightIsSet.toggle()
    
    switch self.heightIsSet {
    case true:
      self.buttonNextMaterialGreenscreen.buttonOff()
    case false:
      //do action to set height
      self.buttonNextMaterialGreenscreen.buttonOn()
    }
  }
  
  func showMaterial() {
    self.buttonsGreenscreenOffsetX = -260
    
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.32) {
      self.buttonNextSetHeightGreenscreen.buttonOff()
      self.buttonAddBasepointsGreenscreen.buttonOff()
      
      
      
    }
  }
  
  
  func switchActionToNone() {
    self.actionState = .none
  }
  
}



