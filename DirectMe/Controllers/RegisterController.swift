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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
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
    
}

extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }

    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}
