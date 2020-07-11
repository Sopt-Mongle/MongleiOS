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
    
    @IBOutlet weak var checkImageView: UIImageView!
    
    //MARK:- User Define Variables
    static let identifier : String = "ThemeSelectionCell"
    
    
    //MARK:- LifeCycle Methods
    override func awakeFromNib() {
        themeImageView.image = UIImage(named: "mainImgTheme2")?.withRenderingMode(.alwaysOriginal)
        themeTitleLabel.text = "가나다라마"
       
        
    }
    
    //MARK:- User Define Functions
    func setItems(_ theme : ThemeForSentence, _ searchKeyWord : String, _ shouldBeChecked : Bool){
        themeImageView.image = UIImage(named: theme.imgName)?.withRenderingMode(.alwaysOriginal)
        themeTitleLabel.text = theme.themeTitle
        themeTitleLabel.textColor = .white
        checkImageView.image = UIImage(named: "themeImgCurator")
        checkImageView.alpha = 0
        
        guard let text = themeTitleLabel.text else {
            return
        }
       
        let attributedString = NSMutableAttributedString(string: themeTitleLabel.text!)
        attributedString.addAttribute(NSAttributedString.Key.foregroundColor,
                                      value: UIColor.softGreen,
                                      range: (text as NSString).range(of: searchKeyWord))
        themeTitleLabel.attributedText = attributedString
        
        if shouldBeChecked {
            checkImageView.alpha = 0.5
        }
        
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
