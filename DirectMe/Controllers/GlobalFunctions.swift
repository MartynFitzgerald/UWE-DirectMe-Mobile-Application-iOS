//
//  GlobalFunctions.swift
//  DirectMe
//
//  Created by martyn on 28/11/2019.
//  Copyright © 2019 martyn.fitzgerald. All rights reserved.
//

import UIKit

let carParksData: [CarPark] = load("carParksData.json")

func load<T: Decodable>(_ filename: String) -> T {
    let data: Data
    
    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
        else {
            fatalError("Couldn't find \(filename) in main bundle.")
    }
    
    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
    }
    
    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
    }
}

//Function to sign out current user and send them back to the original login view
func signOut() {
    //Remove current user in user defaults
    //UserDefaults.standard.removeObject(forKey: "currentUser")
    //Sending user back to the login page
    //let viewCtrl = UIHostingController(rootView:Main())
    //addChild(viewCtrl)
    //viewCtrl.view.frame = theContainer.bounds
    //theContainer.addSubview(viewCtrl.view)
    //viewCtrl.didMove(toParent: self)
}

//Function to check if the input from the user in the emailTextField is in a email format.
//https://stackoverflow.com/questions/25471114/how-to-validate-an-e-mail-address-in-swift
func isValidEmail(emailStr:String) -> Bool {
    let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
    return emailPred.evaluate(with: emailStr)
}
//Function to check if the input from the user in the passwordTextField is in a password format.
// One uppercase, one digit, three lowercase and overall size is between eight to twelve characters.
func isValidPassword(passwordStr:String) -> Bool {
    let passwordRegEx = "^(?=.*[A-Z])(?=.*[0-9])(?=.*[a-z].*[a-z].*[a-z]).{8,12}$"
    let passwordPred = NSPredicate(format:"SELF MATCHES %@", passwordRegEx)
    return passwordPred.evaluate(with: passwordStr)
}
//Function to check if the input from the user in the firstNameTextField and lastNameTextField is format below.
// overall size is between two to eighteen characters.
func isValidName(nameStr:String) -> Bool {
    let nameRegEx = "^.{2,18}$"
    let namePred = NSPredicate(format:"SELF MATCHES %@", nameRegEx)
    return namePred.evaluate(with: nameStr)
}
