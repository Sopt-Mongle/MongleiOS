//
//  SearchResultThemeTVC.swift
//  Mongle
//
//  Created by 이예슬 on 7/11/20.
//  Copyright © 2020 이주혁. All rights reserved.
//

import UIKit

class SearchResultThemeTVC: UITableViewCell {
    // MARK: - Outlet
    @IBOutlet weak var themeTitleLabel: UILabel!
    @IBOutlet weak var themeInfoLabel: UILabel!
    var bookmarkCount: String = "0"
    var sentenceCount: String = "0"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        themeTitleLabel.text = "번아웃을 극복하기 위해 봐야하는 문장"
        themeInfoLabel.textColor = .veryLightPink
        themeInfoLabel.text = "\(bookmarkCount) | 문장 \(sentenceCount)개"
        
        // Initialization code
    }
    func setCount(){
        themeInfoLabel.text = "\(bookmarkCount) | 문장 \(sentenceCount)개"
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
