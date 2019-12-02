//
//  AccountView.swift
//  DirectMe
//
//  Created by martyn on 14/11/2019.
//  Copyright © 2019 martyn.fitzgerald. All rights reserved.
//

import SwiftUI


struct AccountView: View {
    let firstName: String = UserDefaults.standard.string(forKey: "firstName") ?? "Unknown"
    let lastName: String = UserDefaults.standard.string(forKey: "lastName") ?? "Unknown"
    let email: String = UserDefaults.standard.string(forKey: "email") ?? "Unknown"
    let profilePicture: String = UserDefaults.standard.string(forKey: "profilePicture") ?? "Unknown"
    
    @State private var sliderValue: Bool = false
    
    var body: some View {
        NavigationView {
            VStack {
                VStack(alignment: .center) {
                    AccountProfilePicture(image: ImageStore.shared.image(name: profilePicture, imageExtension: "png"))
                      .offset(y: -30)
                      .padding(.bottom, -30)
                    Text("\(firstName) \(lastName)")
                        .font(.title)
                    Text("\(email)")
                        .font(.subheadline)
                    Text("Location")
                        .font(.subheadline)
                }
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 300)
                .background(Color.blue)
                .foregroundColor(Color.white)

                VStack {
                    HStack{
                        Toggle(isOn: $sliderValue)
                        {
                            Text("Dark Mode")
                                .font(.body)
                        }
                    }
                    .padding(10)
                    
                    HStack{
                        Text("Notifications")
                            .font(.body)
                    }
                    .padding(10)
                    
                    HStack{
                        Text("Notifications")
                            .font(.body)
                    }
                    .padding(10)
                    
                    HStack{
                        Text("Notifications")
                            .font(.body)
                        }
                    .padding(10)
                }
                
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
