//
//  RecentSearchCVC.swift
//  Mongle
//
//  Created by 이예슬 on 7/5/20.
//  Copyright © 2020 이주혁. All rights reserved.
//

import UIKit

class RecentSearchCVC: UICollectionViewCell {
    static let identifier = "recentSearchCVC"
    var cornerRadius: CGFloat = 0 {
        didSet (newValue) {
            self.layer.cornerRadius = newValue
            self.layer.masksToBounds = true
        }
    }
    
    override func awakeFromNib() {
        self.layer.cornerRadius = self.bounds.width / 7 - 1
    }
    @IBOutlet weak var recentSearchKeyLabel: UILabel!
    func setRecent(key:String){
        recentSearchKeyLabel.text = key
    }
    
}
