//
//  RegisterController.swift
//  DirectMe
//
//  Created by martyn on 29/11/2019.
//  Copyright © 2019 martyn.fitzgerald. All rights reserved.
//

import UIKit
import SwiftUI
import CoreLocation
import MessageUI

class RegisterController: UIViewController {
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var errorTextView: UITextView!
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var navigationTitle: UINavigationItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Set gradient of storyborad background
        view.setGradientBackground(colorOne: Colours.orange, colorTwo: Colours.red)
        //Make navigationBar Transparent
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage = UIImage()
        navigationBar.isTranslucent = true
        //Make navigationBar font and color
        let attrs = [
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.font: UIFont(name: "Pacifico", size:24)!
        ]
        navigationBar.titleTextAttributes = attrs
    }
    //Set Status bar text to white
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @IBAction func registerUser(_ sender: Any) {
        self.errorTextView.text = ""
        let firstName:String? = (firstNameTextField.text ?? "").lowercased().capitalized
        let lastName:String? = (lastNameTextField.text ?? "").lowercased().capitalized
        let email:String? = (emailTextField.text ?? "").lowercased().capitalized
        let password:String? = passwordTextField.text ?? ""
        let confirmPassword:String? = confirmPasswordTextField.text ?? ""
        
        let isFirstNameValid = isValidName(nameStr: firstName!);
        let isLastNameValid = isValidName(nameStr: lastName!);
        let isEmailValid = isValidEmail(emailStr: email!);
        let isPasswordValid = isValidPassword(passwordStr: password!);
        let isConfirmPasswordValid = isValidPassword(passwordStr: confirmPassword!);
        
        //Validate email and password
        if isFirstNameValid == false &&  isLastNameValid == false && isEmailValid == false && isPasswordValid == false && isConfirmPasswordValid == false
        {
            self.errorTextView.text = "The first name, last name, email, password and re-enter password provided are not valid, please try again."
        }
        else if isFirstNameValid == false
        {
            self.errorTextView.text = "The first name provided is not valid, please try again."
        }
        else if isLastNameValid == false
        {
            self.errorTextView.text = "The last name provided is not valid, please try again."
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
            if password != confirmPassword
            {
                self.errorTextView.text = "The password and confirm password doesn't match."
            }
            else
            {
                for data in userData
                {
                    if data.email == email
                    {
                        self.errorTextView.text = "This email has already got an account with DirectMe."
                        break;
                    }
                }
                
                //check if there was no error
                if self.errorTextView.text == ""
                {
                    //Create a new User object with the data inputted
                    let newUser = User(id: 2, firstName: firstName!, lastName: lastName!, email: email!, password: password!, profilePicture: "boy")
                    //Amend the userData stored from the json file
                    userData.append(newUser)
                    //print (userData)
                    do {
                        let encoder = JSONEncoder()
                        encoder.outputFormatting = .prettyPrinted
                        let data = try! encoder.encode(userData)
                        
                        let location = getDocumentsDirectory().appendingPathComponent("../userData.txt")

                        try data.write(to: location)
                        
                    } catch {
                        print(error)
                    }
                    /*
                    if MFMailComposeViewController.canSendMail() {
                        let mail = MFMailComposeViewController()
                        mail.mailComposeDelegate = self as? MFMailComposeViewControllerDelegate
                        mail.setToRecipients([email!])
                        mail.setMessageBody("<p>You're so awesome!</p>", isHTML: true)

                        present(mail, animated: true)
                    } else {
                        // show failure alert
                    }
                    */
                }
                
            }
        }
        
        //email registersation
        
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}

extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }

    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}
