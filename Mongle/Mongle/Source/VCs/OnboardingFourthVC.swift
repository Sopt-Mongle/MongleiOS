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
    
    @IBOutlet weak var mongleBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var mentTop: NSLayoutConstraint!
    
    static var onboardingBDelegate: OnboardingButtonDelegate?
    
    var dynamicAnimator   : UIDynamicAnimator!
    var gravityBehavior   : UIGravityBehavior!
    var collisionBehavior : UICollisionBehavior!
    var bouncingBehavior  : UIDynamicItemBehavior!

    override func viewDidLoad() {
        super.viewDidLoad()
        setItems()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        startAnimation()
        OnboardingThirdVC.onboardingTFDelegate?.hideButtons()
    }
    
    
    func setItems(){
        backgroundImage.image = UIImage(named: "onboarding4Bg")
        mongleImage.image = UIImage(named: "onboarding4ImgMongle")
        mentImage.image = UIImage(named: "onboarding4Text")
        
        startButton.backgroundColor = .softGreen
        lookAroundButton.setTitleColor(.veryLightPink, for: .normal)
        startButton.makeRounded(cornerRadius: 27)
        mongleContainView.backgroundColor = UIColor.black.withAlphaComponent(0)
        mongleBottomConstraint.constant = 286 * DeviceInfo.screenHeightRatio
        mentTop.constant = 116 * DeviceInfo.screenHeightRatio
    }
    
    func startAnimation(){
        mongleImage.alpha = 0
        lookAroundButton.alpha = 0
        startButton.alpha = 0
        UIView.animate(withDuration: 1.0, delay : 0.25, animations: { [weak self] in
            self?.lookAroundButton.alpha = 1
            self?.startButton.alpha = 1
        })
    
        
        UIView.animate(withDuration: 1.0,
                       delay: 0.0,
                       options: .curveEaseOut,
                       animations: { [weak self] in
            self?.mongleImage.alpha = 1.0
        }, completion: nil)
    }
    
    @IBAction func startButtonAction(_ sender: Any) {
        dismiss(animated: true, completion: { [weak self] in
            guard let vcName = UIStoryboard(name: "LogIn",
                                            bundle: nil).instantiateViewController(
                                                withIdentifier: "LogInVC") as? LogInVC
            else { return }
            
            vcName.modalPresentationStyle = .fullScreen
            self?.dismiss(animated: true, completion: nil)
            self?.present(vcName, animated: true, completion: nil)
        })
    }
    
    
    @IBAction func lookAroundButtonAction(_ sender: Any) {
        UserDefaults.standard.set("guest", forKey: "token")
        guard let vcName = UIStoryboard(
            name: "UnderTab",
            bundle: nil
        ).instantiateViewController(withIdentifier: "UnderTabBarController") as? UINavigationController
        else { return }
        
        vcName.modalPresentationStyle = .fullScreen
        self.dismiss(animated: true, completion: nil)
        self.present(vcName, animated: true, completion: nil)
    }
}
