//
//  NoteWrite.swift
//  OurNote
//
//  Created by Kana thip on 8/12/2564 BE.
//

import UIKit

class NoteWrite: UIViewController {

    @IBOutlet weak var titleTF: UITextField!
    @IBOutlet weak var textWrite: UITextView!
    @IBOutlet weak var save: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func saveTap(_ sender: Any) {

        DatabaseManager.shared.createNote(noteTitle: titleTF.text!, noteDtail: textWrite.text!)  { [self] (result) in
            DispatchQueue.main.async {
            switch result {
            case .success(let notedata):
                print("USER",notedata)
                self.transitionToHome()
            case .failure(let error):
                print("ERROR",error)
                
                }
            }
        }
    }
    func transitionToHome() {
        
        let homeViewController = storyboard?.instantiateViewController(identifier: Constants.Storyboard.homeViewController) as? HomeVC
        
        view.window?.rootViewController = homeViewController
        view.window?.makeKeyAndVisible()
        }
    
    
}

