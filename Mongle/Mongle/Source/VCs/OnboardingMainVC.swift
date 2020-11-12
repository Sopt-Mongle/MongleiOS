//
//  OnboardingMainVC.swift
//  Mongle
//
//  Created by Yunjae Kim on 2020/11/08.
//  Copyright © 2020 이주혁. All rights reserved.
//

import UIKit

class OnboardingMainVC: UIViewController {
    

    @IBOutlet var circles: [UIView]!

    @IBOutlet var widths: [NSLayoutConstraint]!
    var pageInstance : OnboardingPVC?
    var nowIdx = 0
    
    @IBOutlet weak var jumpButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setItems()
        // Do any additional setup after loading the view.
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
        
        
        
        nextButton.makeRounded(cornerRadius: 27)
        nextButton.backgroundColor = .softGreen
        
        jumpButton.setTitleColor(.veryLightPink, for: .normal)
        
        
    }
    
    func setItems(){
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
//            UIView.animate(withDuration: 0.5, animations: {
                self.nextButton.alpha = 0
                self.jumpButton.alpha = 0
                
//            }, completion: nil)
            
        }
        else{
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
        
        UIView.animate(withDuration: 0.5, delay: 0.0, animations: {
            self.widths[next].constant = 19
            self.circles[next].backgroundColor = .softGreen
            self.circles[next].makeRounded(cornerRadius: 3)
            
        }, completion: nil)
        
        
        
        
        
    }
    
    
    @IBAction func nextButtonAction(_ sender: Any) {
        if nowIdx < 3{
            pageInstance?.setViewControllers([(pageInstance?.VCArray[nowIdx+1])!], direction: .forward,
            animated: true, completion: nil)
            
            toNextPage(next: nowIdx+1)
            
        }
       
        
        
    }
    
    
    
    
}


extension OnboardingMainVC : OnboardingDelegate {
    func toNextPage(next: Int) {
        self.toPage(next: next)
        nowIdx = next
    }
    
    
    
}

extension OnboardingMainVC : OnboardingButtonDelegate {
    func buttonNextPage(next: Int) {
        pageInstance?.setViewControllers([(pageInstance?.VCArray[next])!], direction: .forward,
        animated: true, completion: nil)
        nowIdx = next
        toNextPage(next: next)
        
    }
}

extension OnboardingMainVC : OnboardingThreeToFourDelegate{
    
    func hideButtons() {
        UIView.animate(withDuration: 0.5, animations: {
            self.nextButton.alpha = 0
            self.jumpButton.alpha = 0
            
        })
        
        
    }
    
}

protocol OnboardingDelegate {
    
    func toNextPage(next : Int)
    
    
    
}

protocol OnboardingButtonDelegate{
    
    func buttonNextPage(next : Int)
    
}

protocol OnboardingThreeToFourDelegate {
    
    func hideButtons()
    
}
