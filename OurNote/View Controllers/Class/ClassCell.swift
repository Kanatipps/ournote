//
//  ClassCell.swift
//  OurNote
//
//  Created by Kana thip on 7/12/2564 BE.
//

import UIKit

class ClassCell: UITableViewCell {
    
    @IBOutlet weak var ClassName: UILabel!
    
    func numberOfSections(in tableView: UITableView) -> Int {
            return 1
        }
        
//        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//            return data.count ?? 0
//        }
//        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//            let cell:CreateCardTableViewCell = tableView.dequeueReusableCell(withIdentifier: "cardcell") as! CreateCardTableViewCell
//            cell.cardtitle.text = data[indexPath.row].cardname ?? ""
//            return cell
//        }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
