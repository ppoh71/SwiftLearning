//
//  ItemView.swift
//  UITest2
//
//  Created by Peter Pohlmann on 20.09.19.
//  Copyright © 2019 Peter Pohlmann. All rights reserved.
//

import SwiftUI

struct ItemView: View {
  @EnvironmentObject var observer: OberserverModel
  @Binding var itemBinding: ItemModel
  
  var body: some View {
    Rectangle()
      .frame(width: 100, height: 50)
      .onTapGesture{
        self.observer.toggleItem(itemType: self.itemBinding.type)
        print("Item Bool: \(self.itemBinding.isTapped)")
    }
  }
}

struct ItemView_Previews: PreviewProvider {
  static var previews: some View {
    ItemView(itemBinding: .constant(ItemModel(id: 1, type: .itemTypeA))).environmentObject(OberserverModel())
  }
}
