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
                VStack(alignment: .center) {
                    //CircleImage(image: Image("turtlerock.jpg"))
                      //.offset(y: -130)
                      //.padding(.bottom, -130)
                    Text("Martyn Fitzgerald")
                        .font(.title)
                    Text("Email")
                        .font(.subheadline)
                    Text("Location")
                        .font(.subheadline)
                }
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 300)
                .background(Color.blue)
                .foregroundColor(Color.white)

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
