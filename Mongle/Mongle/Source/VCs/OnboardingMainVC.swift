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
    var pageInstance : OnboardingPVC?
    var nowIdx = 0
    
    @IBOutlet weak var jumpButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    @IBOutlet weak var stackTopCons: NSLayoutConstraint!
    var runCount = 0
    var imageView = UIImageView()
    let containView = UIView()
    
    static var shouldShowSplash = false
    
    let deviceBound = UIScreen.main.bounds.height/812.0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.delegate = self
        setItems()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if(OnboardingMainVC.shouldShowSplash){
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
        
        
        stackTopCons.constant = 219*deviceBound
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
    
    func showSplash(){
        
        self.view.addSubview(containView)
        containView.frame = self.view.bounds
        
       
        do{
            let gif = try UIImage(gifName: "Comp 4")
//            imageView = UIImageView(gifImage: gif,loopCount: 1)
            imageView.setGifImage(gif, manager: .defaultManager, loopCount: 1)
        
            self.view.addSubview(imageView)
            imageView.snp.makeConstraints{
                $0.width.equalTo(350)
                $0.height.equalTo(200)
                $0.center.equalToSuperview()

            }
        
            
        } catch{
            print(error)
        }
//        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
//            self.runCount += 1
//            if self.runCount == 30 {
//                timer.invalidate()
//
//
//            }
//        }
        
        
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
    
    @IBAction func jumpButtonAction(_ sender: Any) {
        guard let vcName = UIStoryboard(name: "LogIn",
                                        bundle: nil).instantiateViewController(
                                            withIdentifier: "LogInVC") as? LogInVC
        else{
            return
        }
        
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

protocol OnboardingDelegate {
    
    func toNextPage(next : Int)
    
    
    
}

protocol OnboardingButtonDelegate{
    
    func buttonNextPage(next : Int)
    
}

protocol OnboardingThreeToFourDelegate {
    
    func hideButtons()
    
}


extension OnboardingMainVC : SwiftyGifDelegate {

    func gifURLDidFinish(sender: UIImageView) {
        print("gifURLDidFinish")
    }

    func gifURLDidFail(sender: UIImageView) {
        print("gifURLDidFail")
    }

    func gifDidStart(sender: UIImageView) {
        print("gifDidStart")
    }
    
    func gifDidLoop(sender: UIImageView) {
        print("gifDidLoop")
    }
    
    func gifDidStop(sender: UIImageView) {
        print("gifDidStop")
        UIView.animate(withDuration: 1.0, animations: {
            
            self.imageView.removeFromSuperview()
            self.containView.alpha = 0
        })
    }
}
