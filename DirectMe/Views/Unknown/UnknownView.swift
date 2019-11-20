//
//  UnknownView.swift
//  DirectMe
//
//  Created by martyn on 19/11/2019.
//  Copyright © 2019 martyn.fitzgerald. All rights reserved.
//

import SwiftUI

struct UnknownView: View {
    
    var body: some View {
        NavigationView {
            Text("Unknown")
            .navigationBarTitle(Text("Unknown"), displayMode: .inline)
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

struct UnknownView_Previews: PreviewProvider {
    static var previews: some View {
        UnknownView()
    }
}
