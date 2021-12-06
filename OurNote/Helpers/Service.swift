//
//  Service.swift
//  OurNote
//
//  Created by Kana thip on 25/11/2564 BE.
//

import Foundation
import UIKit
import Firebase
import FirebaseAuth

class Service {
    
    static func signUpUser(email: String, password: String,fName: String, lName: String, onSuccess: @escaping () -> Void, onError: @escaping (_ err: Error?) -> Void ) {
        let auth = Auth.auth()
        auth.createUser(withEmail: email, password: password) { ( authResult , err )  in
            if err != nil {
                onError(err!)
        }
            
            uploadTodatabase(email: email, fName: fName, lName: lName, onSuccess: onSuccess)

        }
    }
    
    static func uploadTodatabase(email:String , fName: String, lName: String, onSuccess: @escaping () -> Void) {
        let ref = Database.database().reference()
        let UID = Auth.auth().currentUser?.uid
        
        ref.child("users").child(UID!).setValue(["email" : email, "fName" : fName, "lName" : lName])
        
    }
    
    static func getUserinfo(onSuccess: @escaping () -> Void, onError: @escaping (_ err: Error?) -> Void ) {
        let ref = Database.database().reference()
        let defautlts = UserDefaults.standard

        guard let UID = Auth.auth().currentUser?.uid else {
            print("User not found")
            return
        }
        ref.child("users").child(UID).observe(.value, with: { (snapshot) in
            if let dictionary = snapshot.value as? [String : Any] {
                let email = dictionary["email"] as! String
                let fName = dictionary["fName"] as! String
                let lName = dictionary["lName"] as! String

                defautlts.set(email, forKey: "userEmailKey")
                defautlts.set(fName, forKey: "userFNameKey")
                defautlts.set(lName, forKey: "userLNameKey")

                onSuccess()
            }
        }) { (err) in
            onError(err)
        }
    }
    
    static func createAlertCon(title:String , messaage:String) -> UIAlertController {
    let alert = UIAlertController(title: title, message: messaage, preferredStyle: .alert)
        let okAct = UIAlertAction(title: "OK", style: .default) { (action) in alert.dismiss(animated: true, completion: nil)
        }
        alert.addAction(okAct)
        return alert
    }
    
    static func createAlertErr(title:String , messaage:String) -> UIAlertController {
    let alert = UIAlertController(title: title, message: messaage, preferredStyle: .alert)
        let errAct = UIAlertAction(title: "ERROR", style: .default) { (action) in alert.dismiss(animated: true, completion: nil)
        }
        alert.addAction(errAct)
        return alert
    }
}
