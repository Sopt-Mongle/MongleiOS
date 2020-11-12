//
//  OnboardingThirdVC.swift
//  Mongle
//
//  Created by Yunjae Kim on 2020/11/08.
//  Copyright © 2020 이주혁. All rights reserved.
//

import UIKit

class OnboardingThirdVC: UIViewController {
    
    
    
    @IBOutlet weak var mentImage: UIImageView!
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var booksImage: UIImageView!
    @IBOutlet weak var mongleImage: UIImageView!
    static var onboardingBDelegate: OnboardingButtonDelegate?
    static var onboardingTFDelegate : OnboardingThreeToFourDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setItems()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        startAnimation()
        
        
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        OnboardingThirdVC.onboardingTFDelegate?.hideButtons()
    }
    
    
    func setItems(){
        backgroundImage.image = UIImage(named: "onboarding3Bg")
        booksImage.image = UIImage(named: "onboarding3ImgBookshelf")
        mongleImage.image = UIImage(named: "onboarding3ImgMongle")
        mentImage.image = UIImage(named: "onboarding3Text")

        
    }
    
    func startAnimation(){
        let dur = 1.0
        let del = 0.0
        
        self.mongleImage.transform = CGAffineTransform(translationX: -341, y: 0)
        
        
        UIView.animate(withDuration: dur, delay: del, animations: {
            self.mongleImage.transform = .identity
            
            
            
            
        }, completion: { finished in
            
            UIView.animate(withDuration: 0.3, delay: 0, animations: {
                self.mongleImage.transform = CGAffineTransform(translationX: 0, y: -50)
                
                
            }, completion: {finish in
                UIView.animate(withDuration: 0.3, delay: 0, animations: {
                    self.mongleImage.transform = .identity
                    
                })
                
            })
            
            
            
        })
        
    }
    
    

    
    
}
