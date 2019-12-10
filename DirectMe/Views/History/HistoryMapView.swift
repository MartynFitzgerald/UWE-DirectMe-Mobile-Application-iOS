//
//  HistoryMapView.swift
//  DirectMe
//
//  Created by martyn on 14/11/2019.
//  Copyright © 2019 martyn.fitzgerald. All rights reserved.
//

import SwiftUI
import MapKit

struct HistoryMapView: UIViewRepresentable {
    var coordinate: CLLocationCoordinate2D

    func makeUIView(context: Context) -> MKMapView {
        MKMapView(frame: .zero)
    }

    func updateUIView(_ view: MKMapView, context: Context) {
        let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 250, longitudinalMeters: 250)
        view.setRegion(region, animated: true)
        
        let point = MKPointAnnotation()
        //Setting attibutes of MKPointAnnotation
        point.coordinate =  coordinate
        //Custom View for Annotation
        let annotationView = MKAnnotationView(annotation: point, reuseIdentifier: "customView")
        //Your custom image icon
        annotationView.image = UIImage(named: "circle")
        
        //self.parent.map.removeAnnotations(self.parent.map.annotations)
        view.addAnnotation(point)
        
    }
}

struct HistoryMapView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryMapView(coordinate: historyData[0].locationCoordinate)
    }
}
