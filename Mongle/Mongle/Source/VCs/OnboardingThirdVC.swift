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
    
    @IBOutlet weak var mentTop: NSLayoutConstraint!
    
    @IBOutlet weak var bookBottom: NSLayoutConstraint!
    
    @IBOutlet weak var mongleBottom: NSLayoutConstraint!
    
    static var onboardingBDelegate: OnboardingButtonDelegate?
    static var onboardingTFDelegate : OnboardingThreeToFourDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setItems()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        startAnimation()
    }

    func setItems(){
        backgroundImage.image = UIImage(named: "onboarding3Bg")
        booksImage.image = UIImage(named: "onboarding3ImgBookshelf")
        mongleImage.image = UIImage(named: "onboarding3ImgMongle")
        mentImage.image = UIImage(named: "onboarding3Text")

        mentTop.constant = 116 * DeviceInfo.screenHeightRatio
        bookBottom.constant = 205 * DeviceInfo.screenHeightRatio
        mongleBottom.constant = 208 * DeviceInfo.screenHeightRatio
    }
    
    func startAnimation(){
        let duration = 1.0
        let delay = 0.0
        
        self.mongleImage.transform = CGAffineTransform(translationX: -341, y: 0)
        
        UIView.animate(withDuration: duration, delay: delay, animations: { [weak self] in
            self?.mongleImage.transform = .identity
        }, completion: { [weak self] _ in
            UIView.animate(withDuration: 0.3, delay: 0, animations: { [weak self] in
                self?.mongleImage.transform = CGAffineTransform(translationX: 0, y: -50)
            }, completion: { [weak self] _ in
                UIView.animate(withDuration: 0.3, delay: 0, animations: { [weak self] in
                    self?.mongleImage.transform = .identity
                })
            })
        })
    }
}
