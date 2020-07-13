//
//  CuratorListCVC.swift
//  Mongle
//
//  Created by 이예슬 on 7/7/20.
//  Copyright © 2020 이주혁. All rights reserved.
//

import UIKit

class CuratorListCVC: UICollectionViewCell {
    static let identifier = "CuratorListCVC"
    //var isSubscribed = false
    
    @IBOutlet weak var curatorNameLabel: UILabel!
    @IBOutlet weak var curatorProfileImageView: UIImageView!
    @IBOutlet weak var subscriberLabel: UILabel!
    @IBOutlet weak var curatorInfoLabel: UILabel!
    @IBOutlet weak var subscribeBTN: UIButton!
    
    @IBAction func touchUpSubscribe(_ sender: Any) {
        subscribeBTN.isSelected.toggle()
        //print(subscribeBTN.isSelected)
        if subscribeBTN.isSelected {
            subscribeBTN.setTitle("구독중",for: .normal)
            subscribeBTN.backgroundColor = UIColor(red: 222/255, green: 222/255, blue: 222/255, alpha: 1.0)
            subscribeBTN.setTitleColor(UIColor(red:181/255,green:181/255,blue:181/255, alpha:1.0), for: .normal)
        }
        else{
            subscribeBTN.setTitle("구독",for: .normal)
            subscribeBTN.backgroundColor = .softGreen
            subscribeBTN.setTitleColor(.white, for: .normal)
        }
    }
    override func awakeFromNib() {
        subscribeBTN.layer.cornerRadius = subscribeBTN.frame.width/4
        subscribeBTN.backgroundColor = .softGreen
        subscriberLabel.text = "구독자 540명"
        subscriberLabel.textColor = .veryLightPink
        curatorInfoLabel.textColor = .veryLightPink
        //self.setBorder(borderColor: UIColor(red: 0, green: 0, blue: 0, alpha: 0.07), borderWidth: 1)
        //self.makeRounded(cornerRadius: 20)
        
        self.backgroundColor = .white
        
    }
    
    
    
}
