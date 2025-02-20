//
//  LoginViewController.swift
//  Flash Chat iOS13
//
//  Created by Angela Yu on 21/10/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    

    @IBAction func loginPressed(_ sender: UIButton) {
        guard let email = emailTextfield.text,
              let password = passwordTextfield.text
        else
        {
            return;
        }
        
        Auth.auth().signIn(withEmail: email, password: password){authResult, error in
            if let error{
                print(error.localizedDescription)
                return
            }
            self.performSegue(withIdentifier: Constants.loginSegue, sender: self)
        }
    }
    
}
