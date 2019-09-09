//
//  Mapper.swift
//  ARUITest
//
//  Created by Peter Pohlmann on 27.08.19.
//  Copyright © 2019 Peter Pohlmann. All rights reserved.
//
import SwiftUI
import Combine

enum ButtonType {
  case AddGroundPointsButton
  case SetHeightButton
  case NextToHeight
  case NextToMaterial
  
  var imageName: String{
    switch self {
    case .AddGroundPointsButton:
      return "plus"
    case .SetHeightButton:
      return "heart"
    case .NextToHeight:
      return "arrow.right"
    case .NextToMaterial:
      return "arrow.right"
    }
  }
}

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
  @Published var actionState:ActionState = .none
  
  @Published var button1: ButtonAction = ButtonAction(id: 1, type: .AddGroundPointsButton)
  @Published var button2: ButtonAction = ButtonAction(id: 2, type: .SetHeightButton)
  @Published var button3: ButtonAction = ButtonAction(id: 3, type: .NextToHeight)
  
  @Published var showNextButtonToHeight = false
  
  
  func printMessage() {
    print("Message Print from xxx")
  }
  
  func showGreensceenAddBasePoints() {
    self.button2.buttonOff()
    self.button3.buttonOff()
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.32) {
      self.button1.buttonOn()
    }
  }
  
  func showHeightSettingsButton() {
    button1.buttonOff()
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.32) {
      self.button2.buttonOn()
      self.button3.buttonOff()
    }
  }
  
  func setHeightForGreenscreen() {
    //self.actionState = .setHeightForGreenscreen
  }
  
  func createGreenscreenBasePoints() {
    print("Add basepoint")
    //self.actionState = .createBaselinesForGreenscreen
    
    basePoints.append(212)
    
    if basePoints.count > 1 {
      print("button on")
      self.button3.buttonOn()
    }
    
  }
  
  func switchActionAddGreenscreenBasePoints() {
    self.actionState = .createBaselinesForGreenscreen
  }
  
  func setHeight() {
    self.heightIsSet.toggle()
    
    switch self.heightIsSet {
    case true:
      button3.buttonOff()
      
    case false:
      //do action to set height
      button3.buttonOn()
      button3.type = .NextToMaterial
      
    }
    
  }
  
  
  func switchActionToNone() {
    self.actionState = .none
  }
  
}



