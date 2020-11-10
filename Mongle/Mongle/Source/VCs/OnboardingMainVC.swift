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
    static var nowIdx = 0
    
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
        OnboardingFourthVC.onboardingBDelegate = self
        
        
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
    
    
    
    
}


extension OnboardingMainVC : OnboardingDelegate {
    func toNextPage(next: Int) {
        self.toPage(next: next)
    }
    
    
    
}

extension OnboardingMainVC : OnboardingButtonDelegate {
    func buttonNextPage(next: Int) {
        pageInstance?.setViewControllers([(pageInstance?.VCArray[next])!], direction: .forward,
        animated: true, completion: nil)
        
        toNextPage(next: next)
        
    }
}

protocol OnboardingDelegate {
    
    func toNextPage(next : Int)
    
    
    
}

protocol OnboardingButtonDelegate{
    
    func buttonNextPage(next : Int)
    
}
