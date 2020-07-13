//
//  LogInVC.swift
//  Mongle
//
//  Created by Yunjae Kim on 2020/07/13.
//  Copyright © 2020 이주혁. All rights reserved.
//

import UIKit
import Lottie

class LogInVC: UIViewController {
    
    //MARK:- IBOutlets
    @IBOutlet weak var quoteImageView: UIImageView!
    @IBOutlet weak var textImageView: UIImageView!
    @IBOutlet weak var monglesImageView: UIImageView!
    
    @IBOutlet weak var idTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var findIDButton: UIButton!
    @IBOutlet weak var findPasswordButton: UIButton!
    

    @IBOutlet weak var backGroundView: UIView!
    @IBOutlet weak var backGroundImageView: UIImageView!
    @IBOutlet weak var seperateImageView1: UIImageView!
    
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var seperateImageView2: UIImageView!
    
    //MARK:- User Define Variables
    
    let animView = AnimationView(name: "43-emoji-wink")
    
    
    
    //MARK:- LifeCycle Methods


    override func viewDidLoad() {
        self.view.addSubview(animView)
        animView.frame = animView.superview!.bounds
        animView.contentMode = .scaleAspectFit
        hideAllItems()
        
        animView.play { (finish) in
            super.viewDidLoad()
            self.animView.removeFromSuperview()
            self.unHideAllItems()
            self.setItems()
            
        }
        animView.loopMode = .playOnce
        
        
        
        
       
        // Do any additional setup after loading the view.
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        registerForKeyboardNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        unregisterForKeyboardNotifications()
        
        
        
    }
    

 

    //MARK:- User Define Functions
    
    func setItems(){
        quoteImageView.image = UIImage(named: "loginImgMarks")
        textImageView.image = UIImage(named: "invalidName")
        monglesImageView.image = UIImage(named: "loginImgMongle")
        backGroundImageView.image = UIImage(named: "loginBg")
        seperateImageView1.image = UIImage(named: "loginDivMenu1")
        seperateImageView2.image = UIImage(named: "loginDivMenu1")
        
        loginButton.backgroundColor = .softGreen
        loginButton.setTitleColor(.white, for: .normal)
        loginButton.setTitle("로그인", for: .normal)
        loginButton.makeRounded(cornerRadius: 23)
        
        signUpButton.backgroundColor = .clear
        signUpButton.setTitle("회원가입", for: .normal)
        signUpButton.setTitleColor(.veryLightPink, for: .normal)
        
        findIDButton.backgroundColor = .clear
        findIDButton.setTitle("아이디 찾기", for: .normal)
        findIDButton.setTitleColor(.veryLightPink, for: .normal)
        
        findPasswordButton.backgroundColor = .clear
        findPasswordButton.setTitle("비밀번호 찾기", for: .normal)
        findPasswordButton.setTitleColor(.veryLightPink, for: .normal)
        
        idTextField.placeholder = "아이디를 입력해주세요"
        idTextField.makeRounded(cornerRadius: 10)
        idTextField.addLeftPadding(left: 7.5)
        idTextField.setBorder(borderColor: .veryLightPinkFive, borderWidth: 1.0)
        
        passwordTextField.placeholder = "비밀번호를 입력해주세요"
        passwordTextField.makeRounded(cornerRadius: 10)
        passwordTextField.addLeftPadding(left: 7.5)
        passwordTextField.setBorder(borderColor: .veryLightPinkFive, borderWidth: 1.0)
       
               
    
    }
    
    func hideAllItems(){
        [idTextField, passwordTextField,loginButton ,signUpButton, findIDButton,findPasswordButton].forEach { item in
            item.alpha = 0
            
        }
        
    }
    
    func unHideAllItems(){
        [idTextField, passwordTextField,loginButton , signUpButton, findIDButton,findPasswordButton].forEach { item in
            item.alpha = 1
            
        }
    }
    
    func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow(_:)), name:
            UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name:
            UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func unregisterForKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name:
            UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name:
            UIResponder.keyboardWillHideNotification, object: nil)
       }
    
    @objc func keyboardWillShow(_ notification: NSNotification) {
           

        quoteImageView.alpha = 0
        textImageView.alpha = 0
        
           if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey]
               as? NSValue)?.cgRectValue {
               UIView.animate(withDuration: 0.3, animations: {
                self.bottomConstraint.constant =  keyboardSize.height-100
                
                
               })
              
             self.view.layoutIfNeeded()
           
           
       }
       }
       
       @objc func keyboardWillHide(_ notification: NSNotification) {
        quoteImageView.alpha = 1
        textImageView.alpha = 1
           guard let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey]
               as? Double else {return}
           guard let curve = notification.userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey]
               as? UInt else {return}
           
           UIView.animate(withDuration: duration, delay: 0.0, options: .init(rawValue: curve),
                          animations: {
                            self.bottomConstraint.constant = 0
                            self.view.layoutIfNeeded()
           })
           
           
       }
    
    
    @IBAction func logInButtonAction(_ sender: Any) {
        
        guard let vcName = UIStoryboard(name: "UnderTab",
                                        bundle: nil).instantiateViewController(
                                            withIdentifier: "UnderTabBarController") as? UINavigationController
            else{
                return
        }
     
        vcName.modalPresentationStyle = .fullScreen
        
        self.present(vcName, animated: true, completion: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){

          self.view.endEditing(true)

    }
    
    
    
    
    
}
