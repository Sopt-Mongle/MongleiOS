//
//  themeMakeImagesCVC.swift
//  Mongle
//
//  Created by Yunjae Kim on 2020/07/12.
//  Copyright © 2020 이주혁. All rights reserved.
//

import UIKit

class ThemeMakeImagesCVC: UICollectionViewCell {
    static let identifier : String = "themeMakeImages"
    
    @IBOutlet weak var themeImage: UIImageView!
    @IBOutlet weak var checkImage: UIImageView!
    
    
    
    override func awakeFromNib() {
        
        
        
    }
    
    
    func setItems(_ imgName : String, _ check : Bool){
        checkImage.image = UIImage(named: "maengleCharacters")
        checkImage.alpha = 0
        themeImage.image = UIImage(named: imgName)
        
        if(check == true){
            checkImage.alpha = 0.5
        }
       
        
        
    }
    
    
}
