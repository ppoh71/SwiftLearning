//
//  Mapview.swift
//  SwiftUI-Basics1
//
//  Created by Peter Pohlmann on 26.08.19.
//  Copyright © 2019 Peter Pohlmann. All rights reserved.
//

import SwiftUI
import MapKit

struct Mapview: UIViewRepresentable {
  
  func makeUIView(context: Context) -> MKMapView {
    MKMapView(frame: .zero)
  }
  
  func updateUIView(_ view: MKMapView, context: Context) {
      let coordinate = CLLocationCoordinate2D(
          latitude: 34.011286, longitude: -116.166868)
      let span = MKCoordinateSpan(latitudeDelta: 2.0, longitudeDelta: 2.0)
      let region = MKCoordinateRegion(center: coordinate, span: span)
      view.setRegion(region, animated: true)
  }
  
  
}

struct Mapview_Previews: PreviewProvider {
    static var previews: some View {
        Mapview()
    }
}
