//
//  ItemView.swift
//  UITest2
//
//  Created by Peter Pohlmann on 20.09.19.
//  Copyright © 2019 Peter Pohlmann. All rights reserved.
//

import SwiftUI

struct ItemView: View {
  @EnvironmentObject var observer: ObserverModel
  @Binding var itemBinding: ItemModel
  @State private var toggleColor = Color.red
  
  var body: some View {
    Rectangle()
      .fill(toggleColor)
      .frame(width: 100, height: 50)
      .onTapGesture{
        self.observer.toggleItem(itemType: self.itemBinding.type)
        self.toggleColor = self.itemBinding.isTapped ? Color.green : Color.red
        
        print("Item Bool: \(self.itemBinding.isTapped)")
    }
  }
}

struct ItemView_Previews: PreviewProvider {
  static var previews: some View {
    ItemView(itemBinding: .constant(ItemModel(id: 1, type: .itemTypeA))).environmentObject(ObserverModel())
  }
}
