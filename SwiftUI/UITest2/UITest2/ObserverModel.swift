//
//  Observer.swift
//  UITest2
//
//  Created by Peter Pohlmann on 20.09.19.
//  Copyright © 2019 Peter Pohlmann. All rights reserved.
//

import SwiftUI
import Combine
import Foundation

enum itemType{
  case itemTypeA
  case itemTypeB
  case itemTypeC
}

struct ItemModel: Identifiable  {
  var id: Int
  var type: itemType
  var isTapped: Bool = false
}

class OberserverModel: ObservableObject {
  var didChange = PassthroughSubject<Void, Never>()
  
  @Published var itemA: ItemModel = ItemModel(id: 1, type: .itemTypeA)
  @Published var itemB: ItemModel = ItemModel(id: 2, type: .itemTypeB)
  @Published var itemC: ItemModel = ItemModel(id: 3, type: .itemTypeC)
  
  func toggleItem(itemType: itemType) {
    switch itemType {
    case .itemTypeA:
      itemA.isTapped.toggle()
    case .itemTypeB:
      itemB.isTapped.toggle()
    case .itemTypeC:
      itemC.isTapped.toggle()
    }
  }
}
