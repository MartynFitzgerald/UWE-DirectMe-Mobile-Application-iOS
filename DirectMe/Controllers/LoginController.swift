//
//  LoginController.swift
//  DirectMe
//
//  Created by martyn on 12/11/2019.
//  Copyright © 2019 martyn.fitzgerald. All rights reserved.
//

import UIKit
import SwiftUI

class LoginController: UIViewController {
    @IBOutlet weak var theContainer: UIView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var errorTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Set gradient of storyborad background
        view.setGradientBackground(colorOne: Colours.orange, colorTwo: Colours.red)
    }
    //Set Status bar text to white
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
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
}

//https://www.youtube.com/watch?v=3gUNg3Jhjwo
extension UIView {
    
    func setGradientBackground(colorOne: UIColor, colorTwo: UIColor) {
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = [colorOne.cgColor, colorTwo.cgColor]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.startPoint = CGPoint(x: 1.0, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 0.0, y: 0.0)
        
        layer.insertSublayer(gradientLayer, at: 0)
    }
}
