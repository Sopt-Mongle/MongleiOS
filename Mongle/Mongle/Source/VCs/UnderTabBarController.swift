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
    
    var curIndex: Int = 0
    let token = UserDefaults.standard.string(forKey: "token")
    var runCountForSplash = 0
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
    
    let seperateLine = UIView().then {
        $0.backgroundColor = .veryLightPinkFour
        
        
    }
    let deviceBound = UIScreen.main.bounds.height/812.0
    
    
    // MARK:- LifeCycleFunctions

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.delegate = self
        setTabBar()
        if(OnboardingMainVC.shouldShowSplash){
            showSplash()
        }
        OnboardingMainVC.shouldShowSplash = false
        
        
    }
    

    
    
    override func viewDidLayoutSubviews() {
        
        
        
    
        super.viewDidLayoutSubviews()
        if(deviceBound < 1){
            tabBar.frame.size.height = 83*deviceBound - 10
            tabBar.frame.origin.y = view.frame.height - 83*deviceBound
            seperateLine.snp.makeConstraints{
                
                $0.bottom.equalToSuperview().offset(-self.tabBar.frame.size.height-10)
                $0.height.equalTo(1)
                $0.leading.trailing.equalToSuperview()
                
            }
            
            blurView.snp.makeConstraints {
                $0.top.left.right.equalToSuperview()
                //            $0.bottom.equalTo(self.view.snp_bottomMargin).offset(-80)
                $0.bottom.equalToSuperview().offset(-self.tabBar.frame.size.height - 10)
                
                
                
            }
            
            plusButton.snp.makeConstraints{
                $0.width.height.equalTo(65*1/((1/sqrt(deviceBound))))
//                $0.width.height.equalTo(65*deviceBound*deviceBound)
                $0.centerX.equalToSuperview()
                //            $0.bottom.equalTo(self.view.safeAreaInsets.bottom).offset(-41) //should be changed : not exact
                $0.bottom.equalToSuperview().offset(-30*deviceBound)
            }
            plusButton.dropShadow(color: .black, offSet: CGSize(width:  0 , height: 6*1/((1/sqrt(deviceBound)))), opacity: 0.11, radius: 6)
        }
        else {
            tabBar.frame.size.height = 83*deviceBound
            tabBar.frame.origin.y = view.frame.height - 83*deviceBound
            seperateLine.snp.makeConstraints{
                
                $0.bottom.equalToSuperview().offset(-self.tabBar.frame.size.height)
                $0.height.equalTo(1)
                $0.leading.trailing.equalToSuperview()
                
            }
            blurView.snp.makeConstraints {
                $0.top.left.right.equalToSuperview()
                //            $0.bottom.equalTo(self.view.snp_bottomMargin).offset(-80)
                $0.bottom.equalToSuperview().offset(-self.tabBar.frame.size.height)
                
                
                
            }
            plusButton.snp.makeConstraints{
//                $0.width.height.equalTo(65*1/((1/sqrt(deviceBound))))
                $0.width.height.equalTo(65*deviceBound*deviceBound)
                $0.centerX.equalToSuperview()
                //            $0.bottom.equalTo(self.view.safeAreaInsets.bottom).offset(-41) //should be changed : not exact
                $0.bottom.equalToSuperview().offset(-30*deviceBound)
            }
            plusButton.dropShadow(color: .black, offSet: CGSize(width:  0 , height: 6*deviceBound*deviceBound), opacity: 0.16, radius: 4)
            
            
        }
        
        print(deviceBound)
       
        

        
    }
    



    // MARK:- Class Functions
    
    func setTabBar(){
        

        

        
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
        
        
        self.view.addSubview(seperateLine)
//        adding button, blur view
        self.view.addSubview(blurView)
        self.view.addSubview(makeThemeButton)
        self.view.addSubview(writeSentenceButton)
        self.view.addSubview(plusButton)
        
        
        


       
//        setting contraints
        
        
        blurView.addGestureRecognizer(UITapGestureRecognizer(target: self,
                                                             action: #selector(blurViewDidTap)))
        
        
        plusButton.addTarget(self, action: #selector(plusButtonAction(sender:)),
                             for: .touchUpInside)
        
        plusButton.dropShadow(color: .black11, offSet: CGSize(width: 0, height: 6), opacity: 0.28, radius: 10)
        
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
        makeThemeButton.dropShadow(color: .black, offSet: CGSize(width: 0, height: 3), opacity: 0.28, radius: 15)
        writeSentenceButton.addTarget(self, action: #selector(makeSentenceButtonAction), for: .touchUpInside)
        
        
//        Setting temporary VCs to check implementation
        
        guard let mainVC = UIStoryboard(name: "MainTabMain", bundle: nil)
            .instantiateViewController(identifier: "MainTabMainVC") as? MainTabMainVC else {
                return
        }
      
        guard let curatorVC = UIStoryboard(name:"CuratorTabMain",bundle:nil).instantiateViewController(identifier: "CuratorTabMainVC") as? CuratorTabMainVC else {
            return
            
        }
        guard let myVC = UIStoryboard(name: "MyTab",
                                        bundle: nil).instantiateViewController(
                                            withIdentifier: "MyTabVC") as? MyTabVC
            else{
            
            return
        }
     
        guard let searchVC = UIStoryboard(name: "SearchTabMain",
                                        bundle: nil).instantiateViewController(
                                            withIdentifier: "SearchTabMainVC") as? SearchTabMainVC
            else{
            
            return
        }
        
        
        
        let tmpVC = UIViewController() // dummy VC for spacing (should be modified to offset)
      
        
        mainVC.title = ""
        searchVC.title = ""
        curatorVC.title = ""
        myVC.title = ""
        tmpVC.title = ""
        
        mainVC.view.backgroundColor = .white
        
        tmpVC.view.backgroundColor = .black
        
        
        
        
        
        
        //        Adding ViewControllers to TabBar
        
        self.viewControllers = [mainVC,searchVC,tmpVC,curatorVC,myVC]
        let myTabBarItem1 = (self.tabBar.items?[0])! as UITabBarItem
        let myTabBarItem2 = (self.tabBar.items?[1])! as UITabBarItem
        let myTabBarItem3 = (self.tabBar.items?[2])! as UITabBarItem
        let myTabBarItem4 = (self.tabBar.items?[3])! as UITabBarItem
        let myTabBarItem5 = (self.tabBar.items?[4])! as UITabBarItem
        
        
        myTabBarItem1.image = UIImage(named : "navigationBar3IcMain")?.withRenderingMode(.alwaysOriginal)
        myTabBarItem1.selectedImage = UIImage(named : "navigationBar2IcMain")?.withRenderingMode(.alwaysOriginal)
        
        myTabBarItem2.image = UIImage(named : "navigationBar3IcSearch")?.withRenderingMode(.alwaysOriginal)
        myTabBarItem2.selectedImage = UIImage(named : "navigationBar2IcSearch")?.withRenderingMode(.alwaysOriginal)
        
    
        
        myTabBarItem4.image = UIImage(named : "navigationBar3IcCurator")?.withRenderingMode(.alwaysOriginal)
        myTabBarItem4.selectedImage = UIImage(named : "navigationBar2IcCurator")?.withRenderingMode(.alwaysOriginal)
        
        myTabBarItem5.image = UIImage(named : "navigationBar1IcMy_un")?.withRenderingMode(.alwaysOriginal)
        myTabBarItem5.selectedImage = UIImage(named : "navigationBar1IcMy")?.withRenderingMode(.alwaysOriginal)
        
        
        //        Disabling tmpVC
        if let arrayOfTabBarItems = self.tabBar.items as AnyObject as? NSArray,let
           tabBarItem = arrayOfTabBarItems[2] as? UITabBarItem {
           tabBarItem.isEnabled = false
        }
        
        if deviceBound > 1{
            myTabBarItem1.imageInsets = UIEdgeInsets(top: 27*(1-deviceBound), left: 0, bottom: -27*(1-deviceBound), right: 0)
            myTabBarItem2.imageInsets = UIEdgeInsets(top: 27*(1-deviceBound), left: 0, bottom: -27*(1-deviceBound), right: 0)
            myTabBarItem4.imageInsets = UIEdgeInsets(top: 27*(1-deviceBound), left: 0, bottom: -27*(1-deviceBound), right: 0)
            myTabBarItem5.imageInsets = UIEdgeInsets(top: 27*(1-deviceBound), left: 0, bottom: -27*(1-deviceBound), right: 0)
            
            
        }
        else{
            myTabBarItem1.imageInsets = UIEdgeInsets(top: -27*(1-deviceBound), left: 0, bottom: 27*(1-deviceBound), right: 0)
            myTabBarItem2.imageInsets = UIEdgeInsets(top: -27*(1-deviceBound), left: 0, bottom: 27*(1-deviceBound), right: 0)
            myTabBarItem4.imageInsets = UIEdgeInsets(top: -27*(1-deviceBound), left: 0, bottom: 27*(1-deviceBound), right: 0)
            myTabBarItem5.imageInsets = UIEdgeInsets(top: -27*(1-deviceBound), left: 0, bottom: 27*(1-deviceBound), right: 0)
            
            
        }
        
        
//        self.tabBar.frame.size.height = 93
//        self.tabBar.frame.origin.y = view.frame.height - 93
//
       
  
        
        
        
        
    }
    
    func showSplash(){
        let containView = UIView()
        containView.backgroundColor = UIColor(red: 251 / 255.0, green: 251 / 255.0, blue: 251 / 255.0, alpha: 1.0)
        self.view.addSubview(containView)
        containView.frame = self.view.bounds
        
        var imageView = UIImageView()
        do{
            let gif = try UIImage(gifName: "Comp 4")
            imageView = UIImageView(gifImage: gif,loopCount: 1)
        
            self.view.addSubview(imageView)
            imageView.snp.makeConstraints{
                $0.width.equalTo(350)
                $0.height.equalTo(200)
                $0.center.equalToSuperview()
                
            }
            
            
        } catch{
            print(error)
        }
        
       
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
            self.runCountForSplash += 1
            

            if self.runCountForSplash == 30 {
                timer.invalidate()
                
                UIView.animate(withDuration: 1.0, animations: {
                    imageView.removeFromSuperview()
                    containView.alpha = 0
                    
                    
                })
                
                
                    
            }
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
        if UserDefaults.standard.string(forKey: "token") == "guest" {
            hideSubMenus() 
            self.presentLoginRequestPopUp()
            return
        }
        
        
        
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
        
        if UserDefaults.standard.string(forKey: "token") == "guest" {
            self.presentLoginRequestPopUp()
            return
        }
        guard let vcName = UIStoryboard(name: "WritingSentence",
                                        bundle: nil).instantiateViewController(
                                            withIdentifier: "WritingSentenceVC") as? UINavigationController
            else{
                return
        }
        hideSubMenus()
        vcName.modalPresentationStyle = .fullScreen
        
        self.present(vcName, animated: true, completion: nil)
    }
    
    func backButtonInSearchTab(){
        
    }
}

extension UnderTabBarController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        if tabBarController.selectedIndex == 1{
            if let vc = viewController as? SearchTabMainVC {
                vc.prevIdx = self.curIndex
            }
        }
//        else if tabBarController.selectedIndex == 4{
//            if let vc = viewController as? MyTabVC{
//                vc.viewDidLoad()
//            }
//        }
            
        else {
            self.curIndex = tabBarController.selectedIndex
        }
    }
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        if tabBarController.viewControllers?[4] == viewController{
            if UserDefaults.standard.string(forKey: "token") == "guest"{
                self.presentLoginRequestPopUp()
                return false
            }
        }
        return true
    }
}


extension UITabBar{
    
    open override func sizeThatFits(_ size: CGSize) -> CGSize {
        var sizethatFits = super.sizeThatFits(size)
        
        sizethatFits.height = 0
        
        return sizethatFits
        
        
        
    }
    
    
}
