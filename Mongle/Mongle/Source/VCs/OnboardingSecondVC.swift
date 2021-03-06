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
    let deviceBound = UIScreen.main.bounds.height/812.0

    @IBOutlet weak var mentTop: NSLayoutConstraint!

    @IBOutlet weak var curatorBottom: NSLayoutConstraint!
    @IBOutlet weak var mongleBottom: NSLayoutConstraint!
    
    static var onboardingBDelegate: OnboardingButtonDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        setItems()
        
        // Do any additional setup after loading the view.
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        startAnimation()
        
        
        mongleImage.image = UIImage(named: "onboarding2ImgMongle")
        mongleImage.transform = .identity
        mongleImage.alpha = 1
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        endAnimation()
    }
    
    func setItems(){
        
        backgroundImage.image = UIImage(named: "onboarding2Bg")
        curatorImage.image = UIImage(named: "onboarding2ImgList")
        mongleImage.image = UIImage(named: "onboarding2ImgMongle")
        mentImage.image = UIImage(named: "onboarding2Text")

        mentTop.constant = 116*deviceBound
        curatorBottom.constant = 245*deviceBound
        mongleBottom.constant = 202*deviceBound
        
    }
    
    
    func startAnimation(){
        curatorImage.alpha = 0
        curatorImage.transform = CGAffineTransform(translationX: 0, y: 150)
        UIView.animate(withDuration: 1.5, delay: 0.2, animations: {
            self.curatorImage.alpha = 1
            self.curatorImage.transform = .identity
            
        }, completion: nil)
        
    }
    
    func endAnimation(){
        
        UIView.animate(withDuration: 1.0, delay: 0, animations: {
            self.mongleImage.image = UIImage(named: "onboarding3ImgMongle")
            
        }, completion: { finished in
            
            self.mongleImage.alpha = 0
            
        })
        
        
        
        
    }
    
    

    
    
    
}
