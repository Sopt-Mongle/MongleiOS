//
//  SettingTVC.swift
//  Mongle
//
//  Created by 이주혁 on 2020/07/13.
//  Copyright © 2020 이주혁. All rights reserved.
//

import UIKit
protocol PushAllowDelegate{
    func sendPushAllow(_ isPushAllowd: Bool) -> Bool
}
class SettingTVC: UITableViewCell {
    static let identifier = "SettingTVC"
    
    var pushAllowDelegate: PushAllowDelegate?
    var isPushAllowed: Bool = false
    
    @IBOutlet var settingNameLabel: UILabel!
    @IBOutlet weak var cellSelectButton: UIImageView!
    @IBOutlet weak var pushAllowBackground: UIView!
    @IBOutlet weak var pushAllowButton: UIButton!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.pushAllowBackground.makeRounded(cornerRadius: 10)
    }

    @IBAction func touchUpPushSwitch(_ sender: Any) {
        if pushAllowButton.isSelected{
            pushAllowButton.isSelected = false
            UIView.animate(withDuration: 0.2){
                self.pushAllowButton.transform = CGAffineTransform(translationX: 0, y: 0)
                self.pushAllowBackground.backgroundColor = UIColor(red: 198/255, green: 198/255, blue: 198/255, alpha: 1)
            }
            
        }
        else{
            pushAllowButton.isSelected = true
            
            
            UIView.animate(withDuration: 0.2){
                self.pushAllowButton.transform = CGAffineTransform(translationX: 7, y: 0)
                self.pushAllowBackground.backgroundColor = .softGreen
            }
            
        }
        isPushAllowed = pushAllowButton.isSelected
        print(pushAllowButton.isSelected)
        print(isPushAllowed)
        pushAllowDelegate?.sendPushAllow(self.isPushAllowed)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
