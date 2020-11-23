//
//  AccountEditTVC.swift
//  Mongle
//
//  Created by 이예슬 on 11/3/20.
//  Copyright © 2020 이주혁. All rights reserved.
//

import UIKit

class AccountEditTVC: UITableViewCell {
    
    static let identifier = "AccountEditTVC"

    @IBOutlet weak var accountEditMenuLabel: UILabel!
    
    var accountEditMenu = ""
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
