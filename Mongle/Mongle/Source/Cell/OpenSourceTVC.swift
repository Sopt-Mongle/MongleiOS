//
//  OpenSourceTVC.swift
//  Mongle
//
//  Created by 이예슬 on 11/14/20.
//  Copyright © 2020 이주혁. All rights reserved.
//

import UIKit

class OpenSourceTVC: UITableViewCell {
    var titleText = ""
    @IBOutlet weak var titleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        titleLabel.text = titleText
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }

}
