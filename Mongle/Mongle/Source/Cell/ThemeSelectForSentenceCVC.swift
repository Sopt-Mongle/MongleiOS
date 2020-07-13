//
//  ThemeSelectForSentenceCVC.swift
//  Mongle
//
//  Created by Yunjae Kim on 2020/07/10.
//  Copyright © 2020 이주혁. All rights reserved.
//

import UIKit
import SnapKit
import Then

class ThemeSelectForSentenceCVC: UICollectionViewCell {
    
    
    //MARK:- IBOutlets
    
    @IBOutlet weak var themeImageView: UIImageView!

    @IBOutlet weak var themeTitleLabel: UILabel!
    
    @IBOutlet weak var checkImageView: UIImageView!
    
    @IBOutlet weak var leadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var topContraint: NSLayoutConstraint!
    //MARK:- User Define Variables
    static let identifier : String = "ThemeSelectionCell"
    
    

    
    //MARK:- LifeCycle Methods
    override func awakeFromNib() {
        themeImageView.image = UIImage(named: "mainImgTheme2")?.withRenderingMode(.alwaysOriginal)
        themeTitleLabel.text = "가나다라마"
        
    }
    
    //MARK:- User Define Functions
    func setItems(_ theme : ThemeForSentence, _ searchKeyWord : String, _ shouldBeChecked : Bool){
        if theme.state == true
            {
            themeImageView.image = UIImage(named: theme.imgName)?.withRenderingMode(.alwaysOriginal)
            themeTitleLabel.text = theme.themeTitle
            themeTitleLabel.textColor = .white
            checkImageView.image = UIImage(named: "writingTheme3ImgCheck")
            checkImageView.alpha = 0
            
            guard let text = themeTitleLabel.text else {
                return
            }
            
            let attributedString = NSMutableAttributedString(string: themeTitleLabel.text!)
            attributedString.addAttribute(NSAttributedString.Key.foregroundColor,
                                          value: UIColor.softGreen,
                                          range: (text as NSString).range(of: searchKeyWord))
            themeTitleLabel.attributedText = attributedString
           topContraint.constant = 18
           leadingConstraint.constant = 19
                themeTitleLabel.textAlignment = .left

            if shouldBeChecked {
                checkImageView.alpha = 1
            }
        }
        
        else{
            themeImageView.image = UIImage(named: theme.imgName)?.withRenderingMode(.alwaysOriginal)
            themeTitleLabel.text = theme.themeTitle
            themeTitleLabel.textColor = .white
            themeTitleLabel.textAlignment = .center
            
            topContraint.constant = 74
            checkImageView.image = UIImage(named: "writingTheme3ImgCheck")
            checkImageView.alpha = 0
            if shouldBeChecked {
                checkImageView.alpha = 1
            }
            
            
        }
    }
    
  
    
    
}


struct ThemeForSentence {
    var imgName : String
    var themeTitle : String
    var state : Bool
    
    init(imgName : String, themeTitle : String, state : Bool) {
        self.imgName = imgName
        self.themeTitle = themeTitle
        self.state = state
    }
    
    
}
