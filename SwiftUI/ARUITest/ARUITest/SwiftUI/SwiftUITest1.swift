//
//  SwiftUITest1.swift
//  ARUITest
//
//  Created by Peter Pohlmann on 27.08.19.
//  Copyright © 2019 Peter Pohlmann. All rights reserved.
//

import SwiftUI

struct SwiftUITest1: View {
  @EnvironmentObject var navController: actionButtonObserver
  @State private var showGSBasic = false
  @State private var selection = 0

  var body: some View {

    VStack {
      
      HStack{
        Picker("", selection: $selection) {
          Text("Shape").tag(1)
            .font(.headline)
          Text("Height").tag(2)
           .font(.headline)
          Text("Material").tag(3)
           .font(.headline)
        }
          
        .pickerStyle(SegmentedPickerStyle())
        .background(RoundedRectangle(cornerRadius: 8)
        
        .stroke(Color.red, lineWidth: selection == 0 ? 1 : 0)) .padding()
      }
      
      HStack {
        Button(action: {
          self.navController.showButtonAddBasepointsGreenscreen()
        
        }) {
          Text("Add BasePoints")
        }
        
        Button(action: {
          self.navController.showButtonSetHeightGreenscreen()
        }) {
          Text("Set Height")
        }
        
        Button(action: {
          self.navController.showMaterial()
        }) {
          Text("Reset")
        }
      }
      HStack {
             actionButtonsGreenscreenView()
               .frame(maxWidth: .infinity)
             
         }
      }
      .frame(maxWidth: .infinity)
      .background(Color.clear)
    }
  

}



struct SwiftUITest1_Previews: PreviewProvider {
  static var previews: some View {
    
    
    Group {
       SwiftUITest1().environmentObject(actionButtonObserver())
      .previewDevice(PreviewDevice(rawValue: "iPhone X"))
      .previewDisplayName("iPhone X")
      
      SwiftUITest1().environmentObject(actionButtonObserver())
      .previewDevice(PreviewDevice(rawValue: "iPhone 8"))
      .previewDisplayName("iPhone 8")

      
    }
    
  }
}

