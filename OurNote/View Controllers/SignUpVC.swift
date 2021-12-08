//
//  SignUpVC.swift
//  OurNote
//
//  Created by Kana thip on 19/11/2564 BE.
//

import Foundation
import UIKit
import Firebase
import FirebaseAuth
import FirebaseFirestore

class SignUpVC: UIViewController {

    @IBOutlet weak var fNameField: UITextField!
    
    @IBOutlet weak var lNameField: UITextField!
    
    @IBOutlet weak var emailField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!
   
    @IBOutlet weak var errLb: UILabel!
    
    @IBOutlet weak var signUpBt: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpElements()
        }
    
    @IBAction func signUpBtTap(_ sender: Any) {
        guard GuardCheck() else {
            let alert = UIAlertController(title: "Error", message: "Please fill in all fields", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        guard Utilities.isPasswordValid(passwordField.text ?? "") == true else {
            let alert = UIAlertController(title: "Error", message: "Your password should have 6 Characters, special character and number.", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        guard Utilities.validateEmail(emailField.text ?? "") == true else {
            let alert = UIAlertController(title: "Error", message: "Please use the correct EMail format", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
            
        DatabaseManager.shared.signUpUser(email: emailField.text ?? "", password: passwordField.text ?? "", fName: fNameField.text ?? "", lName: lNameField.text ?? "") {[weak self] (result) in
               DispatchQueue.main.async { [self] in
                   switch result {
                   case .success(let user):
                       print("USER",user)
                       self?.transitionToHome()
                   case .failure(let error):
                       print("ERROR",error) //.localizedDescription
                       
                   }
               }
    }
    }
    
    func GuardCheck() -> Bool {
           if fNameField.text == "" || lNameField.text == "" || emailField.text == "" || passwordField.text == ""  {
               return false
           }
           return true
       }
    
    
    func showError(_ message:String) {
        
        errLb.text = message
        errLb.alpha = 1
    }
    
    func transitionToHome() {
        
        let homeViewController = storyboard?.instantiateViewController(identifier: Constants.Storyboard.homeViewController) as? HomeVC
        
        view.window?.rootViewController = homeViewController
        view.window?.makeKeyAndVisible()
        
    }
    
    func setUpElements() {
    
        errLb.alpha = 0
    
        Utilities.styleTextField(fNameField)
        Utilities.styleTextField(lNameField)
        Utilities.styleTextField(emailField)
        Utilities.styleTextField(passwordField)
        Utilities.styleFilledButton(signUpBt)
    }
    
}

    
