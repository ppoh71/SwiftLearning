//
//  SwiftUITest1.swift
//  ARUITest
//
//  Created by Peter Pohlmann on 27.08.19.
//  Copyright © 2019 Peter Pohlmann. All rights reserved.
//

import SwiftUI

struct SwiftUITest1: View {
  @EnvironmentObject var navController: NavController
  
    var body: some View {
       ZStack{
           ButtonSUI()
              .buttonStyle(OutlineStyle())
         }
    }
  
  func doThings() {
    navController.printMessage()
  }
  
}



struct SwiftUITest1_Previews: PreviewProvider {
    static var previews: some View {
      SwiftUITest1().environmentObject(NavController())
    }
}
