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
    @IBOutlet var blurView: UIView!
    @IBOutlet var themaNameLabel: UILabel!
    
    
    
    var blurStyle: BlurStyle = .blue
    
    override func awakeFromNib() {
        self.makeRounded(cornerRadius: 10)
        
        switch blurStyle {
        case .blue:
            blurView.backgroundColor = UIColor(red: 0, green: 0, blue: 1, alpha: 0.3)
            
        case .green:
            blurView.backgroundColor = UIColor(red: 0, green: 1, blue: 0, alpha: 0.3)
        case .red:
            blurView.backgroundColor = UIColor(red: 1, green: 0, blue: 0, alpha: 0.3)
        }
    }
}



// MARK:- Enum Blur Style
enum BlurStyle {
    case blue, green, red
}
