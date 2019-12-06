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
struct textFieldButton: ViewModifier
{
    @Binding var text: String
    @Binding var locationManager : CLLocationManager

    public func body(content: Content) -> some View
    {
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
                    
                    let locationLatitude: Double = Double(arrayCoordinates[0]) ?? 0
                    let locationLongitude: Double = Double(arrayCoordinates[1]) ?? 0
                    createSearchAnnotation (latitude: locationLatitude, longitude: locationLongitude)
                }
                else
                {
                    //search for long and lat
                    
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

func createSearchAnnotation (latitude: Double, longitude: Double)
{
    let coordinate = CLLocationCoordinate2DMake(latitude, longitude)
    let point = MKPointAnnotation()
    //Setting attibutes of MKPointAnnotation
    point.title = "Your Location!"
    point.subtitle = "Current"
    point.coordinate = coordinate
    //Custom View for Annotation
    let annotationView = MKAnnotationView(annotation: point, reuseIdentifier: "customView")
    //Your custom image icon
    annotationView.image = UIImage(named: "circle")
    let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 2500, longitudinalMeters: 2500)
    
    //self.parent.map.removeAnnotations(self.parent.map.annotations)
    map.addAnnotation(point)
    map.region = region
}


struct MapView_Preview: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
