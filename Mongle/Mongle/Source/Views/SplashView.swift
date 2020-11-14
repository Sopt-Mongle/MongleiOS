//
//  SplashView.swift
//  Mongle
//
//  Created by Yunjae Kim on 2020/11/13.
//  Copyright © 2020 이주혁. All rights reserved.
//

import UIKit
import SwiftyGif

class SplashView: UIView {
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        do{
            let gif = try UIImage(gifName: "Comp 3")
            let imageView = UIImageView(gifImage: gif,loopCount: 1)
            imageView.frame = self.bounds
            self.addSubview(imageView)
            
            
        } catch{
            print(error)
        }
        
        
        
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    
}
