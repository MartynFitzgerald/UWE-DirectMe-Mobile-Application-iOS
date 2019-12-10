//
//  AccountProfilePicture.swift
//  DirectMe
//
//  Created by martyn on 01/12/2019.
//  Copyright © 2019 martyn.fitzgerald. All rights reserved.
//

import Foundation

import SwiftUI

struct AccountProfilePicture: View {
    var image: String

    var body: some View {
        Image(image)
            .resizable()
            .frame(width: 128.0, height: 128.0)
            .clipShape(Circle())
            .overlay(Circle().stroke(Color.white, lineWidth: 4))
            .shadow(radius: 10)
    }
}

struct AccountProfilePicture_Previews: PreviewProvider {
    static var previews: some View {
        AccountProfilePicture(image: "male1")
    }
}
