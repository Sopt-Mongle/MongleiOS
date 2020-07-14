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
    
    let alertView = UIView().then {
        $0.backgroundColor = .clear
        
        
    }
    let alertImageView = UIImageView().then{
        $0.image = UIImage(named: "loginPopupBox")
        
    }
    let alertLabel1 = UILabel().then {
        $0.text = "몽글에 등록되지 않은 회원이에요!"
        $0.font = $0.font.withSize(15)
        $0.textColor = .black

    }
    
    let alertLabel2 = UILabel().then {
        $0.text = "이메일 주소와 비밀번호를\n다시 한 번 확인해주세요!"
        $0.font = $0.font.withSize(15)
        $0.textColor = .brownGreyThree
        $0.numberOfLines = 0
    }
    
    let alertButton1 = UIButton().then {
        $0.setTitle("네", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.backgroundColor = .softGreen
        $0.makeRounded(cornerRadius: 19)
        $0.addTarget(self, action: #selector(yesButtonAction), for: .touchUpInside)
        
    }
    let alertButton2 = UIButton().then {
        $0.setTitle("회원가입", for: .normal)
        $0.setTitleColor(.softGreen, for: .normal)
        $0.backgroundColor = .white
        $0.makeRounded(cornerRadius: 19)
        $0.setBorder(borderColor: .softGreen, borderWidth: 1.0)
        
        
    }
    let blurView = UIImageView().then {
        $0.image = UIImage(named: "loginPopupBg")
        
    }
    
    
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
        let allTextView = self.view.getTextFieldsInView(view: self.view)
        let selected = self.view.getSelectedTextField()
        allTextView.forEach{
            $0.setBorder(borderColor: .veryLightPinkFive, borderWidth: 1.0)
        }
        selected?.setBorder(borderColor: .softGreen, borderWidth: 1.0)
        
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
        
        
        let allTextView = self.view.getTextFieldsInView(view: self.view)
        
        allTextView.forEach{
            $0.setBorder(borderColor: .veryLightPinkFive, borderWidth: 1.0)
        }
        
        
        
    }
    
    @objc func yesButtonAction(){
        idTextField.becomeFirstResponder()
        blurView.removeFromSuperview()
        alertView.removeFromSuperview()
  }
    
    func showAlert(){
        self.view.addSubview(blurView)
        self.view.addSubview(alertView)
        
        alertView.addSubview(alertImageView)
        alertView.addSubview(alertLabel1)
        alertView.addSubview(alertLabel2)
        alertView.addSubview(alertButton1)
        alertView.addSubview(alertButton2)
        
        blurView.snp.makeConstraints{
            $0.top.bottom.leading.trailing.equalToSuperview()
       
        }
        alertView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(290)
            $0.leading.equalToSuperview().offset(36)
            $0.trailing.equalToSuperview().offset(-35)
            $0.bottom.equalToSuperview().offset(-289)
            
            
        }
        alertImageView.snp.makeConstraints {
            $0.top.bottom.leading.trailing.equalToSuperview()
            
        }
        alertLabel1.snp.makeConstraints {
            $0.top.equalToSuperview().offset(84)
            $0.leading.equalToSuperview().offset(56)
            
        }
        alertLabel2.snp.makeConstraints {
            $0.top.equalToSuperview().offset(112)
            $0.leading.equalToSuperview().offset(88)
        }
        
        alertButton1.snp.makeConstraints{
            $0.top.equalToSuperview().offset(171)
            $0.leading.equalToSuperview().offset(20)
            $0.width.equalTo(127)
            $0.height.equalTo(37)
        }
        alertButton2.snp.makeConstraints{
            $0.top.equalToSuperview().offset(171)
            $0.leading.equalToSuperview().offset(161)
            $0.width.equalTo(127)
            $0.height.equalTo(37)
        }
        
        
    }
    
    
    

    
    
    @IBAction func logInButtonAction(_ sender: Any) {
        
        if idTextField.text == "임정은" {
            self.view.endEditing(true)
            showAlert()
            
        }
        else{
            
            guard let vcName = UIStoryboard(name: "UnderTab",
                                            bundle: nil).instantiateViewController(
                                                withIdentifier: "UnderTabBarController") as? UINavigationController
                else{
                    return
            }
            
            vcName.modalPresentationStyle = .fullScreen
            
            self.present(vcName, animated: true, completion: nil)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){

          self.view.endEditing(true)

    }
    
    @IBAction func signUpButton(_ sender: Any) {
        guard let vcName = UIStoryboard(name: "SignUp",
                                        bundle: nil).instantiateViewController(
                                            withIdentifier: "SignUpVC") as? SignUpVC
            else{
                return
        }
        
        vcName.modalPresentationStyle = .fullScreen
        
        self.present(vcName, animated: true, completion: nil)
        
        
        
    }
    
    
    
    
}

extension UIView {
    func getSelectedTextField() -> UITextField? {
        
        let totalTextFields = getTextFieldsInView(view: self)
        
        for textField in totalTextFields{
            if textField.isFirstResponder{
                return textField
            }
        }
        
        return nil
        
    }
    
    func getTextFieldsInView(view: UIView) -> [UITextField] {
        
        var totalTextFields = [UITextField]()
        
        for subview in view.subviews as [UIView] {
            if let textField = subview as? UITextField {
                totalTextFields += [textField]
            } else {
                totalTextFields += getTextFieldsInView(view: subview)
            }
        }
        
        return totalTextFields
    }}