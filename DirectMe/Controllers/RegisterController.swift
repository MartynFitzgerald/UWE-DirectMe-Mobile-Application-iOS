//
//  RegisterController.swift
//  DirectMe
//
//  Created by martyn on 29/11/2019.
//  Copyright © 2019 martyn.fitzgerald. All rights reserved.
//

import UIKit
import SwiftUI

class RegisterController: UIViewController {
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var errorTextView: UITextView!
    @IBOutlet weak var formFillText: UILabel!
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var navigationTitle: UINavigationItem!
    @IBOutlet weak var registerButton: UIButton!
    //Set stored variables to defaults
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Set gradient of storyborad background
        view.setGradientBackground(colorOne: Colours.orange, colorTwo: Colours.red)
        //Make navigationBar Transparent
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage = UIImage()
        navigationBar.isTranslucent = true
        //Set navigationBar font and color
        let attrs = [
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.font: UIFont(name: "Pacifico", size:32)!
        ]
        navigationBar.titleTextAttributes = attrs
        //Making buttons have a rounded corner.
        registerButton.layer.cornerRadius = 25.0
        
        if UserDefaults.standard.bool(forKey: "isDarkMode") == true {
            overrideUserInterfaceStyle = .dark
            //Set buttons colours programmatically
            registerButton.backgroundColor = .black
            registerButton.setTitleColor(.white, for: UIControl.State.normal)
            //Set label colour
            errorTextView.textColor = .black
            formFillText.textColor = .black
            //Set again if darkmode navigationBar font and color
            let attrs = [
                NSAttributedString.Key.foregroundColor: UIColor.black,
                NSAttributedString.Key.font: UIFont(name: "Pacifico", size:32)!
            ]
            navigationBar.titleTextAttributes = attrs
        }
    }
    //Set Status bar text to white
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    //Once the registerButton is been press execute.
    @IBAction func registerUser(_ sender: Any) {
        let firstName:String? = (firstNameTextField.text ?? "").lowercased().capitalized
        let lastName:String? = (lastNameTextField.text ?? "").lowercased().capitalized
        let email:String? = (emailTextField.text ?? "").lowercased()
        let password:String? = passwordTextField.text ?? ""
        let confirmPassword:String? = confirmPasswordTextField.text ?? ""
        //Validated user inpute to make sure its allowed
        let isFirstNameValid = isValidName(nameStr: firstName!);
        let isLastNameValid = isValidName(nameStr: lastName!);
        let isEmailValid = isValidEmail(emailStr: email!);
        let isPasswordValid = isValidPassword(passwordStr: password!);
        let isConfirmPasswordValid = isValidPassword(passwordStr: confirmPassword!);
        //Set error text to have nothing just incase if they has a error before.
        self.errorTextView.text = ""
        //If text fields are not valid then show error
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
            //If passwords are not the same show error
            if password != confirmPassword
            {
                self.errorTextView.text = "The password and confirm password doesn't match."
            }
            else
            {
                //Get array of users from storage.
                var usersArray = defaults.object(forKey: "usersArray") as? [[String : Any]] ?? [[String : Any]]()
                //Check if there is users stored.
                if usersArray.count > 0 {
                    for user in usersArray
                    {
                        //Check if the user exists within the database of users.
                        if user["email"] as? String == email
                        {
                            self.errorTextView.text = "This email has already got an account with DirectMe."
                            //Breaking the loop once found the user.
                            break;
                        }
                    }
                }
                //Double check that no error was displayed
                if self.errorTextView.text == ""
                {
                    //Get the amount of users within the system to set new id
                    let userID: Int = usersArray.count
                    //Create a new User object with the data inputted and default settings like profilePicture
                    let newUser = [
                       "id": userID,
                       "firstName": firstName!,
                       "lastName": lastName!,
                       "email": email!,
                       "password": password!,
                       "profilePicture": 0,
                       "isDarkMode": false,
                       "radius": 5.0
                       ] as [String : Any]
                    //Empty all textfields
                    firstNameTextField.text = ""
                    lastNameTextField.text = ""
                    emailTextField.text = ""
                    passwordTextField.text = ""
                    confirmPasswordTextField.text = ""
                    //Amend the usersArray with the new user
                    usersArray.append(newUser)
                    //Set new usersArrays within the users defaults
                    defaults.set(usersArray, forKey: "usersArray")
                    //Tell the user they have registered
                    self.errorTextView.text = "Congratulations you have registed to DirectMe. You can now sign into your account!"
                }
            }
        }
    }
}
//Addding functions onto string to allow me to format them.
extension String {
    //This function sets the first letter capital
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }
    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}
