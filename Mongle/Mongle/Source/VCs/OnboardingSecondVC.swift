//
//  OnboardingSecondVC.swift
//  Mongle
//
//  Created by Yunjae Kim on 2020/11/08.
//  Copyright © 2020 이주혁. All rights reserved.
//

import UIKit

class OnboardingSecondVC: UIViewController {
    
    
    @IBOutlet weak var mentImage: UIImageView!
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var curatorImage: UIImageView!
    @IBOutlet weak var mongleImage: UIImageView!
    
    @IBOutlet weak var jumpButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setItems()

        // Do any additional setup after loading the view.
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        startAnimation()
        
        
        
    }
    
    func setItems(){
        
        backgroundImage.image = UIImage(named: "onboarding2Bg")
        curatorImage.image = UIImage(named: "onboarding2ImgList")
        mongleImage.image = UIImage(named: "onboarding2ImgMongle")
        mentImage.image = UIImage(named: "onboarding2Text")
        
        nextButton.backgroundColor = .softGreen
        nextButton.makeRounded(cornerRadius: 28)
        
        
        jumpButton.setTitleColor(.veryLightPink, for: .normal)
        
    }
    
    
    func startAnimation(){
        curatorImage.alpha = 0
        UIView.animate(withDuration: 1.0, delay: 0.2, animations: {
            self.curatorImage.alpha = 1
            
        }, completion: nil)
        
    }

}
