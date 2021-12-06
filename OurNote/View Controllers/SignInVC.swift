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
        
//        let email = emailField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
//        let password = password.text!.trimmingCharacters(in: .whitespacesAndNewlines)
//
//        // Signing in the user
//        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
//
//            if error != nil {
//                // Couldn't sign in
//                self.errLb.text = error!.localizedDescription
//                self.errLb.alpha = 1
//            }
//            else {
//
//                let homeViewController = self.storyboard?.instantiateViewController(identifier: Constants.Storyboard.homeViewController) as? HomeVC
//                self.view.window?.rootViewController = homeViewController
//                self.view.window?.makeKeyAndVisible()
//            }
//        }
    }
        
//        let auth = Auth.auth()
//        let defautlts = UserDefaults.standard

//
//        auth.signIn(withEmail: emailField.text! , password: password.text!) { (authResult, err ) in
//            if err != nil {
//                self.present(Service.createAlertCon(title: "ERROR", messaage: err!.localizedDescription), animated: true, completion: nil)
//                return
//            }
//            defautlts.set(true, forKey: "isUserSignedIn")
//            self.performSegue(withIdentifier: "signInWelcome", sender: nil)
//        }
    
    func transitionToHome() {
        
        let homeViewController = storyboard?.instantiateViewController(identifier: Constants.Storyboard.homeViewController) as? HomeVC
        
        view.window?.rootViewController = homeViewController
        view.window?.makeKeyAndVisible()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpElements()
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
