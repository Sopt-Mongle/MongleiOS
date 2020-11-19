//
//  SceneDelegate.swift
//  Mongle
//
//  Created by 이주혁 on 2020/07/02.
//  Copyright © 2020 이주혁. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        
        guard let scene = (scene as? UIWindowScene) else { return }
        let defaults = UserDefaults.standard
        
        
        
        
        var storyBoard = UIStoryboard(name: "UnderTab", bundle: nil)
        var rootVc = storyBoard.instantiateViewController(identifier: "UnderTabBarController")
        
        OnboardingMainVC.shouldShowSplash = true
        
        if let token = defaults.string(forKey: "token"){
            // 둘러보기
            if token == "guest" || token == "1"{
                
                print("token : guest")
            }
            
            // 자동로그인 -> 메인뷰
            else{
                
                guard let email = defaults.string(forKey: "email") else { return }
                guard let password = defaults.string(forKey: "password") else {return}
                SignInService.shared.signin(email: email,
                                            password: password)  { networkResult in
                    switch networkResult {
                    case .success(let token) :
                        guard let token = token as? String else { return }
                        print(token)
                        defaults.set(token, forKey: "token")
                        print("autoLogin")
                        
                        
                        
                    case .requestErr(let message):
                        print("reqERR")
                        
                    case .pathErr:
                        print("pathERR")
                    case .serverErr:
                        print("serverERR")
                    case .networkFail:
                        print("network")
                        
                    }
                    
                    
                }
                
                
                
                
            }
            
            
        }
        
        // 온보딩
        else{
            print("Onboarding")
            storyBoard = UIStoryboard(name: "Onboarding", bundle: nil)
            rootVc = storyBoard.instantiateViewController(identifier: "OnboardingMainVC")
            
            
        }
        
        window = UIWindow(windowScene: scene)
        
        window?.rootViewController = rootVc
        window?.makeKeyAndVisible()
        
        
        //        guard let _ = (scene as? UIWindowScene) else { return }
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }
    
    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }
    
    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
        let defaults = UserDefaults.standard
        if let token = defaults.string(forKey: "token"){
            let date = Date()
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            let originDate = UserDefaults.standard.string(forKey: "tokenTime")!
            let ogD = formatter.date(from: originDate)
            let calendar = Calendar.current
            let diff = calendar.dateComponents([.minute], from: ogD!, to: date)
            
            if diff.minute! > 210  {
                
                
                // 둘러보기
                if token == "guest" || token == "1"{
                    
                    print("token : guest")
                }
                else{
                    guard let email = defaults.string(forKey: "email") else { return }
                    guard let password = defaults.string(forKey: "password") else {return}
                    SignInService.shared.signin(email: email,
                                                password: password)  { networkResult in
                        switch networkResult {
                        case .success(let token) :
                            guard let token = token as? String else { return }
                            print(token)
                            defaults.set(token, forKey: "token")
                            print("autoLogin")
                            
                            
                            
                        case .requestErr(let message):
                            print("reqERR")
                            
                        case .pathErr:
                            print("pathERR")
                        case .serverErr:
                            print("serverERR")
                        case .networkFail:
                            print("network")
                            
                        }
                        
                        
                    }
                    
                    
                }
                
                
            }
            
        }
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }
    
    
}

