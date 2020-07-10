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
        $0.setImage(UIImage(named: "plustabIc"), for: .normal)
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
        $0.backgroundColor = .blur1
    }
    
    
    
    
    
    // MARK:- LifeCycleFunctions

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setTabBar()
        print(self.tabBar.frame.height)
       
        
        
    }
    

    
    
    // MARK:- Class Functions
    
    func setTabBar(){
        self.tabBar.frame.size.height = self.tabBar.frame.height + 10
        
        
//        Setting bar properties
        self.tabBar.barStyle = .black
        self.tabBar.barTintColor = .white
        self.tabBar.unselectedItemTintColor = .gray
        self.tabBar.tintColor = .black
        
        let appearance = UITabBarItem.appearance()
        let attributes = [NSAttributedString.Key.font:UIFont(name:
            "American Typewriter", size: 15)]
        appearance.titlePositionAdjustment = UIOffset(horizontal: 0,
                                                      vertical: -0.205*self.tabBar.frame.height)
    
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
            $0.bottom.equalTo(self.view.safeAreaInsets.bottom).offset(-41) //should be changed : not exact
            
        }
        plusButton.addTarget(self, action: #selector(plusButtonAction(sender:)),
                             for: .touchUpInside)
        
        
        writeSentenceButton.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(plusButton.snp.top).offset(13)
            $0.width.equalTo(88)
            $0.height.equalTo(40)
            
        }
        writeSentenceButton.makeRounded(cornerRadius: 20)
        writeSentenceButton.titleLabel?.font = UIFont(name:
        "American Typewriter", size: 15)
        writeSentenceButton.dropShadow(color: .black, offSet: CGSize(width: 0, height: 3), opacity: 0.28, radius: 10)
        
        makeThemeButton.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(writeSentenceButton.snp.top).offset(-13)
            $0.width.equalTo(104)
            $0.height.equalTo(40)
        }
        
        makeThemeButton.makeRounded(cornerRadius: 20)
        makeThemeButton.addTarget(self,
                                  action: #selector(makeThemeButtonAction), for: .touchUpInside)
        makeThemeButton.titleLabel?.font = UIFont(name:
        "American Typewriter", size: 15)
        writeSentenceButton.addTarget(self, action: #selector(makeSentenceButtonAction), for: .touchUpInside)
        
        
//        Setting temporary VCs to check implementation
        
        guard let mainVC = UIStoryboard(name: "MainTabMain", bundle: nil)
            .instantiateViewController(identifier: "MainTabMainVC") as? MainTabMainVC else {
                return
        }
      
        let curatorVC = UIViewController()
        let myVC = UIViewController()
     
        guard let searchVC = UIStoryboard(name: "SearchTabMain",
                                        bundle: nil).instantiateViewController(
                                            withIdentifier: "SearchTabMainVC") as? SearchTabMainVC
            else{
            
            return
        }
        
        
        
        let tmpVC = UIViewController() // dummy VC for spacing (should be modified to offset)
      
        
        mainVC.title = "메인"
        searchVC.title = "검색"
        curatorVC.title = "큐레이터"
        myVC.title = "내 서재"
        tmpVC.title = ""
        
        mainVC.view.backgroundColor = .white
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
        UIView.animate(withDuration: 0.25 , delay: 0, options: [.curveEaseIn], animations: {
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
        UIView.animate(withDuration: 0.25 , delay: 0, options: [.curveEaseIn], animations: {
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
    
    @objc func makeThemeButtonAction(sender: UIButton?){
        guard let vcName = UIStoryboard(name: "Writing_Theme",
                                        bundle: nil).instantiateViewController(
                                            withIdentifier: "WritingThemeVC") as? WritingThemeVC
            else{
            return
        }
        hideSubMenus()
        vcName.modalPresentationStyle = .fullScreen
        
        self.present(vcName, animated: true, completion: nil)
        
    }
    
    @objc func makeSentenceButtonAction(sender: UIButton?){
        guard let vcName = UIStoryboard(name: "WritingSentence",
                                        bundle: nil).instantiateViewController(
                                            withIdentifier: "WritingSentenceVC") as? WritingSentenceVC
            else{
                return
        }
        hideSubMenus()
        vcName.modalPresentationStyle = .fullScreen
        
        self.present(vcName, animated: true, completion: nil)
        
    }
    
    

}
