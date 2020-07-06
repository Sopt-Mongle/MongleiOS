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
    
    @IBOutlet weak var recentSearchKeyLabel: UILabel!
    func setRecent(key:String){
        recentSearchKeyLabel.text = key
    }
    
}
