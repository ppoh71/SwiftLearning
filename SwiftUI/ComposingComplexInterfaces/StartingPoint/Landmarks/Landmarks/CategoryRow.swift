//
//  CategoryRow.swift
//  Landmarks
//
//  Created by Peter Pohlmann on 27.08.19.
//  Copyright © 2019 Apple. All rights reserved.
//

import SwiftUI

struct CategoryRow: View {
    var categoryName: String
    var items: [Landmark]
    
    var body: some View {
        Text(self.categoryName)
            .font(.headline)
    }
}

struct CategoryRow_Previews: PreviewProvider {
    static var previews: some View {
        CategoryRow(
            categoryName: landmarkData[0].category.rawValue,
            items: Array(landmarkData.prefix(3))
        )
    }
}
