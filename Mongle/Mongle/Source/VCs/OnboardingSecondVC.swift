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
        
        nextButton.backgroundColor = .softGreen
        nextButton.makeRounded(cornerRadius: 28)
        
        
        jumpButton.setTitleColor(.veryLightPink, for: .normal)
        
    }
    
    
    func startAnimation(){
        curatorImage.alpha = 0
        curatorImage.transform = CGAffineTransform(translationX: 0, y: 150)
        UIView.animate(withDuration: 1.0, delay: 0.2, animations: {
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
    
    
    @IBAction func nextButtonAction(_ sender: Any) {
        OnboardingSecondVC.onboardingBDelegate?.buttonNextPage(next: 2)
        
        
    }
    
    

}
