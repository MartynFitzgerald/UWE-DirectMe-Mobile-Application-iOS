//
//  UnknownView.swift
//  DirectMe
//
//  Created by martyn on 19/11/2019.
//  Copyright © 2019 martyn.fitzgerald. All rights reserved.
//

import SwiftUI

//Create view of list of car parks.
struct CarParkView: View {
    var body: some View {
        NavigationView {
            //Loop through carParksData to create CarParkRow each time.
            List (carParksData) { carPark in
                NavigationLink(destination: CarParkDetail(carPark: carPark)) {
                    CarParkRow(carPark: carPark)
                }
            }
            .navigationBarTitle(Text("Car Parks"), displayMode: .inline)
        }
    }
}

struct CarParkView_Previews: PreviewProvider {
    static var previews: some View {
        CarParkView()
    }
}
