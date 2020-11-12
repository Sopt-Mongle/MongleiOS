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
    var previousPage: UIViewController?
    var nextPage: UIViewController?
    var realNextPage: UIViewController?
    var keyValue = KVOObject()
    
    var onboardingDelegate: OnboardingDelegate?
    
    lazy var VCArray : [UIViewController] = {
        return [self.VCInstane(storyboardName: "OnboardingFirst", vcName: "OnboardingFirstVC"),
                self.VCInstane(storyboardName: "OnboardingFirst", vcName: "OnboardingSecondVC"),
                self.VCInstane(storyboardName: "OnboardingFirst", vcName: "OnboardingThirdVC"),
                self.VCInstane(storyboardName: "OnboardingFirst", vcName: "OnboardingFourthVC")
        ]
        
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        
        
        print("bb")
        
        
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
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
        if completed {
            previousPage = previousViewControllers[0]
            realNextPage = nextPage
            print(realNextPage)
            if realNextPage is Mongle.OnboardingFirstVC {
                self.keyValue.curPresentViewIndex = 0
                onboardingDelegate?.toNextPage(next: 0)
            }
            else if realNextPage is Mongle.OnboardingSecondVC{
                self.keyValue.curPresentViewIndex = 1
                onboardingDelegate?.toNextPage(next: 1)
            }
            else if realNextPage is Mongle.OnboardingThirdVC{
                self.keyValue.curPresentViewIndex = 2
                onboardingDelegate?.toNextPage(next: 2)
            }
            else{
                self.keyValue.curPresentViewIndex = 3
                onboardingDelegate?.toNextPage(next: 3)
            }
        }
        
    }
    
    
    
    
    func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
        nextPage = pendingViewControllers[0]
    }
    
    
    
}


