//
//  ThemeSelectForSentenceCVC.swift
//  Mongle
//
//  Created by Yunjae Kim on 2020/07/10.
//  Copyright © 2020 이주혁. All rights reserved.
//

import UIKit

class ThemeSelectForSentenceCVC: UICollectionViewCell {
    
    
    //MARK:- IBOutlets
    
    @IBOutlet weak var themeImageView: UIImageView!

    @IBOutlet weak var themeTitleLabel: UILabel!
    
    
    //MARK:- User Define Variables
    static let identifier : String = "ThemeSelectionCell"
    
    
    //MARK:- LifeCycle Methods
    override func awakeFromNib() {
        themeImageView.image = UIImage(named: "mainImgTheme2")?.withRenderingMode(.alwaysOriginal)
        themeTitleLabel.text = "가나다라마"
       
        
    }
    
    //MARK:- User Define Functions
    func setItems(_ theme : ThemeForSentence){
        themeImageView.image = UIImage(named: theme.imgName)
        themeTitleLabel.text = theme.themeTitle
        
    }
    
    
    
}


struct ThemeForSentence {
    var imgName : String
    var themeTitle : String
    
    init(imgName : String, themeTitle : String) {
        self.imgName = imgName
        self.themeTitle = themeTitle
    }
    
    
}
