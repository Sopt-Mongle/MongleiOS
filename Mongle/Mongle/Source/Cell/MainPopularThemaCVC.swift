//
//  MainPopularThemaCVC.swift
//  Mongle
//
//  Created by 이주혁 on 2020/07/07.
//  Copyright © 2020 이주혁. All rights reserved.
//

import UIKit

class MainPopularThemaCVC: UICollectionViewCell {
    static let identifier = "MainPopularThemaCVC"
    
    @IBOutlet var backgroundImageView: UIImageView!
    @IBOutlet var themaNameLabel: UILabel!
    @IBOutlet var sentenceCountLabel: UILabel!
    @IBOutlet var bookMarkCountLabel: UILabel!
    
    override func awakeFromNib() {
        self.makeRounded(cornerRadius: 10)
    }
}
