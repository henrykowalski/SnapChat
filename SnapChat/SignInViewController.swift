//
//  SignInViewController.swift
//  SnapChat
//
//  Created by Andrzej Palec on 07/05/2017.
//  Copyright © 2017 Andrzej Palec. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class SignInViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!

  
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
 
    @IBAction func turnUpTapped(_ sender: Any) {
        
        FIRAuth.auth()?.signIn(withEmail: emailTextField.text!, password: passwordTextField.text!, completion: { (user, error) in
            print("We tried to Sign In")
            if error != nil {
                print("Hey we have an error:\(error)")
            } else {
                print("Signed In Successfully")
            }
        })
        
    }
    
}

