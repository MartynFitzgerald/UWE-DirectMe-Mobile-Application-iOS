//
//  Data.swift
//  DirectMe
//
//  Created by Apple.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit
import SwiftUI

let historyData: [History] = load("historyData.json")
let carParksData: [CarParks] = load("carParksData.json")

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

final class ImageStore {
    typealias _ImageDictionary = [String: CGImage]
    fileprivate var images: _ImageDictionary = [:]

    fileprivate static var scale = 2
    
    static var shared = ImageStore()
    
    func image(name: String, imageExtension: String) -> Image {
        let index = _guaranteeImage(name: name, imageExtension: imageExtension)
        
        return Image(images.values[index], scale: CGFloat(ImageStore.scale), label: Text(verbatim: name))
    }

    static func loadImage(name: String, imageExtension: String) -> CGImage {
        guard
            let url = Bundle.main.url(forResource: name, withExtension: imageExtension),
            let imageSource = CGImageSourceCreateWithURL(url as NSURL, nil),
            let image = CGImageSourceCreateImageAtIndex(imageSource, 0, nil)
        else {
            fatalError("Couldn't load image \(name).jpg from main bundle.")
        }
        return image
    }
    
    fileprivate func _guaranteeImage(name: String, imageExtension: String) -> _ImageDictionary.Index {
        if let index = images.index(forKey: name) { return index }
        
        images[name] = ImageStore.loadImage(name: name, imageExtension: imageExtension)
        return images.index(forKey: name)!
    }
}
//Function to sign out current user and send them back to the original login view
func signOut() {
    //Remove current user in user defaults
    UserDefaults.standard.removeObject(forKey: "currentUser")
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
