//
//  classMaker.swift
//  OurNote
//
//  Created by Kana thip on 6/12/2564 BE.
//

import UIKit

class ClassMaker: UIViewController {


    @IBOutlet weak var className: UITextField!
    @IBOutlet weak var codeLB: UILabel!
    @IBOutlet weak var createClBT: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpElements()
        // Do any additional setup after loading the view.
        
    }
    
    func CheckGuard() -> Bool {
        if className.text == "" {
            return false
        }
        return true
    }
    
    @IBAction func createClassTap(_ sender: Any) {
        
        guard  CheckGuard() else {
            let alert = UIAlertController(title: "Error", message: "กรอกข้อมูลให้ครบถ้วน", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        DatabaseManager.shared.createNote(note_title: className.text!) { [weak self] (result) in
            DispatchQueue.main.async {
        switch result {
            case .success(let classdata):
                print("classdata = ",classdata)
                DatabaseManager.shared.updateNoteID()
                self?.transitionToHome()

            case .failure(let error):
                print("ERROR",error)                    }
                }
            }
    }
    
    func transitionToHome() {
        
        let homeViewController = storyboard?.instantiateViewController(identifier: Constants.Storyboard.homeViewController) as? HomeVC
        
        view.window?.rootViewController = homeViewController
        view.window?.makeKeyAndVisible()
        
    }
    
    func setUpElements() {
        
//        codeLB.alpha = 0
        
        Utilities.styleTextField(className)
        Utilities.styleFilledButton(createClBT)
        
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
