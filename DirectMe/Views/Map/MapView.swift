//
//  MapView.swift
//  DirectMe
//
//  Created by martyn on 13/11/2019.
//  Copyright © 2019 martyn.fitzgerald. All rights reserved.
//

import SwiftUI
import MapKit

var map = MKMapView(frame: .zero)

struct MapView: View {
    @State var locationManager = CLLocationManager()
    @State private var location:String = ""
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .top) {
                MainMapView(locationManager: $locationManager)
                TextField("Enter Location...", text: $location)
                    //.font(.system(size: 25))
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .background(Color.white)
                    .foregroundColor(.black)
                    .padding(20)
                    .modifier(textFieldButton(text: $location, locationManager: $locationManager))
            }
            .navigationBarTitle(Text("Map").font(.system(size:50)), displayMode: .inline)
        }
    }
}

struct MainMapView: UIViewRepresentable {
    @Binding var locationManager : CLLocationManager
    //let map = MKMapView(frame: .zero)
    
    func makeCoordinator() -> MainMapView.Coordinator {
        return Coordinator(parent1: self)
    }
    
    func makeUIView(context: UIViewRepresentableContext<MainMapView>) -> MKMapView {
        let center = CLLocationCoordinate2D(latitude: 51.454514, longitude: -2.587910)
        let region = MKCoordinateRegion(center: center, latitudinalMeters: 2500, longitudinalMeters: 2500)
        map.region = region
        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = context.coordinator
        locationManager.startUpdatingLocation()
        //Set color of text/icons as blue.
        map.tintColor = .systemBlue
        //Show users location on the map.
        map.showsUserLocation = true
        return map
    }

    func updateUIView(_ view: MKMapView, context: Context) {
    }
    
    func MainMapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(polyline: overlay as! MKPolyline)
        renderer.strokeColor = UIColor.blue
        return renderer
    }
    
    class Coordinator : NSObject, CLLocationManagerDelegate{
        var parent : MainMapView
        var userLastLongitude: Double = 0
        var userLastLatitude: Double = 0
        
        init(parent1 : MainMapView){
            parent = parent1
        }
        
        func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
            if status == .denied{
                //if location isnt given
            }
        }
        
        func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            let location = locations[locations.count - 1]
            
            if location.horizontalAccuracy > 0 {
                //Check if the user has moved and if so update location variables
                if location.coordinate.longitude != userLastLongitude || location.coordinate.latitude != userLastLatitude
                {
                    //Check the variables if has been set and if not then set region to the current location
                    //Add if once they press search
                    //if lastLongitude == 0 || lastLatitude == 0
                    //{
                        let region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 2500, longitudinalMeters: 2500)
                        map.region = region
                        
                    //}
                    userLastLongitude = location.coordinate.longitude
                    userLastLatitude = location.coordinate.latitude
                }
            }
        }
    }
}

struct textFieldButton: ViewModifier {
    @Binding var text: String
    @Binding var locationManager : CLLocationManager
    
    public func body(content: Content) -> some View{
        ZStack(alignment: .trailing)
        {
            content
            HStack{
            if !text.isEmpty
            {
                Button(action:
                {
                    self.text = ""
                })
                {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(Color(UIColor.opaqueSeparator))
                }
                .padding(.trailing, 15)
            }
            Button(action:
            {
                if self.text.contains(",")
                {
                    let arrayCoordinates = self.text.components(separatedBy: ",")
                    
                    let locationLatitude = Double(arrayCoordinates[0]) ?? 0
                    let locationLongitude = Double(arrayCoordinates[1]) ?? 0
                     
                    let coordinateDestination = CLLocationCoordinate2D(latitude: CLLocationDegrees(exactly: locationLatitude)!, longitude: CLLocationDegrees(exactly: locationLongitude)!)
                    
                    createRoute(coordinateSelf: self.locationManager.location!.coordinate, coordinateDestination: coordinateDestination)
                }
                else
                {
                    //search for long and lat
                    let searchRequest = MKLocalSearch.Request()
                    searchRequest.naturalLanguageQuery = self.text
                    let search = MKLocalSearch(request: searchRequest)
                    
                    search.start{ response, error in guard let response = response else {
                        print ("Error: \(error?.localizedDescription ?? "unknown error").")
                        return
                        
                        }
                        let locationLatitude = Double(round(1000*response.boundingRegion.center.latitude) / 1000)
                        let locationLongitude = Double(round(1000*response.boundingRegion.center.longitude) / 1000)

                        let coordinateDestination = CLLocationCoordinate2D(latitude: CLLocationDegrees(exactly: locationLatitude)!, longitude: CLLocationDegrees(exactly: locationLongitude)!)
                        
                        createRoute(coordinateSelf: self.locationManager.location!.coordinate, coordinateDestination: coordinateDestination)
                    }
                }
            })
            {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(Color(UIColor.red))
            }
            .padding(.trailing, 35)
            
            }
        }
    }
}

func createRoute (coordinateSelf: CLLocationCoordinate2D, coordinateDestination: CLLocationCoordinate2D) {
    let radius: Double = UserDefaults.standard.double(forKey: "radius")
    
    //Remove previous markers
    map.removeAnnotations(map.annotations)
    
    for carPark in carParksData {
        let distance = carPark.getDistance(searchLocationCoordinate: coordinateDestination)
        
        if distance <= radius {
            let point = MKPointAnnotation()
            //Setting attibutes of MKPointAnnotation
            point.title = carPark.name
            //point.subtitle = String("\(round(1000*distance)/1000) miles ")
            point.coordinate =  CLLocationCoordinate2D(latitude: CLLocationDegrees(exactly: carPark.latitude)!, longitude: CLLocationDegrees(exactly: carPark.longitude)!)
            //Custom View for Annotation
            let annotationView = MKAnnotationView(annotation: point, reuseIdentifier: "customView")
            //Your custom image icon
            annotationView.image = UIImage(named: "circle")
            
            //self.parent.map.removeAnnotations(self.parent.map.annotations)
            map.addAnnotation(point)

        }
    }
    
    
    /*let request = MKDirections.Request()
    request.source = MKMapItem(placemark: MKPlacemark(coordinate: coordinateSelf, addressDictionary: nil))
    request.destination = MKMapItem(placemark: MKPlacemark(coordinate: coordinateDestination, addressDictionary: nil))
    request.requestsAlternateRoutes = true
    request.transportType = .automobile
    
    //Adding map annotation of the destination
    let destinationAnnotation = MKPointAnnotation()
    if let location = request.destination {
        destinationAnnotation.coordinate = location.placemark.coordinate
    }
    map.removeAnnotations(map.annotations)
    map.showAnnotations([destinationAnnotation], animated: true )
    
    let directions = MKDirections(request: request)

    directions.calculate {response, error in
        guard let unwrappedResponse = response else { return }

        if (unwrappedResponse.routes.count > 0) {
            for route in unwrappedResponse.routes {
                map.addOverlay(route.polyline)
                map.setVisibleMapRect(route.polyline.boundingMapRect, animated: true)
            }
        }
    }*/
}


struct MapView_Preview: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
