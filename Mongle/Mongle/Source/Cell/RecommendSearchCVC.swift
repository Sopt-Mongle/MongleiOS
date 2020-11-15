//
//  RecommendSearchCVC.swift
//  Mongle
//
//  Created by 이예슬 on 7/6/20.
//  Copyright © 2020 이주혁. All rights reserved.
//

import UIKit

class RecommendSearchCVC: UICollectionViewCell {
    static let identifier = "RecommendSearchCVC"
    @IBOutlet weak var recommendSearchKeyLabel: UILabel!
    
    override func awakeFromNib() {
//        self.layer.cornerRadius = self.bounds.width / 7 - 3
        self.layer.cornerRadius = 19
    }
    
    func setRecommend(key:String){
        recommendSearchKeyLabel.text = key
        
    }
}
