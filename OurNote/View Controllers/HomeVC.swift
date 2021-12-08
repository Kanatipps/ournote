//
//  HomeVC.swift
//  OurNote
//
//  Created by Kana thip on 21/11/2564 BE.
//

import UIKit
import Firebase
import FirebaseAuth

class HomeVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let db = Firestore.firestore()
    var data = [classModel]()
    
    func numberOfSections(in tableView: UITableView) -> Int {
            return 1
        }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return data.count ?? 0
        }
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) ->            UITableViewCell {
                let cell:ClassCell = tableView.dequeueReusableCell(withIdentifier: "classCell") as! ClassCell
//                cell.cardtitle.text = data[indexPath.row].cardname ?? ""
                let tapGesture = UITapGestureRecognizer(target: self, action: #selector(ontap(gesture:)))
                cell.tag = indexPath.row
                cell.addGestureRecognizer(tapGesture)
                return cell
           
        }
    
    @objc func ontap(gesture:UITapGestureRecognizer) {
        if let cell = gesture.view {
            print(cell.tag)
            performSegue(withIdentifier: "show_card", sender: data[cell.tag])
        }
    }
    
    func transitionToHome() {
        
        let navVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: Constants.Storyboard.initViewController)
        self.view.window?.rootViewController = navVC
        self.view.window?.makeKeyAndVisible()
    }
    @IBOutlet weak var tableview: UITableView!
    
    
    @IBAction func logoutTap(_ sender: Any) {
        DatabaseManager.shared.logout()
        transitionToHome()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.register(UINib(nibName: "noteCell", bundle: nil), forCellReuseIdentifier: "classCell")
}
    
}
