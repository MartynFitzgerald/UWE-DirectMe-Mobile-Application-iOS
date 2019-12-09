//
//  UnknownView.swift
//  DirectMe
//
//  Created by martyn on 19/11/2019.
//  Copyright © 2019 martyn.fitzgerald. All rights reserved.
//

import SwiftUI

struct CarParkView: View {
    
    var body: some View {
        NavigationView {
            List (carParksData) { carPark in
                NavigationLink(destination: CarParkDetail(carPark: carPark)) {
                    CarParkRow(carPark: carPark)
                }
            }
            .navigationBarTitle(Text("Car Parks"), displayMode: .inline)
            .navigationBarItems(leading:
                Button(action: {
                    signOut()
                }, label: {
                    HStack{
                        Image(systemName: "square.and.arrow.up")
                        .resizable()
                        .frame(width: 20.0, height: 20.0, alignment: .center)
                        .rotationEffect(.degrees(-90))
                        Text("Sign Out")
                    }
                })
            )
        }
    }
}

struct CarParkView_Previews: PreviewProvider {
    static var previews: some View {
        CarParkView()
    }
}
