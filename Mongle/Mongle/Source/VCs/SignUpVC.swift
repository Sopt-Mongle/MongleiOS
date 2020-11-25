//
//  SignUpVC.swift
//  Mongle
//
//  Created by Yunjae Kim on 2020/07/14.
//  Copyright © 2020 이주혁. All rights reserved.
//

import UIKit
import SnapKit
import Then

class SignUpVC: UIViewController, UITextFieldDelegate {
    
    //MARK:- IBOutlets
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passWordTextField: UITextField!
    @IBOutlet weak var passWordTextField2: UITextField!
    @IBOutlet weak var nickNameTextField: UITextField!
    @IBOutlet weak var nickNameWarningImageView: UIImageView!
    @IBOutlet weak var nickNameWarningLabel: UILabel!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var emailStar: UIImageView!
    @IBOutlet weak var passwordStar: UIImageView!
    
    @IBOutlet weak var nickNameStar: UIImageView!
    
    @IBOutlet weak var emailNoticeLabel: UILabel!
    
    @IBOutlet weak var passwordNoticeLabel: UILabel!
    @IBOutlet weak var nickNameNoticeLabel: UILabel!
    @IBOutlet weak var mustLabel: UILabel!
    
    @IBOutlet weak var mustStar: UIImageView!
    
    
    @IBOutlet weak var scrollViewBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var signUpScrollView: UIScrollView!
    @IBOutlet weak var buttonBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var upperBlurImageView: UIImageView!
    
    
    
    //MARK:- Constraints For Warning
    
    @IBOutlet weak var emailToPassWordConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var passWordToNIckNameConstraint: NSLayoutConstraint!
    
    
    
    //MARK:- User Define Variables
    
    let underBlur = UIImageView().then {
        $0.image = UIImage(named: "joinEmailBoxBlur")
        
    }
    let upperBlur = UIImageView().then {
        $0.image = UIImage(named: "joinStep2PasswordBoxBlur")
        $0.contentMode = .scaleToFill
        
        
    }
    let emailWarningImageView = UIImageView().then {
        $0.image = UIImage(named: "joinEmailErrorIcWarning")
        
    }
    
    let emailWarningLabel = UILabel().then {
        $0.text = "올바른 이메일 형식이 아니에요!"
        $0.font = $0.font.withSize(13)
        $0.textColor = .reddish
    }
    
    let passwordWarningImageView = UIImageView().then {
        $0.image = UIImage(named: "joinEmailErrorIcWarning")
        
    }
    
    let passwordWarningLabel = UILabel().then {
        $0.text = "비밀번호를 입력해주세요!"
        $0.font = $0.font.withSize(13)
        $0.textColor = .reddish
        
    }
    
    let nickNameQuantityLabel = UILabel().then {
        $0.text = ""
        $0.font = $0.font.withSize(13)
        $0.textColor = .veryLightPink
        
    }
    let innerCircle = UIView().then{
        $0.backgroundColor = .softGreen
        
        
    }
    let outerCircle = UIView().then{
        $0.backgroundColor = .softGreen
        $0.alpha = 0.34
        
    }
    
    let innerCircle2 = UIView().then{
        $0.backgroundColor = .brownGreyThree
        
        
    }
    let outerCircle2 = UIView().then{
        $0.backgroundColor = .brownGreyThree
        $0.alpha = 0.34
        
        
    }
    
    let smallCircle = UIView().then{
        $0.backgroundColor = .veryLightPinkSeven
        
        
    }
    
    let smallCircle2 = UIView().then{
        $0.backgroundColor = .veryLightPinkSeven
        
        
    }
    
    let smallCircle3 = UIView().then{
        $0.backgroundColor = .veryLightPinkSeven
        
        
    }
    
    
    var emailIsWarning : Int = 0
    var passwordIsWarning : Int = 0
    let deviceBound = (UIScreen.main.bounds.height-317.0)/495.0
    
    
    @IBOutlet weak var upperBlurHeight: NSLayoutConstraint!
    
    
    //MARK:- LifeCycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("devicebound : \(deviceBound)")
        setItems()
        setSmallBalls()
        setProgressBar()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        registerForKeyboardNotifications()
        secondLevelAnimation()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        unregisterForKeyboardNotifications()
        
        
        
    }
    
    static var emailCodeDelegate : EmailCodeDelegate?
    
    
    //MARK:- User Define Functions
    func setItems(){
        backButton.setImage(UIImage(named: "joinStep2BtnBack")?.withRenderingMode(.alwaysOriginal), for: .normal)
        upperBlurHeight.constant = 91*deviceBound
        
        emailTextField.placeholder = "이메일 주소"
        passWordTextField.placeholder = "비밀번호"
        passWordTextField2.placeholder = "비밀번호 확인"
        nickNameTextField.placeholder = "닉네임"
        
        emailTextField.makeRounded(cornerRadius: 10)
        passWordTextField.makeRounded(cornerRadius: 10)
        passWordTextField2.makeRounded(cornerRadius: 10)
        nickNameTextField.makeRounded(cornerRadius: 10)
        
        emailTextField.addLeftPadding(left: 7.5)
        passWordTextField.addLeftPadding(left: 7.5)
        passWordTextField2.addLeftPadding(left: 7.5)
        nickNameTextField.addLeftPadding(left: 7.5)
        
        
        emailTextField.setBorder(borderColor: .veryLightPinkFive, borderWidth: 1.0)
        passWordTextField.setBorder(borderColor: .veryLightPinkFive, borderWidth: 1.0)
        passWordTextField2.setBorder(borderColor: .veryLightPinkFive, borderWidth: 1.0)
        nickNameTextField.setBorder(borderColor: .veryLightPinkFive, borderWidth: 1.0)
        
        nickNameWarningLabel.textColor = .reddish
        nickNameWarningImageView.image = UIImage(named: "joinEmailErrorIcWarning")
        registerButton.setTitle("다음", for: .normal)
        registerButton.setTitleColor(.white, for: .normal)
        registerButton.backgroundColor = .softGreen
        registerButton.makeRounded(cornerRadius: 30)
        passWordTextField.addTarget(self, action: #selector(validationCheck), for: .editingChanged)
        passWordTextField2.addTarget(self, action: #selector(comparePasswords), for: .editingChanged)
        passWordTextField.addTarget(self, action: #selector(comparePasswords), for: .editingChanged)
        nickNameWarningLabel.alpha = 0
        nickNameWarningImageView.alpha = 0
        nickNameTextField.addTarget(self, action: #selector(updateNicknameQuantity), for: .editingChanged)
        
        signUpScrollView.addSubview(nickNameQuantityLabel)
        nickNameQuantityLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(527 + emailIsWarning + passwordIsWarning)
            $0.trailing.equalToSuperview().offset(-28)
            
            
        }
        
        self.view.getTextFieldsInView(view: self.view).forEach{
            $0.delegate = self
            
        }
        
        emailTextField.keyboardType = .emailAddress
        
        upperBlurImageView.image = UIImage(named: "joinStep2Nickname4BoxBlur")
        upperBlurImageView.contentMode = .scaleToFill
        upperBlurImageView.alpha = 0
        emailStar.image = UIImage(named: "starInMyEyes")
        emailNoticeLabel.textColor = .brownGreyThree
        passwordStar.image = UIImage(named: "starInMyEyes")
        nickNameStar.image = UIImage(named : "starInMyEyes")
        mustStar.image = UIImage(named : "starInMyEyes")
        
        passwordNoticeLabel.textColor = .brownGreyThree
        nickNameNoticeLabel.textColor = .brownGreyThree
        mustLabel.textColor = .brownGreyThree
        
        passWordTextField.disableAutoFill()
        passWordTextField2.disableAutoFill()


        
    }
    
    
    
    func partialGreenColor(){
        
        
        guard let text = self.nickNameQuantityLabel.text else {
            return
        }
        nickNameQuantityLabel.textColor = .softGreen
        let attributedString = NSMutableAttributedString(string: nickNameQuantityLabel.text!)
        attributedString.addAttribute(NSAttributedString.Key.foregroundColor,
                                      value: UIColor.veryLightPink,
                                      range: (text as NSString).range(of: "/6"))
        if nickNameQuantityLabel.text == "" {
            nickNameQuantityLabel.textColor = .veryLightPink
        }
        nickNameQuantityLabel.attributedText = attributedString
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
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        
        if textField == passWordTextField || textField == passWordTextField2 {
            //            let move = CGPoint(x: 0, y: (105+emailIsWarning)*Int(deviceBound))
            let move = CGPoint(x: 0, y: (105+emailIsWarning))
            UIView.animate(withDuration: 0.5, delay : 0.3, animations: {
                
                self.signUpScrollView.setContentOffset(move, animated: false)
            })
            hidePasswordWarning()
            hideNickNameWarning()
            
            
            
        }
        
        else if textField == nickNameTextField {
            //            let move = CGPoint(x: 0, y: (280+emailIsWarning+passwordIsWarning)*Int(deviceBound))
            let move = CGPoint(x: 0, y: (280+emailIsWarning+passwordIsWarning))
            UIView.animate(withDuration: 0.5, animations: {
                
                self.signUpScrollView.setContentOffset(move, animated: false)
            })
            
            secondPasswordEnd()
            hideNickNameWarning()
            updateNicknameQuantity()
        }
        else if textField == emailTextField{
            let move = CGPoint(x: 0, y: 0)
            UIView.animate(withDuration: 0.5, animations: {
                
                self.signUpScrollView.setContentOffset(move, animated: false)
            })
            secondPasswordEnd()
            hideEmailWarning()
            hideNickNameWarning()
        }
        textField.setBorder(borderColor: .softGreen, borderWidth: 1.0)
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.setBorder(borderColor: .veryLightPinkFive, borderWidth: 1.0)
        
        if textField == passWordTextField2{
            secondPasswordEnd()
        }
        else if textField == nickNameTextField {
            nickNameQuantityLabel.alpha = 0
        }
        else if textField == emailTextField{
            
            if emailTextField.text == ""{
                emailWarningLabel.text = "이메일 주소를 입력해주세요!"
                showEmailWarning()
                hidePasswordWarning()
                
                if passwordIsWarning == 25 {
                    hidePasswordWarning()
                    showPasswordWarning()
                }
            }
            else if emailTextField.text?.isValidEmailAddress() == false{
                emailWarningLabel.text = "올바른 이메일 형식이 아니에요!"
                showEmailWarning()
                
                //            if passwordIsWarning == 25 {
                hidePasswordWarning()
                //                showPasswordWarning()
                
                
                //            }
                
                if passwordIsWarning == 25 {
                    hidePasswordWarning()
                    showPasswordWarning()
                }
                
                
            }
            else{
                let email = emailTextField.text!
                let name = "1a2a3a4a5a6a7a8a"
               
                SignUpDuplicateService.shared.checkDuplicate(email: email, name: name) { networkResult in
                    switch networkResult {
                    case .success(let data):
                        let dup = data as? String
                        print(dup!)
                        if dup == "available" {
                            self.emailWarningLabel.text = "사용 가능한 이메일이에요!"
                            self.showEmailValid()
                           
                        }
                   
                        else if dup == "email"{
                            self.emailWarningLabel.text = "이미 가입된 이메일이에요!"
                            self.showEmailWarning()
                            
                        }
                        
                    case .requestErr(let duplicate) :
                        let dup = duplicate as? String
                        print(dup!)
                        if dup == "available" {
                            self.emailWarningLabel.text = "사용 가능한 이메일이에요!"
                            self.showEmailValid()
                        }
                      
                        else if dup == "email"{
                            self.emailWarningLabel.text = "이미 가입된 이메일이에요!"
                            self.showEmailWarning()
                            
                        }
                        
                    case .pathErr: print("ptherr")
                    case .serverErr: print("serverErr")
                    case .networkFail: print("networkFails2")
                        
                        
                        
                    }
                    
                    
                    
                }
                
            }
        }
        
        
        
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        switch textField {
        case emailTextField:
            hideEmailWarning()
            emailTextField.setBorder(borderColor: .softGreen, borderWidth: 1.0)
        case passWordTextField:
            
            hidePasswordWarning()
            
            comparePasswords()
            passWordTextField.setBorder(borderColor: .softGreen, borderWidth: 1.0)
        case passWordTextField2 :
            
            passWordTextField2.setBorder(borderColor: .softGreen, borderWidth: 1.0)
        case nickNameTextField :
            hideNickNameWarning()
            nickNameTextField.setBorder(borderColor: .softGreen, borderWidth: 1.0)
            let newLength = (textField.text?.count)! + string.count - range.length
            return !(newLength > 6)
            
        default:
            return true
        }
        
        
        
        
        return true
        
    }
    
    
    @objc func validationCheck(){
        if !passWordTextField.text!.isValidPassword(){
            showPasswordWarning()
            passwordWarningLabel.text = "영문+숫자 최소 8자리 이상 입력해주세요!"
            passWordTextField2.setBorder(borderColor: .veryLightPink, borderWidth: 1.0)
        }
        else{
            
            hidePasswordWarning()
            
        }
    }
    
    @objc func keyboardWillShow(_ notification: NSNotification) {
        
        
        
        
        
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey]
                                as? NSValue)?.cgRectValue {
            scrollViewBottomConstraint.constant = keyboardSize.height + 82
            UIView.animate(withDuration: 0.3, animations: {
                self.buttonBottomConstraint.constant =  keyboardSize.height+17
                
                
            })
            
            self.view.layoutIfNeeded()
            
            self.view.addSubview(underBlur)
            //            self.view.addSubview(upperBlur)
            upperBlurImageView.alpha = 1
            
            
            self.view.bringSubviewToFront(registerButton)
            
            underBlur.snp.makeConstraints {
                $0.bottom.equalToSuperview().offset(-keyboardSize.height)
                $0.height.equalTo(123*deviceBound)
                $0.leading.trailing.equalToSuperview()

            }

            
            mustStar.alpha = 0
            mustLabel.alpha = 0
            
            
            //            upperBlur.snp.makeConstraints {
            //                $0.top.equalToSuperview().offset(109)
            //                $0.leading.trailing.equalToSuperview()
            //                $0.height.equalTo(91)
            //
            //            }
            
            
            
            
        }
        
        
    }
    
    func secondLevelAnimation() {
        progressBar.progress = 0
        //        progressBar.setProgress(0.5, animated: true)
        
        
        UIView.animate(withDuration: 0.5, delay: 0.0, animations: {
            self.progressBar.layoutIfNeeded()
            
        }, completion: { finished in
            self.progressBar.progress = 0.5
            
            
            
            
            UIView.animate(withDuration: 0.75 , delay: 0.0, options: [.curveEaseIn], animations: {
                self.progressBar.layoutIfNeeded()
            }, completion:nil)
        })
        
        
        
    }
    
    func setSmallBalls(){
        self.view.addSubview(smallCircle2)
        self.view.addSubview(smallCircle3)
        
        smallCircle.makeRounded(cornerRadius: 4.5)
        
        smallCircle2.snp.makeConstraints{
            $0.width.height.equalTo(9)
            $0.center.equalTo(progressBar)
        }
        smallCircle2.makeRounded(cornerRadius: 4.5)
        
        smallCircle3.snp.makeConstraints{
            $0.width.height.equalTo(9)
            $0.trailing.equalToSuperview().offset(-36)
            $0.centerY.equalTo(progressBar)
            
        }
        smallCircle3.makeRounded(cornerRadius: 4.5)
        
        
        
        
    }
    
    func setProgressBar(){
        
        self.view.addSubview(outerCircle)
        self.view.addSubview(innerCircle)
        self.view.addSubview(outerCircle2)
        self.view.addSubview(innerCircle2)
        
        
        self.innerCircle2.snp.makeConstraints{
            $0.width.height.equalTo(12)
            $0.centerX.equalTo(self.progressBar.snp_centerXWithinMargins)
            $0.centerY.equalTo(self.progressBar.snp_centerYWithinMargins)
            
            
        }
        innerCircle2.makeRounded(cornerRadius: 6)
        innerCircle2.alpha = 1
        
        
        self.outerCircle2.snp.makeConstraints{
            $0.width.height.equalTo(26)
            $0.centerX.equalTo(self.progressBar.snp_centerXWithinMargins)
            $0.centerY.equalTo(self.progressBar.snp_centerYWithinMargins)
            
        }
        outerCircle2.makeRounded(cornerRadius: 13)
        outerCircle2.alpha = 0.34
        
        
        progressBar.progressTintColor = .softGreen
        
        innerCircle.snp.makeConstraints{
            $0.width.height.equalTo(12)
            $0.leading.equalToSuperview().offset(35)
            $0.centerY.equalTo(progressBar.snp_centerYWithinMargins)
            
        }
        innerCircle.makeRounded(cornerRadius: 6)
        
        outerCircle.snp.makeConstraints{
            $0.width.height.equalTo(26)
            $0.leading.equalToSuperview().offset(28)
            $0.centerY.equalTo(progressBar.snp_centerYWithinMargins)
            
        }
        outerCircle.makeRounded(cornerRadius: 13)
        innerCircle.alpha = 1
        outerCircle.alpha = 0.34
        progressBar.progress = 0
        
        
    }
    
    
    
    @objc func keyboardWillHide(_ notification: NSNotification) {
        self.underBlur.removeFromSuperview()
        //        self.upperBlur.removeFromSuperview()
        upperBlurImageView.alpha = 0
        
        mustStar.alpha = 1
        mustLabel.alpha = 1
        
        guard let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey]
                as? Double else {return}
        guard let curve = notification.userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey]
                as? UInt else {return}
        
        scrollViewBottomConstraint.constant = 186
        UIView.animate(withDuration: duration, delay: 0.0, options: .init(rawValue: curve),
                       animations: {
                        self.buttonBottomConstraint.constant = 50
                        self.view.layoutIfNeeded()
                       })
        
        
        
        
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        
        self.view.endEditing(true)
        
    }
    @objc func comparePasswords(){
        
        if !passWordTextField.text!.isValidPassword(){
            showPasswordWarning()
            passwordWarningLabel.text = "영문+숫자 최소 8자리 이상 입력해주세요!"
            passWordTextField2.setBorder(borderColor: .veryLightPink, borderWidth: 1.0)
        }
        else{
            
            if passWordTextField.text == passWordTextField2.text && passWordTextField.text != "" && passWordTextField2.text != ""{
               
                self.passwordWarningLabel.text = "비밀번호가 일치해요!"
                self.passwordWarningImageView.image = UIImage(named: "joinPassword5IcPossible")
                self.passwordWarningLabel.textColor = .softGreen
                
                
                
                
            }
            else if passWordTextField2.text != ""{
                secondPasswordBegin()
            }
        }
        
    }
    @objc func updateNicknameQuantity(){
        
        nickNameQuantityLabel.alpha = 1
        nickNameQuantityLabel.text = String(nickNameTextField.text!.count) + "/6"
        partialGreenColor()
        nickNameQuantityLabel.snp.remakeConstraints {
            $0.top.equalToSuperview().offset(389 + emailIsWarning + passwordIsWarning)
            
            $0.trailing.equalToSuperview().offset(-28)
            
        }
        
        
        
    }
    
    func showEmailWarning(){
        emailToPassWordConstraint.constant = 59
        self.signUpScrollView.addSubview(emailWarningImageView)
        self.signUpScrollView.addSubview(emailWarningLabel)
        
        emailWarningLabel.textColor = .reddish
        
        emailWarningImageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(119)
            $0.leading.equalToSuperview().offset(28)
            $0.width.height.equalTo(15)
        }
        emailWarningImageView.image = UIImage(named: "joinEmailErrorIcWarning")
        emailWarningLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(119)
            $0.leading.equalToSuperview().offset(51)
            
        }
        self.emailTextField.setBorder(borderColor: .reddish, borderWidth: 1.0)
        
        emailIsWarning = 25
        
    }
    
    func showEmailValid(){
        emailToPassWordConstraint.constant = 59
        self.signUpScrollView.addSubview(emailWarningImageView)
        self.signUpScrollView.addSubview(emailWarningLabel)
        emailWarningImageView.image = UIImage(named: "joinStep2NicknameIcPossible")
        emailWarningLabel.textColor = .softGreen
        
        emailWarningImageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(119)
            $0.leading.equalToSuperview().offset(28)
            $0.width.height.equalTo(15)
        }
        
        emailWarningLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(119)
            $0.leading.equalToSuperview().offset(51)
            
        }
//        self.emailTextField.setBorder(borderColor: .reddish, borderWidth: 1.0)
        
        emailIsWarning = 25
        
        
        
    }
    
    func hideEmailWarning(){
        emailToPassWordConstraint.constant = 34
        emailWarningImageView.removeFromSuperview()
        emailWarningLabel.removeFromSuperview()
        self.emailTextField.setBorder(borderColor: .veryLightPinkFive, borderWidth: 1.0)
        emailIsWarning = 0
        
        
    }
    
    func showPasswordWarning(){
        passwordIsWarning = 25
        print(1)
        passWordToNIckNameConstraint.constant = 59
        passwordWarningLabel.textColor = .reddish
        self.passwordWarningImageView.image = UIImage(named: "joinEmailErrorIcWarning")
        self.signUpScrollView.addSubview(passwordWarningImageView)
        self.signUpScrollView.addSubview(passwordWarningLabel)
        
        passwordWarningImageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(282 + emailIsWarning)
            $0.leading.equalToSuperview().offset(28)
            $0.width.height.equalTo(15)
        }
        
        passwordWarningLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(282 + emailIsWarning)
            $0.leading.equalToSuperview().offset(51)
            
        }
        
        if(passWordTextField.text == ""){
            self.passWordTextField.setBorder(borderColor: .reddish, borderWidth: 1.0)
            self.passWordTextField2.setBorder(borderColor: .reddish, borderWidth: 1.0)
        }
        else {
            self.passWordTextField2.setBorder(borderColor: .reddish, borderWidth: 1.0)
            passwordWarningLabel.text = "비밀번호를 한 번 더 입력해주세요!"
            
        }
        
        
        
    }
    
    func hidePasswordWarning(){
        print(2)
        passwordIsWarning = 0
        passWordToNIckNameConstraint.constant = 34
        
        
        passwordWarningLabel.removeFromSuperview()
        passwordWarningImageView.removeFromSuperview()
        
        self.passWordTextField.setBorder(borderColor: .veryLightPinkFive, borderWidth: 1.0)
        self.passWordTextField2.setBorder(borderColor: .veryLightPinkFive, borderWidth: 1.0)
        
        
    }
    func secondPasswordBegin(){
        print(3)
        passWordToNIckNameConstraint.constant = 59
        
        
        self.signUpScrollView.addSubview(passwordWarningImageView)
        self.signUpScrollView.addSubview(passwordWarningLabel)
        
        
        passwordWarningImageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(282+emailIsWarning)
            $0.leading.equalToSuperview().offset(28)
            $0.width.height.equalTo(15)
        }
        
        passwordWarningLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(282+emailIsWarning)
            $0.leading.equalToSuperview().offset(51)
            
        }
        
        
        passwordWarningLabel.text = "비밀번호가 일치하지 않아요!"
        passwordWarningLabel.textColor = .reddish
        passwordWarningImageView.image = UIImage(named: "joinEmailErrorIcWarning")
        
        
        
        if passWordTextField.text!.count == passWordTextField2.text!.count {
            passWarningMoveAnimation()
            
            
        }
        
        
        
        
        
        
        
        
        
        
    }
    
    func passWarningMoveAnimation(){
        UIView.animate(withDuration: 0.1, animations: {
            self.passwordWarningImageView.transform = CGAffineTransform(translationX: -5, y: 0)
            self.passwordWarningLabel.transform = CGAffineTransform(translationX: -5, y: 0)
        }, completion: { finished in
            
            UIView.animate(withDuration: 0.1, animations: {
                
                self.passwordWarningImageView.transform = CGAffineTransform(translationX: 10, y: 0)
                self.passwordWarningLabel.transform = CGAffineTransform(translationX: 10, y: 0)
                
            },completion: {finished in
                UIView.animate(withDuration: 0.1, animations: {
                    
                    self.passwordWarningImageView.transform = .identity
                    self.passwordWarningLabel.transform = .identity
                    
                })
            })
            
            
            
        })
        
    }
    
    
    func secondPasswordEnd(){
        
        passWordToNIckNameConstraint.constant = 34
        
        
        passwordWarningLabel.removeFromSuperview()
        passwordWarningImageView.removeFromSuperview()
        
        passWordTextField.setBorder(borderColor: .veryLightPinkFive, borderWidth: 1.0)
        passWordTextField2.setBorder(borderColor: .veryLightPinkFive, borderWidth: 1.0)
        
        
        
    }
    func showNickNameWarning(){
        
        nickNameTextField.setBorder(borderColor: .reddish, borderWidth: 1.0)
        nickNameWarningLabel.alpha = 1
        nickNameWarningImageView.alpha = 1
        
        
        
    }
    
    func showNickNameDuplicate(){
        //        nickNameWarningLabel.text = "이미 사용 중인 닉네임이에요!"
        //        nickNameTextField.setBorder(borderColor: .reddish, borderWidth: 1.0)
        //        nickNameWarningLabel.alpha = 1
        //        nickNameWarningImageView.alpha = 1
        
        self.showToast(text: "이미 사용 중인 닉네임이에요!")
        
    }
    
    func hideNickNameWarning(){
        nickNameTextField.setBorder(borderColor: .veryLightPink, borderWidth: 1.0)
        nickNameWarningLabel.alpha = 0
        nickNameWarningImageView.alpha = 0
    }
    
    
    
    @IBAction func registerButtonAction(_ sender: Any) {
 
        
        self.view.endEditing(true)
        if emailTextField.text == ""{
            emailWarningLabel.text = "이메일 주소를 입력해주세요!"
            showEmailWarning()
            hidePasswordWarning()
        }
        else if emailTextField.text?.isValidEmailAddress() == false{
            emailWarningLabel.text = "올바른 이메일 형식이 아니에요!"
            showEmailWarning()
            
            //            if passwordIsWarning == 25 {
            hidePasswordWarning()
            //                showPasswordWarning()
            
            
            //            }
            
            
        }
        else if passWordTextField.text == "" || passWordTextField2.text == ""{
            passwordWarningLabel.text = "비밀번호를 입력해주세요!"
            showPasswordWarning()
            
        }
        else if !passWordTextField.text!.isValidPassword() {
            passwordWarningLabel.text = "영문+숫자 최소 8자리 이상 입력해주세요!"
            
            showPasswordWarning()
            
        }
        
        else if passWordTextField.text != passWordTextField2.text{
            passWordTextField.setBorder(borderColor: .reddish, borderWidth: 1.0)
            passWordTextField2.setBorder(borderColor: .reddish, borderWidth: 1.0)
            
            secondPasswordBegin()
        }
        else if nickNameTextField.text == ""{
            nickNameWarningLabel.text = "닉네임을 입력해주세요!"
            showNickNameWarning()
        }
        else {
            
            
            print("email,name duplicate check")
            guard let email = emailTextField.text else {return}
            
            guard let name = nickNameTextField.text else {return}
            
            SignUpDuplicateService.shared.checkDuplicate(email: email, name: name) { networkResult in
                switch networkResult {
                case .success(let data):
                    let dup = data as? String
                    print(dup!)
                    if dup == "available" {
                        self.signup()
                    }
                    else if dup == "name"{
                        
                        self.nickNameWarningLabel.text = "이미 사용중인 닉네임이에요!"
                        self.showNickNameWarning()
                        
                        
                    }
                    else if dup == "email"{
                        self.emailWarningLabel.text = "이미 가입된 이메일이에요!"
                        self.showEmailWarning()
                        
                    }
                    
                case .requestErr(let duplicate) :
                    let dup = duplicate as? String
                    print(dup!)
                    if dup == "available" {
                        self.signup()
                    }
                    else if dup == "name"{
                        
                        self.nickNameWarningLabel.text = "이미 사용중인 닉네임이에요!"
                        self.showNickNameWarning()
                        
                        
                    }
                    else if dup == "email"{
                        self.emailWarningLabel.text = "이미 가입된 이메일이에요!"
                        self.showEmailWarning()
                        
                    }
                    
                case .pathErr: print("ptherr")
                case .serverErr: print("serverErr")
                case .networkFail: print("networkFails2")
                    
                    
                    
                }
                
                
                
            }
            
            
            
            
            
        }
        
        
        
    }
    
    
    @IBAction func backButtonAction(_ sender: Any) {
        
        
        self.navigationController?.popViewController(animated: true)
        
        
    }
    
    func signup(){
        guard let email = emailTextField.text else {return}
        guard let password = passWordTextField.text else {return}
        guard let name = nickNameTextField.text else {return}
        
        
        UserDefaults.standard.set(email, forKey: "email")
        
        var able = true
        
        
        guard let vcName = UIStoryboard(name: "SignUpEmail",
                                        bundle: nil).instantiateViewController(
                                            withIdentifier: "SignUpEmailVC") as? SignUpEmailVC
        else{
            
            return
        }
        
        
        
        
        print("email sending break")
        SignUpEmailService.shared.signup(email: email) { networkResult in
            switch networkResult{
            case .success(let code) :
                print("success Code")
                var scode : String?
                scode = code as?  String
                print(scode!)
                SignUpVC.emailCodeDelegate = vcName
                SignUpVC.emailCodeDelegate?.emailCodeTransfer(s: scode!, e: email, p: password, n: name)
                print(code)
                vcName.modalPresentationStyle = .fullScreen
                self.navigationController?.pushViewController(vcName, animated: true)
                
            case .requestErr(let message):
                print("request by email")
                guard let message = message as? String else {return}
                let alertViewController = UIAlertController(
                    title: "회원가입 실패",
                    message: message,
                    preferredStyle: .alert)
                let action = UIAlertAction(title: "확인",
                                           style: .cancel,
                                           handler: nil)
                alertViewController.addAction(action)
                self.present(alertViewController, animated: true,
                             completion: nil)
            case .pathErr: self.showNickNameDuplicate()
            case .serverErr: print("serverErr")
            case .networkFail: print("networkFails2")
                
            }
            
            
            
            
        }
        
        
        
        
        
        
        
        
        
    }
    
    
    
    
    
    
    
}

extension Character {
    var isAscii: Bool {
        return unicodeScalars.allSatisfy { $0.isASCII }
    }
    var ascii: UInt32? {
        return isAscii ? unicodeScalars.first?.value : nil
    }
}
extension StringProtocol {
    var ascii: [UInt32] {
        return compactMap { $0.ascii }
    }
}
extension String {
    func isValidEmailAddress() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
}





