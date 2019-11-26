//
//  ViewController.swift
//  DirectMe
//
//  Created by martyn on 12/11/2019.
//  Copyright © 2019 martyn.fitzgerald. All rights reserved.
//

import UIKit
import SwiftUI

class ViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    
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
        if (isEmailValid == false && isPasswordValid == false)
        {
            errorLabel.text = "Both are not valid"
        }
        else if (isEmailValid == false)
        {
            errorLabel.text = "Email is not valid"
        }
        else if (isPasswordValid == false)
        {
            errorLabel.text = "Password is not valid"
        }
        else
        {
            print(email!);
            print(password!);
        }
        
        //Check database if exist
        
        //Pull data from account
        
        //Allow user to login and send to NavView
        //UIHostingController(rootView: NavView())
    }
    
    @IBSegueAction func addSwiftUIView(_ coder: NSCoder) -> UIViewController? {
        //print(emailTextField.text);
        //print(passwordTextField.text);
        return UIHostingController(coder:coder, rootView: NavView())
    }
    
    //Function to check if the input from the user in the emailTextField is in a email format.
    //https://stackoverflow.com/questions/25471114/how-to-validate-an-e-mail-address-in-swift
    func isValidEmail(emailStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: emailStr)
    }
    //Function to check if the input from the user in the passwordTextField is in a password format.
    // One uppercase, one digit, three lowercase and overall size is eight characters.
    func isValidPassword(passwordStr:String) -> Bool {
        let passwordRegEx = "^(?=.*[A-Z])(?=.*[0-9])(?=.*[a-z].*[a-z].*[a-z]).{8}$"
        let passwordPred = NSPredicate(format:"SELF MATCHES %@", passwordRegEx)
        return passwordPred.evaluate(with: passwordStr)
    }
}

