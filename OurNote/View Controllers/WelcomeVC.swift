//
//  WelcomeVC.swift
//  OurNote
//
//  Created by Kana thip on 19/11/2564 BE.
//

import UIKit

class WelcomeVC: UIViewController {

    @IBOutlet weak var signInBT: UIButton!
    @IBOutlet weak var signUP: UIButton!
    
    override func viewDidLoad() {
            super.viewDidLoad()
        setUpElements()
        
//        let defaults = UserDefaults.standard
//
//        if defaults.bool(forKey: "isUserSignedIn") {
//            let viewCon = self.storyboard?.instantiateViewController(withIdentifier: "welcomeUID") as! UINavigationController
//            viewCon.modalTransitionStyle = .crossDissolve
//            viewCon.modalPresentationStyle = .overFullScreen
//            self.present(viewCon, animated: true, completion: nil)
//
//
//        }

    }
    
    @IBAction func signInTabBT(_ sender: Any) {
        self.performSegue(withIdentifier: "signInLine", sender: nil)
    }
    @IBAction func signUpTabBT(_ sender: Any) {
        self.performSegue(withIdentifier: "signUpLine", sender: nil)
    }
    
    func setUpElements() {
        
        Utilities.styleFilledButton(signInBT)
        Utilities.styleHollowButton(signUP)
        
    }
    
    
    

}
