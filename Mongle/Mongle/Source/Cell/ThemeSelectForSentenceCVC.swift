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
import Kingfisher

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
        checkImageView.contentMode = .scaleAspectFit
//        themeImageView.contentMode = .scaleAspectFill
        
    }
    
    //MARK:- User Define Functions
    func setItems(_ theme : ThemeForSentence, _ searchKeyWord : String, _ shouldBeChecked : Bool, isFirst :  Bool){
        
        if theme.state == true
        {
            if isFirst == true {
                themeImageView.image = UIImage(named: "writingSentenceTheme3ImgThemeX")
                
            }
            else{
                
                
                themeImageView.imageFromUrl(theme.imgName, defaultImgPath: "")
                
            }
            //            themeImageView.image = UIImage(named: "writingSentenceTheme3ImgThemeX")
            themeTitleLabel.text = theme.themeTitle
            themeTitleLabel.textColor = .white
            checkImageView.image = UIImage(named: "writingSentenceTheme3ImgSelect")
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
            if isFirst == true {
                themeImageView.image = UIImage(named: "writingSentenceTheme3ImgThemeX")
                
            }
            else{
                themeImageView.imageFromUrl(theme.imgName, defaultImgPath: "")
            }
            themeTitleLabel.text = theme.themeTitle
            themeTitleLabel.textColor = .white
//            themeTitleLabel.textAlignment = .center
            
//            topContraint.constant = 74
            checkImageView.image = UIImage(named: "writingSentenceTheme3ImgSelect")
            checkImageView.alpha = 0
            if shouldBeChecked {
                checkImageView.alpha = 1
            }
            
            
        }
    }
    
    func partialGreen(keyword : String){
        
        
        themeTitleLabel.textColor = .white
        let attributedString = NSMutableAttributedString(string: themeTitleLabel.text!)
        print("엥",keyword)
        attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.softGreen,
                                      range: (themeTitleLabel.text! as NSString).range(of: keyword))
        themeTitleLabel.attributedText = attributedString
        
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
