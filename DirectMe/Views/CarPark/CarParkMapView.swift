//
//  HistoryMapView.swift
//  DirectMe
//
//  Created by martyn on 14/11/2019.
//  Copyright © 2019 martyn.fitzgerald. All rights reserved.
//

import SwiftUI
import MapKit

//Creating the map view at the top.
struct CarParkMapView: UIViewRepresentable {
    //Create coodinate as a perameters.
    var coordinate: CLLocationCoordinate2D
    //Make the map view on page.
    func makeUIView(context: Context) -> MKMapView {
        MKMapView(frame: .zero)
    }
    //Set pin and region.
    func updateUIView(_ view: MKMapView, context: Context) {
        //Set region to location entered.
        let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 250, longitudinalMeters: 250)
        view.setRegion(region, animated: true)
        let point = MKPointAnnotation()
        //Setting attibutes of MKPointAnnotation.
        point.coordinate =  coordinate
        //Custom View for Annotation.
        let annotationView = MKAnnotationView(annotation: point, reuseIdentifier: "customView")
        //Your custom image icon.
        annotationView.image = UIImage(named: "circle")
        //self.parent.map.removeAnnotations(self.parent.map.annotations).
        view.addAnnotation(point)
    }
}

struct CarParkMapView_Previews: PreviewProvider {
    static var previews: some View {
        CarParkMapView(coordinate: carParksData[0].locationCoordinate)
    }
}
