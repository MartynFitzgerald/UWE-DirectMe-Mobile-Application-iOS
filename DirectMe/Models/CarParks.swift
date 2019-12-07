//
//  CarParks.swift
//  
//
//  Created by martyn on 07/12/2019.
//

import SwiftUI
import CoreLocation

struct CarParks: Hashable, Codable, Identifiable {
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
}
