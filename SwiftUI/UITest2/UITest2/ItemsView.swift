//
//  ItemsView.swift
//  UITest2
//
//  Created by Peter Pohlmann on 20.09.19.
//  Copyright © 2019 Peter Pohlmann. All rights reserved.
//

import SwiftUI

struct ItemsView: View {
  @EnvironmentObject var observer: ObserverModel
  
    var body: some View {
      HStack {
        ItemView(itemBinding: $observer.itemA)
        ItemView(itemBinding: $observer.itemB)
        ItemView(itemBinding: $observer.itemC)
      }
    }
}

struct ItemsView_Previews: PreviewProvider {
    static var previews: some View {
      ItemsView().environmentObject(ObserverModel())
    }
}
