//
//  OnboardingFourthVC.swift
//  Mongle
//
//  Created by Yunjae Kim on 2020/11/08.
//  Copyright © 2020 이주혁. All rights reserved.
//

import UIKit

class OnboardingFourthVC: UIViewController {
    
    
    @IBOutlet weak var mongleContainView: UIView!
    
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var mongleImage: UIImageView!
    @IBOutlet weak var mentImage: UIImageView!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var lookAroundButton: UIButton!
    @IBOutlet weak var mongleTopConstraint: NSLayoutConstraint!
    
    static var onboardingBDelegate: OnboardingButtonDelegate?
    var dynamicAnimator   : UIDynamicAnimator!
    var gravityBehavior   : UIGravityBehavior!
    var collisionBehavior : UICollisionBehavior!
    var bouncingBehavior  : UIDynamicItemBehavior!
    
    @IBOutlet weak var mongleBottomConstraint: NSLayoutConstraint!
    let deviceBound = UIScreen.main.bounds.height/812.0
    
    @IBOutlet weak var mentTop: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setItems()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        startAnimation3()
    }
    
    
    func setItems(){
        backgroundImage.image = UIImage(named: "onboarding4Bg")
        mongleImage.image = UIImage(named: "onboarding4ImgMongle")
        mentImage.image = UIImage(named: "onboarding4Text")
        
        startButton.backgroundColor = .softGreen
        lookAroundButton.setTitleColor(.veryLightPink, for: .normal)
        startButton.makeRounded(cornerRadius: 27)
        mongleContainView.backgroundColor = UIColor.black.withAlphaComponent(0)
        mongleBottomConstraint.constant = 286*deviceBound
        mentTop.constant = 116*deviceBound
       
        
    }
    
    func startAnimation(){
        mongleImage.alpha = 0
        
        UIView.animate(withDuration: 0.3, delay: 0.3, animations: {
            self.mongleImage.transform = CGAffineTransform(rotationAngle: -30/180)
            self.mongleImage.alpha = 0.3
        }, completion: { finished in
            
            UIView.animate(withDuration: 0.6, delay: 0, animations: {
                self.mongleImage.transform = CGAffineTransform(rotationAngle: 30/180)
                
            }, completion: {finish in
                UIView.animate(withDuration: 0.3, delay: 0, animations: {
                    self.mongleImage.transform = .identity
                    self.mongleImage.alpha = 1
                })
                
            })
            
            
            
        })
        
        
    }
    
    func startAnimation2(){
        mongleImage.transform = CGAffineTransform(translationX: 100, y: -100)
        
        let pos1 = CGAffineTransform(translationX: 66, y: -66)
        let rot1 = CGAffineTransform(rotationAngle: -.pi/8)
        
        let combine1 = pos1.concatenating(rot1)
        
        let pos2 = CGAffineTransform(translationX: 33, y: -33)
        let rot2 = CGAffineTransform(rotationAngle: .pi/8)
        let combine2 = pos2.concatenating(rot2)
        
        UIView.animate(withDuration: 0.1, delay: 0.0, animations: {
            self.mongleImage.transform = combine1
            
        }, completion: { finished in
            
            UIView.animate(withDuration: 0.2, delay: 0, animations: {
                self.mongleImage.transform = combine2
                
            }, completion: {finish in
                UIView.animate(withDuration: 0.1, delay: 0, animations: {
                    self.mongleImage.transform = .identity
                })
                
            })
            
            
            
        })
    }
    
    func startAnimation3(){
        mongleImage.alpha = 0
        lookAroundButton.alpha = 0
        startButton.alpha = 0
        UIView.animate(withDuration: 1.0, delay : 0.25, animations: {
            
            self.lookAroundButton.alpha = 1
            self.startButton.alpha = 1
        })
    
        
        UIView.animate(withDuration: 1.0, delay: 0.0, options: .curveEaseOut, animations: {
            self.mongleImage.alpha = 1.0
        }, completion: nil)
        
        
        
        
    }
    
    func startAnimation4(){
        
        
        dynamicAnimator = UIDynamicAnimator(referenceView: self.view) //1
        
        gravityBehavior = UIGravityBehavior(items: [mongleImage]) //2
        dynamicAnimator.addBehavior(gravityBehavior) //3
        
        collisionBehavior = UICollisionBehavior(items: [mongleImage]) //4
        collisionBehavior.translatesReferenceBoundsIntoBoundary = true //5
        dynamicAnimator.addBehavior(collisionBehavior) //6
        
        //Adding the bounce effect
        bouncingBehavior = UIDynamicItemBehavior(items: [mongleImage]) //7
        bouncingBehavior.elasticity = 0.5 //8
        dynamicAnimator.addBehavior(bouncingBehavior) //9
        
        
    }
    
    @IBAction func startButtonAction(_ sender: Any) {
        dismiss(animated: true, completion: {
            
            guard let vcName = UIStoryboard(name: "LogIn",
                                            bundle: nil).instantiateViewController(
                                                withIdentifier: "LogInVC") as? LogInVC
            else{
                return
            }
            
            vcName.modalPresentationStyle = .fullScreen
            self.present(vcName, animated: true, completion: nil)
            
        })
        
        
    }
    
    
    
    
}
