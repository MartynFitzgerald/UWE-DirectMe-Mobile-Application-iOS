//
//  InformationView.swift
//  DirectMe
//
//  Created by martyn on 19/11/2019.
//  Copyright © 2019 martyn.fitzgerald. All rights reserved.
//

import SwiftUI

struct InformationView: View {
    
    //UINavigationBar.appearance().backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 255/255, alpha: 1)
    //UINavigationBar.appearance().barTintColor = UIColor(red: 0/255, green: 0/255, blue: 255/255, alpha: 1)

    var body: some View {
        NavigationView {
            Text("Information")
            .navigationBarTitle(Text("Information"), displayMode: .inline)
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

struct InformationView_Previews: PreviewProvider {
    static var previews: some View {
        InformationView()
    }
}
