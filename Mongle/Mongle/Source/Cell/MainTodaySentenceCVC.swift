//
//  MainTodaySentenceCVC.swift
//  Mongle
//
//  Created by 이주혁 on 2020/07/07.
//  Copyright © 2020 이주혁. All rights reserved.
//

import UIKit

class MainTodaySentenceCVC: UICollectionViewCell {
    static let identifier = "MainTodaySentenceCVC"
    
    @IBOutlet var sentenceLabel: UILabel!
    @IBOutlet var bookLabel: UILabel!
    
    override func awakeFromNib() {
        self.makeRounded(cornerRadius: 10)
        self.backgroundColor = .white
        self.dropShadow(color: .black, offSet: CGSize(width: 0, height: 0), opacity: 0.07, radius: 8)
        self.setBorder(borderColor: UIColor(red: 179/255, green: 179/255, blue: 179/255, alpha: 0.24), borderWidth: 1)
    }
    
}
