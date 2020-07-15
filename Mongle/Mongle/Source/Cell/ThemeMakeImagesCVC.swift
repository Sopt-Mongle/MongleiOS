//
//  themeMakeImagesCVC.swift
//  Mongle
//
//  Created by Yunjae Kim on 2020/07/12.
//  Copyright © 2020 이주혁. All rights reserved.
//

import UIKit
import Kingfisher


class ThemeMakeImagesCVC: UICollectionViewCell {
    static let identifier : String = "themeMakeImages"
    
    @IBOutlet weak var themeImage: UIImageView!
    @IBOutlet weak var checkImage: UIImageView!
    
    
    
    override func awakeFromNib() {
        
        
        
    }
    
    
    func setItems(_ imgURLName : String, _ check : Bool){
        checkImage.image = UIImage(named: "writingTheme3ImgCheck")?.withRenderingMode(.alwaysOriginal)
        checkImage.alpha = 0
        themeImage.imageFromUrl(imgURLName, defaultImgPath: "")
        
        if(check == true){
            checkImage.alpha = 1
        }
       
        
        
    }
    
    
}
