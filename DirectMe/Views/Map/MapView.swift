//
//  MapView.swift
//  DirectMe
//
//  Created by martyn on 13/11/2019.
//  Copyright © 2019 martyn.fitzgerald. All rights reserved.
//

import SwiftUI
import MapKit

struct MapView: View {
    @State var locationManager = CLLocationManager()
    var body: some View {
        NavigationView {
            TestMapView(locationManager: $locationManager)
            .navigationBarTitle(Text("Map"), displayMode: .inline)
            .navigationBarItems(leading:
                Button(action: {
                    print("Tapped")
                }, label: {
                    HStack{
                        Image(systemName: "square.and.arrow.up")
                        .resizable()
                        .frame(width: 20.0, height: 20.0, alignment: .center)
                        .rotationEffect(.degrees(-90))
                    }
                })
            )
        }
    }
}

struct TestMapView: UIViewRepresentable {
    @Binding var locationManager : CLLocationManager
    let map = MKMapView(frame: .zero)
    
    func makeCoordinator() -> TestMapView.Coordinator {
        return Coordinator(parent1: self)
    }
    
    func makeUIView(context: UIViewRepresentableContext<TestMapView>) -> MKMapView {
        let center = CLLocationCoordinate2D(latitude: 51.454514, longitude: -2.587910)
        let region = MKCoordinateRegion(center: center, latitudinalMeters: 1000, longitudinalMeters: 1000)
        map.region = region
        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = context.coordinator
        locationManager.startUpdatingLocation()
        map.showsUserLocation = true
        return map
    }

    func updateUIView(_ view: MKMapView, context: Context) {
        
    }
    
    class Coordinator : NSObject, CLLocationManagerDelegate{
        
        var parent : TestMapView
        
        init(parent1 : TestMapView){
            parent = parent1
        }
        
        func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
            if status == .denied{
                
            }
        }
        
        func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            let location = locations.last!
            let point = MKPointAnnotation()
            
            let georeader = CLGeocoder()
            georeader.reverseGeocodeLocation(location) { (places ,err) in
                if err != nil{
                    print((err?.localizedDescription)!)
                    return
                }
                //let place = places?.first?.locality
                //point.title = place
                point.title = "Your Location!"
                point.subtitle = "Current"
                point.coordinate = location.coordinate
                //Custom View for Annotation
                 //let annotationView = MKAnnotationView(annotation: point, reuseIdentifier: "customView")
                 //annotationView.canShowCallout = true
                 //Your custom image icon
                 //annotationView.image = UIImage(named: "locationPin")
                
                //self.parent.map.removeAnnotations(self.parent.map.annotations)
                //self.parent.map.addAnnotation(point)
                
                let region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
                self.parent.map.region = region
            }
        }
        
    }
}

struct MapView_Preview: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
