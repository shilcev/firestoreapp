//
//  signupViewController.swift
//  firestoreapp
//
//  Created by Evgenii Shiltsev on 21.2.2020.
//  Copyright © 2020 Evgenii Shiltsev. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase

class signupViewController: UIViewController {
    
    
    @IBOutlet weak var firstnameTextField: UITextField!
    
    @IBOutlet weak var lastnameTextField: UITextField!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var signupButton: UIButton!
    
    @IBOutlet weak var errorLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        setUpElements()
        
    }
    func setUpElements(){
        errorLabel.alpha = 0
        
        
        
        Utilities.styleTextField(firstnameTextField)
        Utilities.styleTextField(lastnameTextField)
        Utilities.styleTextField(emailTextField)
        Utilities.styleTextField(passwordTextField)
        Utilities.styleFilledButton(signupButton)
    }

    func validateFields() -> String? {
        if firstnameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            lastnameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""
        
            {
            
                return "Please fill in all fields."
        }
        let cleanedPassword = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        if Utilities.isPasswordValid(cleanedPassword) == false {
            
            return "Please make sure your password is at least 8 characters, contains a special character and a number."
        }
        return nil
    }

    
    @IBAction func signupTapped(_ sender: Any) {
        
        let error = validateFields()
        if error != nil {
            
           showError(error!)
        }
        else {
            let firstName = firstnameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let lastName = lastnameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            Auth.auth().createUser(withEmail: email, password: password ) { (Result,err) in
            
                if err != nil {
                    self.showError("Error creating user")
                }
                else {
                    let db = Firestore.firestore()
                    db.collection("users").addDocument(data: ["firstname":firstName, "lastname":lastName, "uid": Result!.user.uid]) { (error) in
                        if error != nil{
                            self.showError("Error saving user data")
                        }
                    }
                    self.transitionToHome()
                    
                }
            }
            
        }
    }
    func showError(_ message:String) {
    
        errorLabel.text = message
               errorLabel.alpha = 1
}
    func transitionToHome() {
        let homeViewController = storyboard?.instantiateViewController(identifier: Constants.Storyboard.homeViewController) as? homeViewController
        
        view.window?.rootViewController = homeViewController
        view.window?.makeKeyAndVisible()

    }
    
}
