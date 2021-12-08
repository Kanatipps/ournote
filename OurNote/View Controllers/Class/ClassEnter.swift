//
//  ClassEnter.swift
//  OurNote
//
//  Created by Kana thip on 7/12/2564 BE.
//

import UIKit
import Firebase

class ClassEnter: UIViewController {
    
    var classMod = [noteModel]()

    @IBOutlet weak var classCodeTF: UITextField!
    @IBOutlet weak var joinclassBT: UIButton!
    @IBOutlet weak var createClassBT: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpElements()

    }
    
    func setUpElements() {
        
        Utilities.styleTextField(classCodeTF)
        Utilities.styleFilledButton(joinclassBT)
        Utilities.styleFilledButton(createClassBT)

        
    }
    
    @IBAction func joinClassTap(_ sender: Any) {

           }

}
