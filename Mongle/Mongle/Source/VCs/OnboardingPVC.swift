//
//  OnboardingPVC.swift
//  Mongle
//
//  Created by Yunjae Kim on 2020/11/08.
//  Copyright © 2020 이주혁. All rights reserved.
//

import UIKit

class OnboardingPVC: UIPageViewController {

    
    let identifiers = ["OnboardingFirstVC","OnboardingSecondVC","OnboardingThirdVC","OnboardingFourthVC"]
    
    lazy var VCArray : [UIViewController] = {
        return [self.VCInstane(storyboardName: "OnboardingFirst", vcName: "OnboardingFirstVC"),
                self.VCInstane(storyboardName: "OnboardingFirst", vcName: "OnboardingSecondVC"),
                self.VCInstane(storyboardName: "OnboardingFirst", vcName: "OnboardingThirdVC"),
                self.VCInstane(storyboardName: "OnboardingFirst", vcName: "OnboardingFourthVC")
        ]
        
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(self.transitionStyle.rawValue)
        
        self.dataSource = self
        self.delegate = self
        
     
        if let firstVC = VCArray.first{
            setViewControllers([firstVC], direction: .forward, animated: true, completion: nil)
        }

        // Do any additional setup after loading the view.
    }
    
    private func VCInstane(storyboardName : String, vcName : String) ->UIViewController{
        return UIStoryboard(name : storyboardName, bundle : nil).instantiateViewController(withIdentifier: vcName)
        
    }

    

   

}

extension OnboardingPVC : UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let vcIdx = VCArray.firstIndex(of: viewController) else {return nil}
        
        let prevIdx = vcIdx - 1
        
    
        print("aa")
        
        
        if(prevIdx < 0){
            return nil
            
        }
        else{
           
//            vcName.upperTabCV.selectItem(at: cIdx, animated: true, scrollPosition: .right)
//            vcName.something()
//            vcName.upperTabCV.selectItem(at: cIdx, animated: true, scrollPosition: .left)
            
//            vcName.something()
            
            return VCArray[prevIdx]
        }
        
        
        
        
        
    }
    

    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let vcIdx = VCArray.firstIndex(of: viewController) else {return nil}
        
        let nextIdx = vcIdx + 1
        print("aa")
      
        if(nextIdx >= VCArray.count){
            return nil
        }
        else{
         
            return VCArray[nextIdx]
        }
        
     
        
        
        
    }
    
    
    
    
    
    
    
    
}
