//
//  OnboardingMainVC.swift
//  Mongle
//
//  Created by Yunjae Kim on 2020/11/08.
//  Copyright © 2020 이주혁. All rights reserved.
//

import UIKit
import SwiftyGif

class OnboardingMainVC: UIViewController {
    

    @IBOutlet var circles: [UIView]!

    @IBOutlet var widths: [NSLayoutConstraint]!

    @IBOutlet weak var jumpButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    @IBOutlet weak var stackTopCons: NSLayoutConstraint!
    
    private var pageInstance : OnboardingPVC?
    private var nowIdx = 0
    
    private var imageView = UIImageView()
    private let containView = UIView()
    
    static var shouldShowSplash = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.delegate = self
        setItems()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if OnboardingMainVC.shouldShowSplash {
            showSplash()
        }
        
        OnboardingMainVC.shouldShowSplash = false
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "pageSegue"{
            pageInstance = segue.destination as? OnboardingPVC
        }
        pageInstance?.onboardingDelegate = self
        
        OnboardingFirstVC.onboardingBDelegate = self
        OnboardingSecondVC.onboardingBDelegate = self
        OnboardingThirdVC.onboardingBDelegate = self
        OnboardingThirdVC.onboardingTFDelegate = self
        
        OnboardingFourthVC.onboardingBDelegate = self
        
        stackTopCons.constant = 219 * DeviceInfo.screenHeightRatio
        nextButton.makeRounded(cornerRadius: 27)
        nextButton.backgroundColor = .softGreen
        
        jumpButton.setTitleColor(.veryLightPink, for: .normal)
    }
    
    func setItems(){
        containView.backgroundColor = UIColor(red: 251 / 255.0, green: 251 / 255.0, blue: 251 / 255.0, alpha: 1.0)
        widths[0].constant = 19
        circles[0].backgroundColor = .softGreen
        circles[0].makeRounded(cornerRadius: 3)
        
        for i in 1...3 {
            circles[i].backgroundColor = .veryLightPinkNine
            circles[i].makeRounded(cornerRadius: 3.5)
        }
    }
    
    func toPage(next : Int){
 
        if next == 3 {
            self.nextButton.alpha = 0
            self.jumpButton.alpha = 0
        }
        
        else {
            self.nextButton.alpha = 1
            self.jumpButton.alpha = 1
        }
        
        for i in 0...3 {
            if i == next {
                continue
            }
           
            widths[i].constant = 7
            circles[i].backgroundColor = .veryLightPinkNine
            circles[i].makeRounded(cornerRadius: 3.5)
        }
        
        UIView.animate(withDuration: 0.5, delay: 0.0, animations: { [weak self] in
            guard let self = self else { return }
            
            self.widths[next].constant = 19
            self.circles[next].backgroundColor = .softGreen
            self.circles[next].makeRounded(cornerRadius: 3)
            
        }, completion: nil)
    }
    
    
    @IBAction func nextButtonAction(_ sender: Any) {
        if nowIdx < 3{
            pageInstance?.setViewControllers([(pageInstance?.VCArray[nowIdx+1])!],
                                             direction: .forward,
                                             animated: true,
                                             completion: nil
            )
            
            toNextPage(next: nowIdx+1)
        }
    }
    
    @IBAction func jumpButtonAction(_ sender: Any) {
        guard let vcName = UIStoryboard(name: "LogIn", bundle: nil).instantiateViewController(
                                            withIdentifier: "LogInVC") as? LogInVC
        else { return }
        
        vcName.modalPresentationStyle = .fullScreen
        self.dismiss(animated: true, completion: nil)
        
        self.present(vcName, animated: true, completion: nil)
    }
}


extension OnboardingMainVC : OnboardingDelegate {
    func toNextPage(next: Int) {
        nowIdx = next
        self.toPage(next: next)
    }
}

extension OnboardingMainVC : OnboardingButtonDelegate {
    func buttonNextPage(next: Int) {
        nowIdx = next
        pageInstance?.setViewControllers([(pageInstance?.VCArray[next])!], direction: .forward,
        animated: true, completion: nil)
        
        toNextPage(next: next)
    }
}

extension OnboardingMainVC : OnboardingThreeToFourDelegate{
    
    func hideButtons() {
        if nowIdx != 1{
            UIView.animate(withDuration: 0.5, animations: {
                self.nextButton.alpha = 0
                self.jumpButton.alpha = 0
                
            })
        }
    }
}

protocol OnboardingDelegate: AnyObject {
    func toNextPage(next : Int)
}

protocol OnboardingButtonDelegate: AnyObject {
    func buttonNextPage(next : Int)
}

protocol OnboardingThreeToFourDelegate: AnyObject {
    func hideButtons()
}


extension OnboardingMainVC : SwiftyGifDelegate {    
    func gifDidStop(sender: UIImageView) {
        UIView.animate(withDuration: 1.0, animations: {
            
            self.imageView.removeFromSuperview()
            self.containView.alpha = 0
        })
    }
}
