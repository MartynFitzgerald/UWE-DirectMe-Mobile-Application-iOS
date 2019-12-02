//
//  MapView.swift
//  DirectMe
//
//  Created by martyn on 13/11/2019.
//  Copyright © 2019 martyn.fitzgerald. All rights reserved.
//

import SwiftUI

struct MapView: View {
    var body: some View {
        NavigationView {
            AppleMapView()
            .navigationBarTitle(Text("Map"), displayMode: .inline)
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

struct MapView_Preview: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
