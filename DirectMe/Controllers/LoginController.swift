//
//  LoginController.swift
//  DirectMe
//
//  Created by martyn on 12/11/2019.
//  Copyright © 2019 martyn.fitzgerald. All rights reserved.
//

import UIKit
import SwiftUI
import CoreLocation

class LoginController: UIViewController, CLLocationManagerDelegate {
    @IBOutlet weak var theContainer: UIView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var errorTextView: UITextView!
    
    let locationManager = CLLocationManager()
    var longitude : String = ""
    var latitude : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }

    @IBAction func loginButton(_ sender: Any) {
        let email:String? = (emailTextField.text ?? "").lowercased()
        let password:String? = passwordTextField.text ?? ""
        
        let isEmailValid = isValidEmail(emailStr: email!);
        let isPasswordValid = isValidPassword(passwordStr: password!);
        
        self.errorTextView.text = ""
        
        //Validate email and password
        if isEmailValid == false && isPasswordValid == false
        {
            self.errorTextView.text = "The email and password provided are not valid, please try again."
        }
        else if isEmailValid == false
        {
            self.errorTextView.text = "The email provided is not valid, please try again."
        }
        else if isPasswordValid == false
        {
            self.errorTextView.text = "The password provided needs to contain one uppercase, three lowercase, one number, and 8-12 characters overall. Please try again."
        }
        else
        {
            var userNotFound: Bool = true
            for user in userData
            {
                //Check if the user exists within the database of users.
                if user.email == email && user.password == password
                {
                    userNotFound = false
                    //Store this into userdefaults
                    UserDefaults.standard.set(user.firstName, forKey: "firstName")
                    UserDefaults.standard.set(user.lastName, forKey: "lastName")
                    UserDefaults.standard.set(user.email, forKey: "email")
                    UserDefaults.standard.set(user.profilePicture, forKey: "profilePicture")
                    
                    //Create a new UIHostingController with the view as the SwiftUI NavView
                    //https://stackoverflow.com/questions/56433826/include-swiftui-views-in-existing-uikit-application
                    let viewCtrl = UIHostingController(rootView: NavView())
                    addChild(viewCtrl)
                    viewCtrl.view.frame = theContainer.bounds
                    theContainer.addSubview(viewCtrl.view)
                    viewCtrl.didMove(toParent: self)
                }
            }
            if userNotFound
            {
                self.errorTextView.text = "The detais given are not a registered account at DirectMe. Please try again "
            }
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[locations.count - 1]
        
        if location.horizontalAccuracy > 0 {
            locationManager.stopUpdatingLocation()
            
            longitude = String(location.coordinate.longitude)
            latitude = String(location.coordinate.latitude)
        }
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
}

