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
    var profilePicture: String
    var isDarkMode: Bool
    var radius: Double
    
    init(id: Int, firstName: String, lastName: String, email: String, password: String, profilePicture: String, isDarkMode: Bool, radius: Double) {
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.password = password
        self.profilePicture = profilePicture
        self.isDarkMode = isDarkMode
        self.radius = radius
    }
}
