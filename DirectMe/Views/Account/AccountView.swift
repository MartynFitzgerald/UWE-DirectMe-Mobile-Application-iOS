//
//  AccountView.swift
//  DirectMe
//
//  Created by martyn on 14/11/2019.
//  Copyright © 2019 martyn.fitzgerald. All rights reserved.
//

import SwiftUI

struct AccountView: View {
    var body: some View {
        NavigationView {
            VStack {
                AppleMapView()
                    .frame(height: 300)

                //CircleImage(image: history.image)
                //    .offset(y: -130)
                //    .padding(.bottom, -130)

                VStack(alignment: .leading) {
                    Text("Martyn Fitzgerald")
                        .font(.title)
                    Text("Email")
                        .font(.subheadline)
                    Text("Location")
                        .font(.subheadline)
                }
                .padding()

                Spacer()
            }
            .navigationBarTitle(Text("Account"), displayMode: .inline)
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

struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        AccountView()
    }
}
