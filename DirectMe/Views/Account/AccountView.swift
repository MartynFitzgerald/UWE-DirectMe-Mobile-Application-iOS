//
//  AccountView.swift
//  DirectMe
//
//  Created by martyn on 14/11/2019.
//  Copyright © 2019 martyn.fitzgerald. All rights reserved.
//

import SwiftUI

struct AccountView: View {
    @State private var enableDarkMode = false
    @State private var selectedMode = 0
    @State private var selectedProfilePicture = 0
    @State var sliderValue = 500.0
    
    let currentUser: [String : Any] = UserDefaults.standard.object(forKey: "currentUser") as! [String : Any]

    var notificationMode = ["Lock Screen", "Notification Centre", "Banners"]
    var profilePictures = ["male1", "male2", "male3", "male4", "male5", "male6", "male7", "female1", "female2"]
    var minimumValue = 500.0
    var maximumvalue = 2000.0
    
    var body: some View {
        NavigationView {
            VStack {
                VStack(alignment: .center) {
                    AccountProfilePicture(image: ImageStore.shared.image(name: "male1", imageExtension: "png"))
                      .offset(y: -30)
                      .padding(.bottom, -30)
                    Text("\(currentUser["firstName"] as? String ?? "") \(currentUser["lastName"] as? String ?? "")")
                        .font(.title)
                    Text("\(currentUser["email"] as? String ?? "")")
                        .font(.subheadline)
                }
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 300)
                .background(Color.blue)
                .foregroundColor(Color.white)
                Form {
                    Section(header: Text("General Settings")){
                        Toggle(isOn: $enableDarkMode) {
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
                            Text("First Name")
                            Spacer()
                            Text("\(currentUser["firstName"] as? String ?? "")")
                        }
                        HStack {
                            Text("Last Name")
                            Spacer()
                            Text("\(currentUser["lastName"] as? String ?? "")")
                        }
                        HStack {
                            Text("Email")
                            Spacer()
                            Text("\(currentUser["email"] as? String ?? "")")
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
            }
            .navigationBarTitle(Text("Account"), displayMode: .inline)
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

struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        AccountView()
    }
}
