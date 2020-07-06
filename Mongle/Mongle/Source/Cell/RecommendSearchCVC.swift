//
//  RecommendSearchCVC.swift
//  Mongle
//
//  Created by 이예슬 on 7/6/20.
//  Copyright © 2020 이주혁. All rights reserved.
//

import UIKit

class RecommendSearchCVC: UICollectionViewCell {
    
    @IBOutlet weak var recommendSearchKeyLabel: UILabel!
    
    func setRecommend(key:String){
        recommendSearchKeyLabel.text = key
    }
}
