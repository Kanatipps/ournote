//
//  SignInVC.swift
//  OurNote
//
//  Created by Kana thip on 19/11/2564 BE.
//

import UIKit
import Firebase
import FirebaseAuth

class SignInVC: UIViewController {

    @IBOutlet weak var emailField: UITextField!
   
    @IBOutlet weak var password: UITextField!
   
    @IBOutlet weak var signInBT: UIButton!
    
    @IBOutlet weak var errLb: UILabel!
    
    @IBAction func signInBtTap(_ sender: Any) {
        DatabaseManager.shared.signInUser(email: emailField.text ?? "", password: password.text ?? "") { [weak self] (result) in
        DispatchQueue.main.async { [self] in
            switch result {
            case .success(let user):
                print("USER",user)
                self?.transitionToHome()
            case .failure(let error):
                let alert = UIAlertController(title: "Error", message: "Email หรือ ชื่อผู้ใช้ผิด", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                self?.present(alert, animated: true, completion: nil)
                self?.emailField.text! = ""
                self?.password.text! = ""
            }
        }
    }
        
    }
    
    func transitionToHome() {
        
        let homeViewController = storyboard?.instantiateViewController(identifier: Constants.Storyboard.homeViewController) as? HomeVC
        
        view.window?.rootViewController = homeViewController
        view.window?.makeKeyAndVisible()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpElements()
        DatabaseManager.shared.checkUID()
    }
    
    func setUpElements() {
        
        // Hide the error label
        errLb.alpha = 0
        
        // Style the elements
        Utilities.styleTextField(emailField)
        Utilities.styleTextField(password)
        Utilities.styleFilledButton(signInBT)
        
    }

    
}
