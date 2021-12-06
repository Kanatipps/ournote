//
//  HomeVC.swift
//  OurNote
//
//  Created by Kana thip on 21/11/2564 BE.
//

import UIKit
import Firebase
import FirebaseAuth

class HomeVC: UIViewController {
    
    @IBOutlet weak var welcomeLB: UILabel!
    

    override func viewDidLoad() {
        
//        let defautlts = UserDefaults.standard

        super.viewDidLoad()
        
//        Service.getUserinfo {
//            self.welcomeLB.text = "Welcome \(defautlts.string(forKey: "userFNameKey")!)"
//        } onError: { err in
//            self.present(Service.createAlertCon(title: "ERROR", messaage: err!.localizedDescription), animated: true, completion: nil)
//
//        }
//
//
//    }
//    @IBAction func LogOutTab(_ sender: Any) {
//        let auth = Auth.auth()
//
//        do {
//            try auth.signOut()
//            let defaults = UserDefaults.standard
//            defaults.set(false, forKey: "isUserSignedIn")
//
//            self.dismiss(animated: true, completion: nil)
//        } catch let signoutErr {
//            self.present(Service.createAlertCon(title: "ERROR", messaage: signoutErr.localizedDescription), animated: true, completion: nil)
//        }
//    }
    
}
}
