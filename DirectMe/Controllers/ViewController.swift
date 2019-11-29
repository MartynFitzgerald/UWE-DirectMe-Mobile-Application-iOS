//
//  ViewController.swift
//  DirectMe
//
//  Created by martyn on 12/11/2019.
//  Copyright © 2019 martyn.fitzgerald. All rights reserved.
//

import UIKit
import SwiftUI
import CoreLocation

class ViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var errorTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func loginButton(_ sender: Any) {
        let email:String? = emailTextField.text ?? ""
        let password:String? = passwordTextField.text ?? ""
        
        let isEmailValid = isValidEmail(emailStr: email!);
        let isPasswordValid = isValidPassword(passwordStr: password!);
        
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
            self.errorTextView.text = ""
            for user in userData
            {
                if user.email == email && user.password == password
                {
                    //Store this into an array
                    print(user.id, " - ", user.firstName, " - ", user.lastName, " - ", user.email, " - ", user.password)
                }
            }
        }
        
        //Allow user to login and send to NavView
        //UIHostingController(rootView: NavView())
    }
    
    //@IBSegueAction func addSwiftUIView(_ coder: NSCoder) -> UIViewController? {
      //  return UIHostingController(coder:coder, rootView: NavView())
    //}
    
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

