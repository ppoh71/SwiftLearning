//
//  SwiftUITest1.swift
//  ARUITest
//
//  Created by Peter Pohlmann on 27.08.19.
//  Copyright © 2019 Peter Pohlmann. All rights reserved.
//

import SwiftUI

struct SwiftUITest1: View {
    var body: some View {
      
      ZStack{
    
       Image("1")
        .scaledToFill()
        .frame(height: 200)
        .clipped()
        
        Button(action: {
          print("Button pressed")
        }
        
        ) {
          Text("Button")
            .background(Color.green)
        }
        
      }
    }
}

struct SwiftUITest1_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUITest1()
    }
}
