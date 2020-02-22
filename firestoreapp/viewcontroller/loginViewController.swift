//
//  loginViewController.swift
//  firestoreapp
//
//  Created by Evgenii Shiltsev on 21.2.2020.
//  Copyright © 2020 Evgenii Shiltsev. All rights reserved.
//

import UIKit
import FirebaseAuth

class loginViewController: UIViewController {
    
    @IBOutlet weak var emailTextfield: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    
    
    @IBOutlet weak var errorLabel: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setUpElements()
        
    }
    func setUpElements(){
        errorLabel.alpha = 0
        
        Utilities.styleTextField(emailTextfield)
        Utilities.styleTextField(passwordTextField)
        Utilities.styleFilledButton(loginButton)
        
    }
    
    
    
    @IBAction func loginTappedbutton(_ sender: Any) {
        
        let email = emailTextfield.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if error != nil{
                self.errorLabel.text = error!.localizedDescription
                self.errorLabel.alpha = 1
            }
            else {
                let homeViewController = self.storyboard?.instantiateViewController(identifier: Constants.Storyboard.homeViewController) as? homeViewController
                       
                self.view.window?.rootViewController = homeViewController
                self.view.window?.makeKeyAndVisible()
            }
        }
    }
    
    
    
    }
    

    



