//
//  UnderTabBarController.swift
//  Mongle
//
//  Created by Yunjae Kim on 2020/07/06.
//  Copyright © 2020 이주혁. All rights reserved.
//

import UIKit
import SnapKit
import Then

class UnderTabBarController: UITabBarController {
    
    // MARK:- UIComponents
    
    let plusButton = UIButton().then {
        $0.backgroundColor = .black
    }
    let makeThemeButton = UIButton().then {
        $0.alpha = 0
        $0.setTitle("테마 만들기", for: .normal)
        $0.backgroundColor = .white
        $0.setTitleColor(.black, for: .normal)
    }
    let writeSentenceButton = UIButton().then {
        $0.alpha = 0
        $0.setTitle("문장 쓰기", for: .normal)
        $0.backgroundColor = .white
        $0.setTitleColor(.black, for: .normal)
    }
    let blurView = UIView().then {
        $0.alpha = 0
        $0.backgroundColor = .blur
    }
    
    
    
    
    
    // MARK:- LifeCycleFunctions

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setTabBar()
        
        
    }
    

    
    
    // MARK:- Class Functions
    
    func setTabBar(){
        
        
//        Setting bar properties
        self.tabBar.barStyle = .black
        self.tabBar.barTintColor = .white
        let appearance = UITabBarItem.appearance()
        let attributes = [NSAttributedString.Key.font:UIFont(name:
            "American Typewriter", size: 20)]
        appearance.setTitleTextAttributes(attributes as
            [NSAttributedString.Key : Any], for: .normal)
        
//        adding button, blur view
        self.view.addSubview(blurView)
        self.view.addSubview(makeThemeButton)
        self.view.addSubview(writeSentenceButton)
        self.view.addSubview(plusButton)
        
        
//        setting contraints
        blurView.snp.makeConstraints {
            $0.top.left.right.equalToSuperview()
            $0.bottom.equalTo(self.view.snp_bottomMargin).offset(-self.tabBar.frame.height)
            
        }
        blurView.addGestureRecognizer(UITapGestureRecognizer(target: self,
                                                             action: #selector(blurViewDidTap)))
        
        plusButton.snp.makeConstraints{
            $0.width.height.equalTo(65)
            $0.centerX.equalToSuperview()
            $0.top.equalTo(self.view.snp_bottomMargin).offset(-80)
            
        }
        plusButton.addTarget(self, action: #selector(plusButtonAction(sender:)),
                             for: .touchUpInside)
        
        
        writeSentenceButton.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(plusButton.snp.top)
            $0.width.equalTo(88)
            $0.height.equalTo(40)
            
        }
        writeSentenceButton.makeRounded(cornerRadius: 20)
        
        makeThemeButton.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(writeSentenceButton.snp.top).offset(-18)
            $0.width.equalTo(104)
            $0.height.equalTo(40)
        }
        makeThemeButton.makeRounded(cornerRadius: 20)
        makeThemeButton.addTarget(self,
                                  action: #selector(makeThemeButtonAction), for: .touchUpInside)
        
        
//        Setting temporary VCs to check implementation
        
        let mainVC = UIViewController()
        let searchVC = UIViewController()
        let curatorVC = UIViewController()
        let myVC = UIViewController()
        
        let tmpVC = UIViewController() // dummy VC for spacing (should be modified to offset)
      
        
        mainVC.title = "메인"
        searchVC.title = "검색"
        curatorVC.title = "큐레이터"
        myVC.title = "내 서재"
        tmpVC.title = ""
        
        mainVC.view.backgroundColor = .red
        searchVC.view.backgroundColor = .yellow
        curatorVC.view.backgroundColor = .brown
        myVC.view.backgroundColor = .systemPink
        
        tmpVC.view.backgroundColor = .black
        
        
        
        
        
//        Adding ViewControllers to TabBar
        
        self.viewControllers = [mainVC,searchVC,tmpVC,curatorVC,myVC]
        

//        Disabling tmpVC
        if let arrayOfTabBarItems = self.tabBar.items as AnyObject as? NSArray,let
           tabBarItem = arrayOfTabBarItems[2] as? UITabBarItem {
           tabBarItem.isEnabled = false
        }
        
        
        
        
    }
    
    
//        When PlustButton is Tapped
    private func showSubMenus(){
        UIView.animate(withDuration: 1 , delay: 0, options: [.curveEaseIn], animations: {
            self.plusButton.transform = CGAffineTransform(rotationAngle: .pi/4)
            [self.blurView, self.makeThemeButton, self.writeSentenceButton].forEach{
                $0.alpha = 1
                if $0 != self.blurView {
                    $0.transform = CGAffineTransform(translationX: 0, y: -25)
                }
            }
            
        },completion: nil)
        
        
    }
    
//        When BlurView is Tapped or Plus Button is Re-Tapped
    private func hideSubMenus(){
            UIView.animate(withDuration: 1 , delay: 0, options: [.curveEaseIn], animations: {
                self.plusButton.transform = CGAffineTransform.identity
                [self.blurView, self.makeThemeButton, self.writeSentenceButton].forEach{
                    $0.alpha = 0
                    if $0 != self.blurView {
                        $0.transform = CGAffineTransform(translationX: 0, y: 25)
                    }
                }
                
            },completion: nil)
        
        
        
        
    }
    
    
    

    
    // MARK:- Button Functions + Blur view Tapped
    @objc func plusButtonAction(sender: UIButton) {
           sender.isSelected.toggle()
           
           if sender.isSelected { showSubMenus() }
           else { hideSubMenus() }
           
       }
    
   @objc private func blurViewDidTap() {
         hideSubMenus()
     }
    
    @objc func makeThemeButtonAction(sender: UIButton){
        guard let vcName = self.storyboard?.instantiateViewController(withIdentifier:
            "WritingThemeVC") as? WritingThemeVC else{
            return
        }
        vcName.modalTransitionStyle = .coverVertical
        self.present(vcName, animated: true, completion: nil)
        
    }
    
    

}