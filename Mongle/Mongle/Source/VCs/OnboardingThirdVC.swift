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
        
        
        
    }
    
    
    
    func setItems(){
        backgroundImage.image = UIImage(named: "onboarding3Bg")
        booksImage.image = UIImage(named: "onboarding3ImgBookshelf")
        mongleImage.image = UIImage(named: "onboarding3ImgMongle")
        mentImage.image = UIImage(named: "onboarding3Text")
        nextButton.backgroundColor = .softGreen
        nextButton.makeRounded(cornerRadius: 28)
        
        jumpButton.setTitleColor(.veryLightPink, for: .normal)
        
    }
    
    func startAnimation(){
        self.mongleImage.transform = CGAffineTransform(translationX: -341, y: 0)
        UIView.animate(withDuration: 1.0, delay: 0, animations: {
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
    
    
    @IBAction func nextButtonAction(_ sender: Any) {
        OnboardingThirdVC.onboardingBDelegate?.buttonNextPage(next: 3)
        
    }
    
   
}
