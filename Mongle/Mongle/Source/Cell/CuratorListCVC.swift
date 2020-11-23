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
    let deviceSize = UIScreen.main.bounds
    //var isSubscribed = false
    var subscriberNum : Int = 0
    var curatorIdx = -1
    let token = UserDefaults.standard.string(forKey: "token")
    var myVC : UIViewController?
    
    @IBOutlet weak var curatorNameLabel: UILabel!
    @IBOutlet weak var curatorProfileImageView: UIImageView!
    @IBOutlet weak var subscriberLabel: UILabel!
    @IBOutlet weak var curatorInfoLabel: UILabel!
    @IBOutlet weak var subscribeBTN: UIButton!
    
    
    @IBAction func touchUpSubscribe(_ sender: Any) {
        if token == "guest"{
            myVC?.presentLoginRequestPopUp()
        }
        else{
            follow(idx: curatorIdx)
        }
    }
    
    override func awakeFromNib() {
        subscribeBTN.layer.cornerRadius = 15
        subscriberLabel.text = "구독자 \(subscriberNum)명"
        subscriberLabel.textColor = .veryLightPink
        curatorInfoLabel.textColor = .veryLightPink
        subscribeBTN.setTitle("구독중",for: .selected)
        subscribeBTN.setTitleColor(UIColor(red:181/255,green:181/255,blue:181/255, alpha:1.0), for: .selected)
        subscribeBTN.setTitle("구독",for: .normal)
        subscribeBTN.setTitleColor(.white, for: .normal)
        curatorProfileImageView.makeRounded(cornerRadius: 65/2)
        curatorProfileImageView.contentMode = .scaleAspectFill
        if subscribeBTN.isSelected {
            subscribeBTN.backgroundColor = .veryLightPinkSeven
        }
        else{
            subscribeBTN.backgroundColor = .softGreen
        }
        
        self.backgroundColor = .white
        
    }
    func setLayout(){
        subscribeBTN.makeRounded(cornerRadius: 15)
        curatorProfileImageView.makeRounded(cornerRadius: 65/2)
    }
    func follow(idx: Int){
        CuratorFollowService.shared.follow(followedIdx: idx){ networkResult in
            switch networkResult {
            case .success(let searchResult):
                guard let data = searchResult as? Bool else {
                    return
                }
                print(data)
                if data{
                    self.subscribeBTN.isSelected = data
                    self.subscribeBTN.backgroundColor = .veryLightPinkSeven
                }
                else{
                    self.subscribeBTN.isSelected = data
                    self.subscribeBTN.backgroundColor = .softGreen
                }
                
            case .requestErr(let message):
                
                guard let message = message as? String else { return }
                
                
                print(message)
            case .pathErr:
                
                print("path")
            case .serverErr:
                print("serverErr")
            case .networkFail:
                print("networkFail")
            }
        
        }
    }
    
    
}
