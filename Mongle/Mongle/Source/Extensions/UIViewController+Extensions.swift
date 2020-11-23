//
//  UIViewController+Extensions.swift
//  Mongle
//
//  Created by 이주혁 on 2020/07/02.
//  Copyright © 2020 이주혁. All rights reserved.
//

import UIKit

extension UIViewController {
    
    
    
    // UIAlertController without handler
    func simpleAlert(title: String, message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인",style: .default)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
    
    // UIAlertController with Handler
    func simpleAlertwithHandler(title: String, message: String, okHandler : ((UIAlertAction) -> Void)?, cancleHandler : ((UIAlertAction) -> Void)?){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인",style: .default, handler: okHandler)
        let cancelAction = UIAlertAction(title: "취소",style: .cancel, handler: cancleHandler)
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
    
    // Set Custom Back Button
    func setBackBtn(color : UIColor){
        
        // 백버튼 이미지 파일 이름에 맞게 변경해주세요.
        let backBTN = UIBarButtonItem(image: UIImage(named: "backBtn"),
                                      style: .plain,
                                      target: self,
                                      action: #selector(self.pop))
        navigationItem.leftBarButtonItem = backBTN
        navigationItem.leftBarButtonItem?.tintColor = color
        navigationController?.interactivePopGestureRecognizer?.delegate = self as? UIGestureRecognizerDelegate
    }
    
    // pop func
    @objc func pop(){
        self.navigationController?.popViewController(animated: true)
    }
    
    // Set NavigationBar Background Clear without underline
    func setNavigationBarClear() {
        let bar: UINavigationBar! = self.navigationController?.navigationBar
        
        bar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        bar.shadowImage = UIImage()
        bar.backgroundColor = UIColor.clear
    }
    
    // Set NavigationBar Background Clear with underline
    func setNavigationBarShadow() {
        let bar: UINavigationBar! = self.navigationController?.navigationBar
        bar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        bar.backgroundColor = UIColor.white
    }
    
    func gsno(_ value: String?) -> String{
        guard let value_ = value else {
            return ""
        }
        return value_
    }//func gsno
    
    func gino(_ value: Int?) -> Int{
        guard let value_ = value else {
            return 0
        }
        return value_
    }//func gino
    
    func gbno(_ value: Bool?) -> Bool{
        guard let value_ = value else {
            return false
        }
        return value_
    }//func gbno
    
    func gfno(_ value: Float?) -> Float{
        guard let value_ = value else{
            return 0
        }
        return value_
    }//func gfno
    
    func presentLoginRequestPopUp() {
        let popUpView = LoginRequestPopupView(frame: .zero)
        let blurView = UIView(frame: .zero).then {
            $0.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        }
        self.view.addSubview(blurView)
        self.view.addSubview(popUpView)
        
        blurView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
        
        popUpView.snp.makeConstraints {
            $0.width.equalTo(304)
            $0.height.equalTo(233)
            $0.centerX.centerY.equalToSuperview()
        }
        
        popUpView.signInButtonClicked = { [weak self] in
            let loginStoryboard = UIStoryboard(name: "LogIn", bundle: nil)
            guard let loginVC = loginStoryboard.instantiateViewController(identifier: "LogInVC") as? LogInVC else {
                return
            }
            loginVC.modalPresentationStyle = .fullScreen
            self?.present(loginVC, animated: true, completion: {
                blurView.removeFromSuperview()
                popUpView.removeFromSuperview()
            })
        }
        
        popUpView.cancelButtonCliecked = { [weak self] in
            blurView.removeFromSuperview()
            popUpView.removeFromSuperview()
        }
        
    }
    
    
    func showToast(text: String){
        let toast = ToastView(frame: CGRect(x: 0, y: 0, width: 343, height: 84))
        toast.setLabel(text: text)
        toast.alpha = 0
        self.view.addSubview(toast)
        
        toast.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
            $0.bottom.equalToSuperview().offset(-115)
        }
        
        
        UIView.animate(withDuration: 0.3, animations: {
            toast.alpha = 1
            
        },completion: { finish in
            UIView.animate(withDuration: 0.3, delay: 0.7, animations: {
                toast.alpha = 0

            }, completion: { finish in
                if finish {
                    toast.removeFromSuperview()
                }
            })
        })
    }
    
    func showToast(text: String, completion: @escaping ()->()) {
        let toast = ToastView(frame: CGRect(x: 0, y: 0, width: 343, height: 84))
        toast.setLabel(text: text)
        toast.alpha = 0
        self.view.addSubview(toast)
        
        toast.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
            $0.bottom.equalToSuperview().offset(-115)
        }
        
        
        UIView.animate(withDuration: 0.3, animations: {
            toast.alpha = 1
            
        },completion: { finish in
            UIView.animate(withDuration: 0.3, delay: 0.7, animations: {
                toast.alpha = 0

            }, completion: { finish in
                if finish {
                    toast.removeFromSuperview()
                    completion()
                }
            })
        })
    }
}
