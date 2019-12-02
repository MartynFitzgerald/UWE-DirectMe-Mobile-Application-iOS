//
//  AppleMapView.swift
//  DirectMe
//
//  Created by martyn on 19/11/2019.
//  Copyright © 2019 martyn.fitzgerald. All rights reserved.
//

import SwiftUI
import MapKit

struct AppleMapView: UIViewRepresentable {
    func makeUIView(context: Context) -> MKMapView {
        MKMapView(frame: .zero)
    }

    func updateUIView(_ view: MKMapView, context: Context) {
        let coordinate = CLLocationCoordinate2D(
            latitude: 51.4545, longitude: -2.5879)
        let span = MKCoordinateSpan(latitudeDelta: 0.25, longitudeDelta: 0.25)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        view.setRegion(region, animated: true)
    }
}
struct AppleMapView_Previews: PreviewProvider {
    static var previews: some View {
        AppleMapView()
    }
}