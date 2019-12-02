//
//  MainController.swift
//  DirectMe
//
//  Created by martyn on 01/12/2019.
//  Copyright © 2019 martyn.fitzgerald. All rights reserved.
//

import SwiftUI
import Foundation

class MainController: UIViewController {
        @IBSegueAction func addSwiftUIView(_ coder: NSCoder) -> UIViewController? {

            //print(UserDefaults.standard.string(forKey: "firstName")!, " - ", UserDefaults.standard.string(forKey: "email")!)
            return UIHostingController(coder:coder, rootView: NavView())
        }
}
