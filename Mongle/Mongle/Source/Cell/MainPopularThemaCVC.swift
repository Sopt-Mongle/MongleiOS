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
    
    @IBOutlet var bookMarkImageView: UIImageView!
    
    override func awakeFromNib() {
        self.makeRounded(cornerRadius: 10)
    }
    
    func setData(name: String, count: Int, imageUrl: String, isBookMark: Bool){
        self.themaNameLabel.text = name
        self.sentenceCountLabel.text = "문장 \(count)개"
        if isBookMark {
            bookMarkImageView.image = UIImage(named: "mainIcBookmark1")
//            mainIcBookmark1
//            themeIcBookmarkGreen
        }
        else {
            bookMarkImageView.image = UIImage(named: "themeIcBookmarkGreen")
        }
        self.backgroundImageView.imageFromUrl(imageUrl, defaultImgPath: "writingSentenceTheme3ImgThemeX")
        
    }
}
