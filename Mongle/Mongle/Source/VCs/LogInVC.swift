//
//  LogInVC.swift
//  Mongle
//
//  Created by Yunjae Kim on 2020/07/13.
//  Copyright © 2020 이주혁. All rights reserved.
//

import UIKit
import Lottie
import Gifu


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
    @IBOutlet var totalView: UIView!
    
    //MARK:- User Define Variables
    
    let animView = AnimationView(name: "43-emoji-wink")
    
    let splash = GIFImageView()
    
    
   
    let deviceBound = UIScreen.main.bounds.height/812.0

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
        $0.titleLabel?.font = $0.titleLabel?.font.withSize(13)
    }
    let alertButton2 = UIButton().then {
        $0.setTitle("회원가입", for: .normal)
        $0.setTitleColor(.softGreen, for: .normal)
        $0.backgroundColor = .white
        $0.makeRounded(cornerRadius: 19)
        $0.setBorder(borderColor: .softGreen, borderWidth: 1.0)
        $0.addTarget(self, action: #selector(signUpButtonInPopUp), for: .touchUpInside)
        $0.titleLabel?.font = $0.titleLabel?.font.withSize(13)
        
    }
    let blurView = UIImageView().then {
        $0.image = UIImage(named: "loginPopupBg")
        
    }
    
    let copyButton = UIButton().then{
        $0.setTitle("메일 복사", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.backgroundColor = .softGreen
        $0.makeRounded(cornerRadius: 19)
        $0.setBorder(borderColor: .softGreen, borderWidth: 1.0)
        $0.addTarget(self, action: #selector(mailCopyButton), for: .touchUpInside)
        $0.titleLabel?.font = $0.titleLabel?.font.withSize(13)
        
    }
    
    let mailNoButton = UIButton().then{
        $0.setTitle("아니요", for: .normal)
        $0.setTitleColor(.softGreen, for: .normal)
        $0.backgroundColor = .white
        $0.makeRounded(cornerRadius: 19)
        $0.setBorder(borderColor: .softGreen, borderWidth: 1.0)
        $0.addTarget(self, action: #selector(mailNobuttonAction), for: .touchUpInside)
        $0.titleLabel?.font = $0.titleLabel?.font.withSize(13)
        
    }
    let mailAlertLabel = UILabel().then {
        $0.text = "몽글에 메일로 문의하시겠어요?"
        $0.font = $0.font.withSize(15)
        $0.textColor = .black

    }
    
    let subMailAlertLabel = UILabel().then {
        $0.text = "mongle.official@gmail.com 으로\n문의 주시면 계정을 찾아드릴게요! "
        $0.font = $0.font.withSize(13)
        $0.textColor = .brownGreyThree
        $0.numberOfLines = 0
        $0.textAlignment = .center
        
    }
    
    
    
    
    
    var runCount = 0
    var runCountForSplash = 0
    var shouldBeDismissed = false
    
    //MARK:- LifeCycle Methods


    override func viewDidLoad() {
         super.viewDidLoad()
      
        

        
        hideAllItems()
        self.view.addSubview(splash)
       
        
        if(OnboardingMainVC.shouldShowSplash){
            showSplash()
        }
        OnboardingMainVC.shouldShowSplash = false
        
//        splashPlay()
        
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
            self.runCount += 1
            

            if self.runCount == 3 {
                timer.invalidate()
                self.animate1()
                    
            }
        }
        
        
       
        
       
        
       
        
        
        
        
        
       
        // Do any additional setup after loading the view.
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        registerForKeyboardNotifications()
        guard let token = UserDefaults.standard.string(forKey: "token") else{
            
            return
        }
        
        if token == "1" || token == "guest" {
            shouldBeDismissed = true
        }
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        unregisterForKeyboardNotifications()
        
        
        
    }
    

 

    //MARK:- User Define Functions
    @objc func splashPlay(){

        self.splash.animate(withGIFNamed: "Comp 3")
        
    }
    @objc func signUpButtonInPopUp(){
        guard let vcName = UIStoryboard(name: "SignUpAgree",
                                        bundle: nil).instantiateViewController(
                                            withIdentifier: "SignUpAgreeVC") as? UINavigationController
            else{
                return
        }
        
        vcName.modalPresentationStyle = .fullScreen
        
        self.present(vcName, animated: true, completion: nil)
        
        
    }
    @objc func mailCopyButton(){
        
        UIPasteboard.general.string = "mongle.official@gmail.com"
        blurView.removeFromSuperview()
        alertView.removeFromSuperview()
        
        
        
    }
    
    @objc func mailNobuttonAction(){
        blurView.removeFromSuperview()
        alertView.removeFromSuperview()
        
    }
    
    
    func animate1(){
        self.monglesImageView.transform = CGAffineTransform(translationX: 0, y: -50)
        UIView.animate(withDuration: 1.0, animations: {
            
            self.unHideAllItems()
            self.monglesImageView.transform = .identity
            self.setItems()
            self.splash.stopAnimatingGIF()
            self.splash.removeFromSuperview()
            
        })
        
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
    func animate2(){
        UIView.animate(withDuration: 1.0, animations: {
            self.unHideAllItems()
            
            self.setItems()
            self.splash.stopAnimatingGIF()
            self.splash.removeFromSuperview()
            
        })
        
        
        UIView.animate(withDuration: 8.0, animations: {
            self.monglesImageView.transform = CGAffineTransform(translationX: -500, y: 0)
            self.monglesImageView.transform = CGAffineTransform(rotationAngle: 360)
            self.monglesImageView.transform = CGAffineTransform(scaleX: 100000, y: 100000)
            
        
            
            
            
            
        })
        
        UIView.animate(withDuration: 1.0, animations: {
            self.monglesImageView.transform = .identity
            
        })
        
        
    }
    
    func animate3() {
    
        UIView.animate(withDuration: 1.0, animations: {
            self.unHideAllItems()
            self.setItems()
     
            self.splash.stopAnimatingGIF()
            self.splash.removeFromSuperview()
            
        }, completion: {finish in
            
           
            
            
            UIView.animate(withDuration: 2.0, delay: 0.0, options: .repeat , animations: {
        
                self.monglesImageView.transform = CGAffineTransform(translationX: -5000, y: -5000)
                let pos = CGRect(x: Int.random(in : -500...500), y: Int.random(in : -500...500), width: Int.random(in : -500...500), height: Int.random(in : -500...500))
                
                self.monglesImageView.frame = pos
            
            })
            
            
            
        })
        
        
    }
    
    
    func setItems(){
       
        quoteImageView.image = UIImage(named: "loginImgMarks")
        textImageView.image = UIImage(named: "yoongjaeJoin")
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
        
        idTextField.placeholder = "이메일을 주소를 입력해주세요"
        idTextField.makeRounded(cornerRadius: 10)
        idTextField.addLeftPadding(left: 7.5)
        idTextField.setBorder(borderColor: .veryLightPinkFive, borderWidth: 1.0)
        idTextField.keyboardType = .emailAddress
        
        
        passwordTextField.placeholder = "비밀번호를 입력해주세요"
        passwordTextField.makeRounded(cornerRadius: 10)
        passwordTextField.addLeftPadding(left: 7.5)
        passwordTextField.setBorder(borderColor: .veryLightPinkFive, borderWidth: 1.0)
        
               
    
    }
    
    func hideAllItems(){
        [idTextField, passwordTextField,loginButton , signUpButton, findIDButton,findPasswordButton,quoteImageView,textImageView, monglesImageView,backGroundView].forEach { item in
            item.alpha = 0
            
        }
        
    }
    
    func unHideAllItems(){
        [idTextField, passwordTextField,loginButton , signUpButton, findIDButton,findPasswordButton,quoteImageView,textImageView, monglesImageView,backGroundView].forEach { item in
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
        
        alertLabel1.font = alertLabel1.font.withSize(15)
        alertLabel2.font = alertLabel2.font.withSize(13)
        alertButton1.makeRounded(cornerRadius: 19)
        alertButton2.makeRounded(cornerRadius: 19)
        
        blurView.snp.makeConstraints{
            $0.top.bottom.leading.trailing.equalToSuperview()
            
        }
        alertView.snp.makeConstraints {
//            $0.top.equalToSuperview().offset(290*deviceBound)
//            $0.leading.equalToSuperview().offset(36/deviceBound)
//            $0.trailing.equalToSuperview().offset(-35/deviceBound)
            $0.center.equalToSuperview()
            $0.width.equalTo(304)
//            $0.bottom.equalToSuperview().offset(-289*deviceBound)
            $0.height.equalTo(233)
            
        }
        alertImageView.snp.makeConstraints {
            $0.top.bottom.leading.trailing.equalToSuperview()
            
        }
        alertLabel1.snp.makeConstraints {
            $0.top.equalToSuperview().offset(84)
            $0.centerX.equalToSuperview()
//            $0.leading.equalToSuperview().offset(56*deviceBound)
            
        }
        alertLabel2.snp.makeConstraints {
            $0.top.equalToSuperview().offset(112)
//            $0.leading.equalToSuperview().offset(88*deviceBound)
            $0.centerX.equalToSuperview()
        }
        
        alertButton1.snp.makeConstraints{
            $0.top.equalToSuperview().offset(171)
            $0.leading.equalToSuperview().offset(20)
            $0.width.equalTo(127)
            $0.height.equalTo(37)
        }
        alertButton2.snp.makeConstraints{
            $0.top.equalToSuperview().offset(171)
            $0.trailing.equalToSuperview().offset(-16)
            $0.width.equalTo(127)
            $0.height.equalTo(37)
        }
        
        
    }
    
    @IBAction func findIdButtonAction(_ sender: Any) {
        
        
    }
    
    func signup(){
        
        
        
        
    }
    
    
    
    @IBAction func logInButtonAction(_ sender: Any) {
        
        self.view.endEditing(true)
        
        guard let email = idTextField.text else {return}
        guard let password = passwordTextField.text else {return}
        
        SignInService.shared.signin(email: email,
                                    password: password)  { networkResult in
                                        switch networkResult {
                                        case .success(let token) :
                                            guard let token = token as? String else { return }
                                            print(token)
                                            UserDefaults.standard.set(token, forKey: "token")
                                            UserDefaults.standard.set(email, forKey: "email")
                                            UserDefaults.standard.set(password, forKey: "password")
                                            guard let vcName = UIStoryboard(name: "UnderTab",
                                                                            bundle: nil).instantiateViewController(
                                                                                withIdentifier: "UnderTabBarController") as? UINavigationController
                                                else{
                                                    return
                                            }
                                            
                                            
                                            vcName.modalPresentationStyle = .fullScreen
                                            if self.shouldBeDismissed {
                                                
                                                self.dismiss(animated: true, completion: nil)
                                            }
                                            else{
                                                self.present(vcName, animated: true, completion: nil)
                                            }
                                            
                                            
                                        case .requestErr(let message):
                                            self.showAlert()
                                        case .pathErr: self.showAlert()
                                        case .serverErr: self.showAlert()
                                        case .networkFail: self.showAlert()
                                            
                                        }
                                        
                                        
        }
        
        
        
        
        
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){

          self.view.endEditing(true)

    }
    
    @IBAction func signUpButton(_ sender: Any) {
        guard let vcName = UIStoryboard(name: "SignUpAgree",
                                        bundle: nil).instantiateViewController(
                                            withIdentifier: "SignUpAgreeVC") as? UINavigationController
            else{
                return
        }
        
        vcName.modalPresentationStyle = .fullScreen
        
        self.present(vcName, animated: true, completion: nil)
        
        
        
        
        
        
    }
    
    
    @IBAction func findIDButtonAction(_ sender: Any) {
        showMailPopUp()
        
    }
    
    @IBAction func findPWButtonAction(_ sender: Any) {
        showMailPopUp()
        
    }
    
    func showMailPopUp(){
        
        self.view.addSubview(blurView)
        self.view.addSubview(alertView)
        
        
        alertView.addSubview(alertImageView)
        alertView.addSubview(mailAlertLabel)
        alertView.addSubview(subMailAlertLabel)
        alertView.addSubview(copyButton)
        alertView.addSubview(mailNoButton)
        
        blurView.snp.makeConstraints{
            $0.leading.trailing.top.bottom.equalToSuperview()
        }
        
        alertView.snp.makeConstraints{
            $0.width.equalTo(304)
            $0.height.equalTo(233)
            $0.center.equalToSuperview()
        }
        alertImageView.snp.makeConstraints{
            $0.leading.trailing.top.bottom.equalToSuperview()
        }
        
        mailAlertLabel.snp.makeConstraints{
            $0.top.equalToSuperview().offset(84)
            $0.centerX.equalToSuperview()
        }
        
        subMailAlertLabel.snp.makeConstraints{
            $0.top.equalToSuperview().offset(112)
            $0.centerX.equalToSuperview()
        }
        
        copyButton.snp.makeConstraints{
            $0.width.equalTo(127)
            $0.height.equalTo(37)
            $0.leading.equalToSuperview().offset(20)
            $0.bottom.equalToSuperview().offset(-25)
        }
        
        mailNoButton.snp.makeConstraints{
            $0.width.equalTo(127)
            $0.height.equalTo(37)
            $0.trailing.equalToSuperview().offset(-16)
            $0.bottom.equalToSuperview().offset(-25)
        }
        
        
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
    }
    
}



