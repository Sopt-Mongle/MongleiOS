//
//  OnboardingFirstVC.swift
//  Mongle
//
//  Created by Yunjae Kim on 2020/11/08.
//  Copyright © 2020 이주혁. All rights reserved.
//

import UIKit

class OnboardingFirstVC: UIViewController {

    //MARK: - IBOutlets
    
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var bookImage: UIImageView!
    @IBOutlet weak var mongleImage: UIImageView!
    @IBOutlet weak var mentImage: UIImageView!
    
    @IBOutlet weak var jumpButton: UIButton!
    
    @IBOutlet weak var nextButton: UIButton!
    
    static var onboardingBDelegate: OnboardingButtonDelegate?
    
    
    //MARK: - LifeCycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setItems()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        startAnimation()
        
    }

    
    //MARK: - User Define Functions
    
    func setItems(){
        backgroundImage.image = UIImage(named: "onboarding1Bg")
        bookImage.image = UIImage(named: "onboarding1ImgBook")
        mongleImage.image = UIImage(named: "onboarding1ImgMongle")
        
        mentImage.image = UIImage(named: "onboarding1Text")
        nextButton.backgroundColor = .softGreen
        nextButton.makeRounded(cornerRadius: 28)
        
        jumpButton.setTitleColor(.veryLightPink, for: .normal)
        
        
    }
    
    func startAnimation(){
       
        UIView.animate(withDuration: 0.3, delay: 0, animations: {
            self.bookImage.transform = CGAffineTransform(rotationAngle: -30/180)
            
            
            
            
        }, completion: { finished in
            
            UIView.animate(withDuration: 0.3, delay: 0, animations: {
                self.bookImage.transform = CGAffineTransform(rotationAngle: 15/80)
                
                
            }, completion: {finish in
                UIView.animate(withDuration: 0.3, delay: 0, animations: {
                    self.bookImage.transform = .identity
                
                })
                
            })
           
           
            
        })
        
    }
    
    @IBAction func nextButtonAction(_ sender: Any) {
        OnboardingFirstVC.onboardingBDelegate?.buttonNextPage(next: 1)
        print("called")
    }
    
}
