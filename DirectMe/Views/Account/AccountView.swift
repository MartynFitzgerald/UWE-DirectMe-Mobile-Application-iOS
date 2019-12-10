//
//  AccountView.swift
//  DirectMe
//
//  Created by martyn on 14/11/2019.
//  Copyright © 2019 martyn.fitzgerald. All rights reserved.
//

import SwiftUI
import Combine

struct AccountView: View {
    @State private var selectedMode = 0
    @State private var firstName = UserDefaults.standard.string(forKey: "firstName")!
    @State private var lastName = UserDefaults.standard.string(forKey: "lastName")!
    @State private var email = UserDefaults.standard.string(forKey: "email")!
    
    
    @ObservedObject var userDefaultManager = UserDefaultsManager()
    
    var notificationMode = ["Lock Screen", "Notification Centre", "Banners"]
    var profilePictures = ["male1", "male2", "male3", "male4", "male5", "male6", "male7", "female1", "female2"]
    var profilePicturesTitles = ["Male 1", "Male 2", "Male 3", "Male 4", "Male 5", "Male 6", "Male 7", "Female 1", "Female 2"]
    var minimumValue = 5.0
    var maximumvalue = 25.0
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    VStack(alignment: .center) {
                        AccountProfilePicture(image: profilePictures[self.userDefaultManager.selectedProfilePicture])
                            .offset(y: -30)
                          .padding(.bottom, -30)
                        Text("\(firstName) \(lastName)")
                            .font(.title)
                        Text("\(email)")
                            .font(.subheadline)
                    }
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 250, maxHeight: 400)
                    .background(Color.blue)
                    .foregroundColor(Color.white)
                    Section(header: Text("General Settings")){
                        Toggle(isOn: self.$userDefaultManager.isDarkMode) {
                            Text("Dark Mode")
                        }.toggleStyle(DefaultToggleStyle())
                        VStack(alignment: .leading) {
                            Text("Radius")
                            HStack {
                               Text("\(Int(self.userDefaultManager.sliderRadiusValue))")
                               Slider(value: self.$userDefaultManager.sliderRadiusValue, in: minimumValue...maximumvalue)
                               Text("\(Int(maximumvalue))")
                            }
                            .accentColor(Color.blue)
                       }
                        
                    }
                    Section(header: Text("Privacy")){
                        Button(action:{
                            UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!, options: [:], completionHandler: nil)
                        }) {
                            Text("Location")
                                .foregroundColor(Color.black)
                        }
                    }
                    Section(header: Text("User Information")) {
                        HStack {
                            Text("First Name")
                            Spacer()
                            Text("\(firstName)")
                        }
                        HStack {
                            Text("Last Name")
                            Spacer()
                            Text("\(lastName)")
                        }
                        HStack {
                            Text("Email")
                            Spacer()
                            Text("\(email)")
                        }
                        Picker(selection: self.$userDefaultManager.selectedProfilePicture, label: Text("Profile Pictures")) {
                            ForEach (0..<profilePictures.count){
                                Text(self.profilePicturesTitles[$0])
                                //AccountProfilePicture(name: self.profilePictures[$0])
                                Image(self.profilePictures[$0])
                                    .resizable()
                                    .frame(width: 128.0, height: 128.0)
                                    .shadow(radius: 10)
                            }
                        }
                    }
                    Section(header: Text("System")) {
                        Button(action:{
                            
                        }) {
                            Text("Sign Out")
                                .foregroundColor(Color.red)
                        }
                    }
                }
            }
            .navigationBarTitle(Text("Account"), displayMode: .inline)
        }
    }
}

class UserDefaultsManager: ObservableObject {
    //Storing the current user's id that was stored on login
    private var id = UserDefaults.standard.integer(forKey: "id")
    
    //Creating a varible that will change set the user defaults if the value has changed.
    @Published var isDarkMode: Bool = UserDefaults.standard.bool(forKey: "isDarkMode") {
        didSet {
            //Get current isDarkMode value from user defaults.
            UserDefaults.standard.set(isDarkMode, forKey: "isDarkMode")
            //Get array of users from storage.
            var usersArray = UserDefaults.standard.object(forKey: "usersArray") as? [[String : Any]] ?? [[String : Any]]()
            //Changing the value of isDarkMode to the current user.
            usersArray[id]["isDarkMode"] = isDarkMode
            //Creating a copy of the array stored in user defaults.
            let usersArrayCopy = usersArray
            //Removing old array of the users.
            UserDefaults.standard.removeObject(forKey: "usersArray")
            //Setting Copy Into Storage. Could be more optimal but couldn't find a good solution.
            UserDefaults.standard.set(usersArrayCopy, forKey: "usersArray")
        }
    }
    //Creating a varible that will change set the user defaults if the value has changed.
    @Published var sliderRadiusValue: Double = UserDefaults.standard.double(forKey: "radius") {
        didSet {
            //Get current radius value from user defaults.
            UserDefaults.standard.set(sliderRadiusValue, forKey: "radius")
            //Get array of users from storage.
            var usersArray = UserDefaults.standard.object(forKey: "usersArray") as? [[String : Any]] ?? [[String : Any]]()
            //Changing the value of radius to the current user.
            usersArray[id]["radius"] = sliderRadiusValue
            //Creating a copy of the array stored in user defaults.
            let usersArrayCopy = usersArray
            //Removing old array of the users.
            UserDefaults.standard.removeObject(forKey: "usersArray")
            //Setting Copy Into Storage. Could be more optimal but couldn't find a good solution.
            UserDefaults.standard.set(usersArrayCopy, forKey: "usersArray")
        }
    }
    //Creating a varible that will change set the user defaults if the value has changed.
    @Published var selectedProfilePicture = UserDefaults.standard.integer(forKey: "profilePicture") {
        didSet {
            //Get current radius value from user defaults.
            UserDefaults.standard.set(selectedProfilePicture, forKey: "profilePicture")
            //Get array of users from storage.
            var usersArray = UserDefaults.standard.object(forKey: "usersArray") as? [[String : Any]] ?? [[String : Any]]()
            //Changing the value of radius to the current user.
            usersArray[id]["profilePicture"] = selectedProfilePicture
            //Creating a copy of the array stored in user defaults.
            let usersArrayCopy = usersArray
            //Removing old array of the users.
            UserDefaults.standard.removeObject(forKey: "usersArray")
            //Setting Copy Into Storage. Could be more optimal but couldn't find a good solution.
            UserDefaults.standard.set(usersArrayCopy, forKey: "usersArray")
        }
    }
}

struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        AccountView()
    }
}
