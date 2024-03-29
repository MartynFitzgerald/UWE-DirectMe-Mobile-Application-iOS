//
//  CarParkRow.swift
//  DirectMe
//
//  Created by martyn on 07/12/2019.
//  Copyright © 2019 martyn.fitzgerald. All rights reserved.
//

import SwiftUI

//Create individual row for car park.
struct CarParkRow: View {
    //Get carPark from parameter.
    var carPark: CarPark
    var body: some View {
        HStack{
            Image(systemName: "p.square.fill")
            VStack (alignment: .leading) {
                Text(carPark.name)
                    .font(.body)
            }
        }
        .padding(10)
    }
}

struct CarParkRow_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CarParkRow(carPark: carParksData[0])
            CarParkRow(carPark: carParksData[1])
        }.previewLayout(.fixed(width:300, height: 70))
    }
}
