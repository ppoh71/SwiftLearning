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


struct ButtonControll: Identifiable {
  var id: Int
  var type: ButtonType
  var sides: Double = 8
  var rotationDegrees: Double = -40
  var rotation3D: Double = -190
  var scale: Double = 1
  var opacity: Double = 0
  var imageName: String { type.imageName }
    
  mutating func buttonOn() {
    self.rotationDegrees = 0
    self.rotation3D = 0
    self.scale = 1
    self.opacity = 1
  }
  
  mutating func buttonOff() {
    self.rotationDegrees = -180
    self.rotation3D = -190
    self.scale = 0.5
    self.opacity = 0
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
  
  @Published var button1: ButtonControll = ButtonControll(id: 1, type: .AddGroundPointsButton)
  @Published var button2: ButtonControll = ButtonControll(id: 2, type: .SetHeightButton)
  @Published var button3: ButtonControll = ButtonControll(id: 3, type: .NextToHeight)
  
  @Published var showNextButtonToHeight = false
  
  
  func printMessage() {
    print("Message Print from xxx")
  }
  
  
  func setHeightForGreenscreen() {
    //self.actionState = .setHeightForGreenscreen
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


