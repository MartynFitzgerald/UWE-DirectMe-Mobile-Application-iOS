//
//  CarParks.swift
//  
//
//  Created by martyn on 07/12/2019.
//

import SwiftUI
import CoreLocation

struct CarPark: Hashable, Codable, Identifiable {
    var id: Int
    var name: String
    var latitude: Double
    var longitude: Double
    var last_updated_at: String
    var external_provider: String

    var locationCoordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(
            latitude: latitude,
            longitude: longitude)
    }
    
    func getDistance(searchLocationCoordinate: CLLocationCoordinate2D) -> Double {
        let distanceFromCenterOfRadius: Double = sqrt(
                                    pow(69.1 * (self.latitude - searchLocationCoordinate.latitude), 2) +
                                    pow(69.1 * (self.longitude - searchLocationCoordinate.longitude) * cos(self.latitude / 57.3), 2) * 1609.344)
        return distanceFromCenterOfRadius
    }
}
