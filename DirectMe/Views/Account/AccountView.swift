//
//  AccountView.swift
//  DirectMe
//
//  Created by martyn on 14/11/2019.
//  Copyright © 2019 martyn.fitzgerald. All rights reserved.
//

import SwiftUI

struct AccountView: View {
    @State private var currentUser: [String : Any] = UserDefaults.standard.object(forKey: "currentUser") as? [String : Any] ?? [String : Any]()
    //$currentUser["firstName"]
    
    @State private var enableAirplaneMode = false
    @State private var selectedMode = 0
    @State private var selectedProfilePicture = 0
    @State var sliderValue = 200.0
    
    var notificationMode = ["Lock Screen", "Notification Centre", "Banners"]
    var profilePictures = ["male1", "male2", "male3", "male4", "male5", "male6", "male7", "female1", "female2"]
    var minimumValue = 500.0
    var maximumvalue = 2500.0
      
    
    var body: some View {
        NavigationView {
            VStack {
                VStack(alignment: .center) {
                    AccountProfilePicture(image: ImageStore.shared.image(name: "male1", imageExtension: "png"))
                      .offset(y: -30)
                      .padding(.bottom, -30)
                    Text("($currentUser.firstName) ($currentUser.lastName)")
                        .font(.title)
                    Text("($currentUser[3])")
                        .font(.subheadline)
                    Text("Location")
                        .font(.subheadline)
                }
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 300)
                .background(Color.blue)
                .foregroundColor(Color.white)
                Form {
                    Section(header: Text("General Settings")){
                        Toggle(isOn: $enableAirplaneMode) {
                            Text("Dark Mode")
                        }
                        VStack(alignment: .leading) {
                            Text("Radius")
                            HStack {
                               Text("\(Int(sliderValue))")
                               Slider(value: $sliderValue, in: minimumValue...maximumvalue)
                               Text("\(Int(maximumvalue))")
                            }
                       }
                        
                    }
                    Section(header: Text("Privacy")){
                        Picker(selection: $selectedMode, label: Text("Notifications")) {
                            ForEach(0..<notificationMode.count) {
                                Text(self.notificationMode[$0])
                            }
                        }
                        Picker(selection: $selectedMode, label: Text("Location")) {
                            ForEach(0..<notificationMode.count) {
                                Text(self.notificationMode[$0])
                            }
                        }
                    }
                    
                    Section(header: Text("About")) {
                        HStack {
                            Text("Name")
                            Spacer()
                            Text("Martyn Fitzgerald")
                        }
                        HStack {
                            Text("Email")
                            Spacer()
                            Text("martyn2.fitzgerald@live.uwe.ac.uk")
                        }
                        Picker(selection: $selectedProfilePicture, label: Text("Profile Pictures")) {
                            ForEach(0..<profilePictures.count) {
                                Text(self.profilePictures[$0])
                                //AccountProfilePicture(name: self.profilePictures[$0])
                                Image(self.profilePictures[$0])
                                    .resizable()
                                    .frame(width: 128.0, height: 128.0)
                                    .shadow(radius: 10)
                            }
                        }
                    }
                }

                /*List {
                    HStack{
                        Toggle(isOn: $sliderValue)
                        {
                            Text("Dark Mode")
                                .font(.body)
                        }
                    }
                    .padding(10)
                    
                    HStack{
                        Button(action: {
                               print("Tapped")
                           }, label: {
                               HStack{
                                   Text("Account Information")
                                       .font(.body)
                               }
                           })
                    }
                    .padding(10)
                    
                    HStack{
                        Text("Location Settings")
                            .font(.body)
                    }
                    .padding(10)
                    
                    HStack{
                        Text("Notifications")
                            .font(.body)
                        }
                    .padding(10)
                }*/
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
