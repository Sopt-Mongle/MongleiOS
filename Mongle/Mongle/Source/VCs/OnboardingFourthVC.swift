//
//  OnboardingFourthVC.swift
//  Mongle
//
//  Created by Yunjae Kim on 2020/11/08.
//  Copyright © 2020 이주혁. All rights reserved.
//

import UIKit

class OnboardingFourthVC: UIViewController {

    
    
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var mongleImage: UIImageView!
    @IBOutlet weak var mentImage: UIImageView!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var lookAroundButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setItems()
        // Do any additional setup after loading the view.
    }
    
    func setItems(){
        backgroundImage.image = UIImage(named: "onboarding4Bg")
        mongleImage.image = UIImage(named: "onboarding4ImgMongle")
        mentImage.image = UIImage(named: "onboarding4Text")
        
        startButton.backgroundColor = .softGreen
        lookAroundButton.setTitleColor(.veryLightPink, for: .normal)
        startButton.makeRounded(cornerRadius: 27)
        
        
    }

    

}
