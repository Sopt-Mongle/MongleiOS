//
//  SentenceInfoTVC.swift
//  Mongle
//
//  Created by 이주혁 on 2020/07/12.
//  Copyright © 2020 이주혁. All rights reserved.
//

import UIKit

class SentenceInfoTVC: UITableViewCell {
    
    static let identifier = "SentenceInfoTVC"
    
    @IBOutlet var editButton: UIButton!
    @IBOutlet var sentenceLabel: UILabel!
    var sentence: String?
    
    var editButtonDelegate: ((UIAlertController) -> Void) = { _ in }
    


    override func awakeFromNib() {
        super.awakeFromNib()
        print(sentence)
        sentenceLabel.text = sentence ?? ""
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
    }
    
    
    @IBAction func touchUpEditButton(sender: UIButton) {
        
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        self.editButtonDelegate(actionSheet)
    }

}



extension UIAlertAction {
    var titleTextColor: UIColor? {
        get {
            return self.value(forKey: "titleTextColor") as? UIColor
        } set {
            self.setValue(newValue, forKey: "titleTextColor")
        }
    }
}
