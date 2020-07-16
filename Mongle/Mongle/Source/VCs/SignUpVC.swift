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
    
    @IBOutlet weak var headerContainerView: UIView!
    @IBOutlet weak var mongleCharacterImageView: UIImageView!
    @IBOutlet weak var HeaderLabel: UIImageView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passWordTextField: UITextField!
    @IBOutlet weak var passWordTextField2: UITextField!
    @IBOutlet weak var nickNameTextField: UITextField!
    @IBOutlet weak var nickNameWarningImageView: UIImageView!
    @IBOutlet weak var nickNameWarningLabel: UILabel!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    
    @IBOutlet weak var scrollViewBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var signUpScrollView: UIScrollView!
    @IBOutlet weak var buttonBottomConstraint: NSLayoutConstraint!
    
    
    //MARK:- Constraints For Warning
    
    @IBOutlet weak var emailToPassWordConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var passWordToNIckNameConstraint: NSLayoutConstraint!
    
    
    //MARK:- User Define Variables
    
    let underBlur = UIImageView().then {
        $0.image = UIImage(named: "joinEmailBoxBlur")
    
    }
    let upperBlur = UIImageView().then {
        $0.image = UIImage(named: "joinPasswordBoxBlur")
        
    }
    let emailWarningImageView = UIImageView().then {
        $0.image = UIImage(named: "joinEmailErrorIcWarning")
        
    }
    
    let emailWarningLabel = UILabel().then {
        $0.text = "이메일 주소를 입력해주세요!"
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
    
    
    var emailIsWarning : Int = 0
    var passwordIsWarning : Int = 0
    
    
    
    
    //MARK:- LifeCycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setItems()
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
        backButton.setImage(UIImage(named: "joinEmailErrorBtnClose")?.withRenderingMode(.alwaysOriginal), for: .normal)
        headerContainerView.backgroundColor = .clear
        mongleCharacterImageView.image = UIImage(named: "joinEmail2ImgMongle")
        HeaderLabel.image = UIImage(named: "yoonjaeFighting")
        emailTextField.placeholder = "이메일 주소를 입력해주세요."
        passWordTextField.placeholder = "비밀번호를 입력해주세요."
        passWordTextField2.placeholder = "비밀번호를 한 번 더 확인해주세요."
        nickNameTextField.placeholder = "닉네임을 6자 이내로 입력해주세요. "
        
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
        registerButton.setTitle("가입하기", for: .normal)
        registerButton.setTitleColor(.white, for: .normal)
        registerButton.backgroundColor = .softGreen
        registerButton.makeRounded(cornerRadius: 30)
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
            let move = CGPoint(x: 0, y: 162)
            signUpScrollView.setContentOffset(move, animated: false)
            hidePasswordWarning()
            
        
        }
        
        else if textField == nickNameTextField {
            let move = CGPoint(x: 0, y: 280)
            signUpScrollView.setContentOffset(move, animated: false)
            hideNickNameWarning()
            updateNicknameQuantity()
        }
        else if textField == emailTextField{
            
            hideEmailWarning()
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
   
    
    
    @objc func keyboardWillShow(_ notification: NSNotification) {
        
        
        
       
      
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey]
            as? NSValue)?.cgRectValue {
            scrollViewBottomConstraint.constant = keyboardSize.height + 82
            UIView.animate(withDuration: 0.3, animations: {
                self.buttonBottomConstraint.constant =  keyboardSize.height+17
                
                
            })
            
            self.view.layoutIfNeeded()
            
            self.view.addSubview(underBlur)
            self.view.addSubview(upperBlur)
            self.view.bringSubviewToFront(registerButton)
            underBlur.snp.makeConstraints {
                $0.bottom.equalToSuperview().offset(-keyboardSize.height)
                $0.height.equalTo(123)
                $0.leading.trailing.equalToSuperview()
                
            }
            
            upperBlur.snp.makeConstraints {
                $0.top.equalToSuperview().offset(76)
                $0.leading.trailing.equalToSuperview()
                $0.height.equalTo(53)
                
            }
            
            
            
            
        }
        
        
    }
    
    
    
    @objc func keyboardWillHide(_ notification: NSNotification) {
        self.underBlur.removeFromSuperview()
        self.upperBlur.removeFromSuperview()
       
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
        
        if passWordTextField.text == passWordTextField2.text && passWordTextField.text != "" && passWordTextField2.text != ""{
            
            self.passwordWarningLabel.text = "비밀번호가 일치해요!"
            self.passwordWarningImageView.image = UIImage(named: "joinPassword5IcPossible")
            self.passwordWarningLabel.textColor = .softGreen
            
            
            
            
        }
        else if passWordTextField2.text != ""{
            secondPasswordBegin()
        }
        
        
    }
    @objc func updateNicknameQuantity(){
        
        nickNameQuantityLabel.alpha = 1
        nickNameQuantityLabel.text = String(nickNameTextField.text!.count) + "/6"
        partialGreenColor()
        nickNameQuantityLabel.snp.remakeConstraints {
            $0.top.equalToSuperview().offset(527 + emailIsWarning + passwordIsWarning)
            
            $0.trailing.equalToSuperview().offset(-28)
            
        }
        
        
        
    }
    
    func showEmailWarning(){
        emailToPassWordConstraint.constant = 59
        self.signUpScrollView.addSubview(emailWarningImageView)
        self.signUpScrollView.addSubview(emailWarningLabel)
        
        emailWarningImageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(253)
            $0.leading.equalToSuperview().offset(28)
            $0.width.height.equalTo(15)
        }
        
        emailWarningLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(253)
            $0.leading.equalToSuperview().offset(51)
            
        }
        self.emailTextField.setBorder(borderColor: .reddish, borderWidth: 1.0)
        
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
        
        passWordToNIckNameConstraint.constant = 59
        self.signUpScrollView.addSubview(passwordWarningImageView)
        self.signUpScrollView.addSubview(passwordWarningLabel)
        
        passwordWarningImageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(416 + emailIsWarning)
            $0.leading.equalToSuperview().offset(28)
            $0.width.height.equalTo(15)
        }
        
        passwordWarningLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(416 + emailIsWarning)
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
        
        passwordIsWarning = 0
        passWordToNIckNameConstraint.constant = 34
        passwordWarningLabel.removeFromSuperview()
        passwordWarningImageView.removeFromSuperview()
        
        self.passWordTextField.setBorder(borderColor: .veryLightPinkFive, borderWidth: 1.0)
        self.passWordTextField2.setBorder(borderColor: .veryLightPinkFive, borderWidth: 1.0)
        
        
    }
    func secondPasswordBegin(){
        passWordToNIckNameConstraint.constant = 59
        self.signUpScrollView.addSubview(passwordWarningImageView)
        self.signUpScrollView.addSubview(passwordWarningLabel)
       
        
        passwordWarningImageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(416+emailIsWarning)
            $0.leading.equalToSuperview().offset(28)
            $0.width.height.equalTo(15)
        }
        
        passwordWarningLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(416+emailIsWarning)
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
        
        
        
    }
    func showNickNameWarning(){
        nickNameWarningLabel.text = "닉네임을 입력해주세요!"
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
        nickNameTextField.setBorder(borderColor: .softGreen, borderWidth: 1.0)
        nickNameWarningLabel.alpha = 0
        nickNameWarningImageView.alpha = 0
    }
    
    
    
    @IBAction func registerButtonAction(_ sender: Any) {
        self.view.endEditing(true)
        if emailTextField.text == ""{
            showEmailWarning()
            
            if passwordIsWarning == 25 {
                hidePasswordWarning()
                showPasswordWarning()
                
                
            }
            

        }
        else if passWordTextField.text == "" || passWordTextField2.text == ""{
            
            showPasswordWarning()
            
        }
        else if nickNameTextField.text == ""{
            showNickNameWarning()
        }
        else if passWordTextField.text != passWordTextField2.text{
            passWordTextField.setBorder(borderColor: .reddish, borderWidth: 1.0)
            passWordTextField2.setBorder(borderColor: .reddish, borderWidth: 1.0)
            
            secondPasswordBegin()
        }
        else {
            signup()
        }
        
        
        
    }
    
    
    @IBAction func backButtonAction(_ sender: Any) {
        
        
        
        dismiss(animated: true, completion: nil)
        
    }
    
    func signup(){
        guard let email = emailTextField.text else {return}
        guard let password = passWordTextField.text else {return}
        guard let name = nickNameTextField.text else {return}
        
        SignUpService.shared.signup(email: email,
                                    password: password,
                                    name: name)  { networkResult in
                                        switch networkResult {
                                        case .success(let token) :
                                            print("success")
                                            
                                            guard let vcName = UIStoryboard(name: "SignUpEnd",
                                                                            bundle: nil).instantiateViewController(
                                                                                withIdentifier: "SignUpEndVC") as? SignUpEndVC
                                                else{
                                                    
                                                    return
                                            }
                                            
                                            vcName.modalPresentationStyle = .fullScreen
                                           
                                            self.present(vcName, animated: true, completion: nil)
                                            
                                        case .requestErr(let message):
                                            print("request")
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
