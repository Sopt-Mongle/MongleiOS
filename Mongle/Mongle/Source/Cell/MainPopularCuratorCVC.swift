//
//  MainPopularCuratorCVC.swift
//  Mongle
//
//  Created by 이주혁 on 2020/07/07.
//  Copyright © 2020 이주혁. All rights reserved.
//

import UIKit

class MainPopularCuratorCVC: UICollectionViewCell {
    static let identifier = "MainPopularCuratorCVC"
    
    @IBOutlet var profileImageView: UIImageView!
    @IBOutlet var profileNameLabel: UILabel!
    @IBOutlet var tagLabel: UILabel!
    
    override func awakeFromNib() {
        profileImageView.contentMode = .scaleAspectFill
        self.profileImageView.makeRounded(cornerRadius: profileImageView.frame.width / 2)
    }
    
    override func prepareForReuse() {
        self.profileImageView.makeRounded(cornerRadius: profileImageView.frame.width / 2)
    }
    
    func setData(imgUrl: String?, name: String, tag: String){
        if let url = imgUrl {
            self.profileImageView.imageFromUrl(imgUrl, defaultImgPath: "sentenceThemeOImgCurator1010")
        }
        else {
            self.profileImageView.image = UIImage(named: "sentenceThemeOImgCurator1010")
        }
        
        self.profileImageView.makeRounded(cornerRadius: profileImageView.frame.width / 2 )
        self.profileNameLabel.text = name
        self.tagLabel.text = tag
    }
    
}
