//
//  MapView.swift
//  DirectMe
//
//  Created by martyn on 13/11/2019.
//  Copyright © 2019 martyn.fitzgerald. All rights reserved.
//

import SwiftUI
import MapKit
//Set globale map varible for use after text is submitted.
var map = MKMapView(frame: .zero)
//This is the main view.
struct MapView: View {
    //Have state values set since it will change while being on the view.
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

//Create map itself embedded into the main view.
struct MainMapView: UIViewRepresentable {
    @Binding var locationManager : CLLocationManager
    //Create coordinator
    func makeCoordinator() -> MainMapView.Coordinator {
        return Coordinator(parent1: self)
    }
    //Create map with all the values set inside.
    func makeUIView(context: UIViewRepresentableContext<MainMapView>) -> MKMapView {
        //Set Region
        let center = CLLocationCoordinate2D(latitude: 51.454514, longitude: -2.587910)
        let region = MKCoordinateRegion(center: center, latitudinalMeters: 2500, longitudinalMeters: 2500)
        map.region = region
        //Request Authorization.
        locationManager.requestWhenInUseAuthorization()
        //Set delegate.
        locationManager.delegate = context.coordinator
        //Start updating the users location on the map.
        locationManager.startUpdatingLocation()
        //Set color of text/icons as blue.
        map.tintColor = .systemBlue
        //Show users location on the map.
        map.showsUserLocation = true
        return map
    }
    // Set colour of polylines on the map. Not used no longer, couldn't get the functionality of routes to work.
    func MainMapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(polyline: overlay as! MKPolyline)
        renderer.strokeColor = UIColor.blue
        return renderer
    }
    //Create the maps coordinator class, no longer needed, since i couldn't get routes to work.
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
//View modifier of text field to add buttons within.
struct textFieldButton: ViewModifier {
    @Binding var text: String
    @Binding var locationManager : CLLocationManager
    
    public func body(content: Content) -> some View{
        ZStack(alignment: .trailing)
        {
            content
            HStack{
            //Only show this button if text isn't empty.
            if !text.isEmpty
            {
                //Remove text button.
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
            //Adding
            Button(action:
            {
                //If coordinates are give from user.
                if self.text.contains(",")
                {
                    //Split string to an array
                    let arrayCoordinates = self.text.components(separatedBy: ",")
                    //Set values
                    let locationLatitude = Double(arrayCoordinates[0]) ?? 0
                    let locationLongitude = Double(arrayCoordinates[1]) ?? 0
                    //Set desination coordinates
                    let coordinateDestination = CLLocationCoordinate2D(latitude: CLLocationDegrees(exactly: locationLatitude)!, longitude: CLLocationDegrees(exactly: locationLongitude)!)
                    //Make a pin on the map of the location.
                    createPin(coordinateSelf: self.locationManager.location!.coordinate, coordinateDestination: coordinateDestination)
                }
                else
                {
                    //Request the lat and long from the user's input
                    let searchRequest = MKLocalSearch.Request()
                    searchRequest.naturalLanguageQuery = self.text
                    let search = MKLocalSearch(request: searchRequest)
                    //When search has started.
                    search.start{ response, error in guard let response = response else {
                        print ("Error: \(error?.localizedDescription ?? "unknown error").")
                        return
                        
                        }
                        //Set values
                        let locationLatitude = Double(round(1000*response.boundingRegion.center.latitude) / 1000)
                        let locationLongitude = Double(round(1000*response.boundingRegion.center.longitude) / 1000)
                        //Set desination coordinates
                        let coordinateDestination = CLLocationCoordinate2D(latitude: CLLocationDegrees(exactly: locationLatitude)!, longitude: CLLocationDegrees(exactly: locationLongitude)!)
                        //Make a pin on the map of the location.
                        createPin(coordinateSelf: self.locationManager.location!.coordinate, coordinateDestination: coordinateDestination)
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

func createPin(coordinateSelf: CLLocationCoordinate2D, coordinateDestination: CLLocationCoordinate2D) {
    //Request raduis from user defualts
    let radius: Double = UserDefaults.standard.double(forKey: "radius")
    //Remove previous markers
    map.removeAnnotations(map.annotations)
    //Loop through car parks
    for carPark in carParksData {
        //Get distance of car park from the location give.
        let distance = carPark.getDistance(searchLocationCoordinate: coordinateDestination)
        //If its within then display pin.
        if distance <= radius {
            //Create Pin
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
