//
//  SettingTVC.swift
//  Mongle
//
//  Created by 이주혁 on 2020/07/13.
//  Copyright © 2020 이주혁. All rights reserved.
//

import UIKit

class SettingTVC: UITableViewCell {
    static let identifier = "SettingTVC"
    var myVC: MySettingVC?
    @IBOutlet var settingNameLabel: UILabel!
    @IBOutlet weak var cellSelectButton: UIImageView!
    @IBOutlet weak var pushAllowBackground: UIView!
    @IBOutlet weak var pushAllowButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.pushAllowBackground.makeRounded(cornerRadius: 10)
    }
    
    @IBAction func touchUpPushSwitch(_ sender: Any) {
        UIView.animate(withDuration: 0.2,delay:0,options:[.curveEaseIn],animations:{
                                                                        self.pushAllowButton.transform = CGAffineTransform(translationX: 12, y: 0)
                                                                        self.pushAllowBackground.backgroundColor = .softGreen},
                       completion:{_ in UIView.animate(withDuration: 0.2,delay:0.1,options:[.curveEaseOut],animations:{
                                                                                                        self.pushAllowButton.transform = CGAffineTransform(translationX: 0, y: 0)
                                                                                                        self.pushAllowBackground.backgroundColor = UIColor(red: 198/255, green: 198/255, blue: 198/255, alpha: 1)},
                                                                                                    completion:{_ in
                                                                                                        self.myVC!.toggleToast()
                                                                                                        
                                                                                                    })})
            
        
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
}
extension UIView {
    var parentViewController: UIViewController? {
        var parentResponder: UIResponder? = self
        while parentResponder != nil {
            parentResponder = parentResponder!.next
            if let viewController = parentResponder as? UIViewController {
                return viewController
            }
        }
        return nil
    }
}
