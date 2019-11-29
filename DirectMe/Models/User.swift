//
//  User.swift
//  DirectMe
//
//  Created by martyn on 28/11/2019.
//  Copyright © 2019 martyn.fitzgerald. All rights reserved.
//

import SwiftUI
import CoreLocation

struct User: Hashable, Codable, Identifiable {
    var id: Int
    var firstName: String
    var lastName: String
    var email:  String
    var password: String
    fileprivate var profilePicture: String
    /*
    fileprivate var coordinates: Coordinates
    var locationCoordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(
            latitude: coordinates.latitude,
            longitude: coordinates.longitude)
    }*/
    
    init(id: Int, firstName: String, lastName: String, email: String, password: String, image: String) {
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.password = password
        self.profilePicture = image
    }
}

extension User {
    var image: Image {
        ImageStore.shared.image(name: profilePicture)
    }
}
