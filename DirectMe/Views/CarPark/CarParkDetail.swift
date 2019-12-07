//
//  CarParkDetail.swift
//  DirectMe
//
//  Created by martyn on 07/12/2019.
//  Copyright © 2019 martyn.fitzgerald. All rights reserved.
//

import SwiftUI

struct CarParkDetail: View {
    var carPark: CarParks
    
    var body: some View {
        VStack {
            HistoryMapView(coordinate: carPark.locationCoordinate)
                .frame(height: 200)
            Form {
                Section(header: Text("About This Car Park")) {
                    HStack {
                        Text("Name")
                        Spacer()
                        Text(carPark.name)
                    }
                    HStack {
                        Text("External Provider")
                        Spacer()
                        Text(carPark.external_provider)
                    }
                    HStack {
                        Text("Latitude")
                        Spacer()
                        Text(String(carPark.latitude))
                    }
                    HStack {
                        Text("Longitude")
                        Spacer()
                        Text(String(carPark.longitude))
                    }
                    HStack {
                        Text("Last Updated")
                        Spacer()
                        Text(carPark.last_updated_at)
                    }
                }
            }
        }
        .navigationBarTitle(Text(carPark.name), displayMode: .inline)
    }
}

struct CarParkDetail_Preview: PreviewProvider {
    static var previews: some View {
        HistoryDetail(history: historyData[0])
    }
}
