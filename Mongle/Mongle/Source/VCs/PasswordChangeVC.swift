//
//  AccountEditVC.swift
//  Mongle
//
//  Created by 이예슬 on 10/1/20.
//  Copyright © 2020 이주혁. All rights reserved.
//

import UIKit

class PasswordChangeVC: UIViewController {
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var nowPasswordTextField: UITextField!
    @IBOutlet weak var newPasswordTextField: UITextField!
    @IBOutlet weak var newPasswordCheckTextField: UITextField!
    @IBOutlet weak var completeButton: UIButton!
    @IBOutlet weak var nowWarningImage: UIImageView!
    @IBOutlet weak var nowWarningLabel: UILabel!
    @IBOutlet weak var newWarningImage: UIImageView!
    @IBOutlet weak var newWarningLabel: UILabel!
    @IBOutlet weak var completeButtonBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var backButton: UIButton!
    
    //MARK:- Custom Properties
    
    let nowPassword = "testpw"
    let heightRatio: CGFloat = UIScreen.main.bounds.height/812
    let widthRatio: CGFloat = UIScreen.main.bounds.width/375
    let blurImageView = UIImageView().then{
        $0.image = UIImage(named: "passwordChangePopupBg")
    }
    let popupView = UIView().then{
        $0.backgroundColor = .clear
    }
    var popupImageView = UIImageView().then{
        $0.image = UIImage(named: "passwordChangePopupBox")
    }
    var popupTitleLabel = UILabel().then{
        $0.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 15)
        $0.textColor = .black
        $0.adjustsFontSizeToFitWidth = true
    }
    var popupTextLabel = UILabel().then{
        $0.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 13)
        $0.numberOfLines = 0
        $0.textColor = .brownGreyThree
        $0.adjustsFontSizeToFitWidth = true
        $0.textAlignment = .center
    }
    var yesButton = UIButton().then{
        $0.setTitle("재로그인", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.backgroundColor = .softGreen
        $0.makeRounded(cornerRadius: 19)
        $0.addTarget(self, action: #selector(yesButtonAction), for: .touchUpInside)
        $0.titleLabel?.font = $0.titleLabel?.font.withSize(13)
    }
    
    //MARK:- LifeCycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setLayout()
        self.nowPasswordTextField.delegate = self
        self.newPasswordTextField.delegate = self
        self.newPasswordCheckTextField.delegate = self
        registerForKeyboardNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        unregisterForKeyboardNotifications()
    }
    
    //MARK:- Custom Methods
    
    func setLayout(){
        //TextFields
        self.nowPasswordTextField.makeRounded(cornerRadius: 10)
        self.nowPasswordTextField.setBorder(borderColor: .veryLightPinkFive, borderWidth: 1)
        self.newPasswordTextField.makeRounded(cornerRadius: 10)
        self.newPasswordTextField.setBorder(borderColor: .veryLightPinkFive, borderWidth: 1)
        self.newPasswordCheckTextField.makeRounded(cornerRadius: 10)
        self.newPasswordCheckTextField.setBorder(borderColor: .veryLightPinkFive, borderWidth: 1)
        self.nowPasswordTextField.addLeftPadding(left: 15)
        self.newPasswordTextField.addLeftPadding(left: 15)
        self.newPasswordCheckTextField.addLeftPadding(left: 15)
        //Buttons
        self.completeButton.setTitleColor(.white, for: .normal)
        self.nowWarningImage.alpha = 0
        self.nowWarningLabel.alpha = 0
        self.newWarningImage.alpha = 0
        self.newWarningLabel.alpha = 0
        
    }
    
    func setNowWarning(_ warning: WarningState){
        switch warning{
            case .match:
                nowWarningLabel.text = "현재 비밀번호가 일치하지 않아요!"
            case .empty:
                nowWarningLabel.text = "현재 비밀번호를 입력해주세요!"
            case .rule:
                nowWarningLabel.text = "영문+숫자 최소 8자리 이상 입력해주세요!"
        }
        nowWarningImage.alpha = 1
        nowWarningLabel.alpha = 1
    }
    
    func setNewWarning(_ warning: WarningState){
        switch warning{
            case .rule:
                newWarningLabel.text = "영문+숫자 최소 8자리 이상 입력해주세요!"
            case .match:
                newWarningLabel.text = "비밀번호가 일치하지 않아요!"
            case .empty:
                newWarningLabel.text = "새 비밀번호를 한 번 더 입력해주세요!"
        }
        newWarningImage.image = UIImage(named:"warning")
        newWarningLabel.textColor = .reddish
        newWarningImage.alpha = 1
        newWarningLabel.alpha = 1
    }
    func setNewOkay(){
        newWarningImage.image = UIImage(named:"joinPassword5IcPossible")
        newWarningLabel.textColor = .softGreen
        newWarningLabel.text = "비밀번호가 일치해요!"
        newWarningLabel.alpha = 1
        newWarningLabel.alpha = 1
    }
    
    func setNowComplete(){
        nowWarningImage.alpha = 0
        nowWarningLabel.alpha = 0
    }
    
    func setNewComplete(){
        newWarningImage.alpha = 0
        newWarningLabel.alpha = 0
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.view.endEditing(true)
    }
    func checkAllPassword() -> Bool{
        var valid = true
        if nowPasswordTextField.text == ""{
            nowPasswordTextField.setBorder(borderColor: .reddish, borderWidth: 1)
            setNowWarning(.empty)
            valid = false
        }
        if newPasswordTextField.text == ""{
            newPasswordTextField.setBorder(borderColor: .reddish, borderWidth: 1)
            setNewWarning(.rule)
            valid = false
        }
        if newPasswordCheckTextField.text == ""{
            newPasswordCheckTextField.setBorder(borderColor: .reddish, borderWidth: 1)
            setNewWarning(.empty)
            valid = false
        }
        
        if nowPassword != nowPasswordTextField.text{
            valid = false
        }
        if newPasswordTextField.text == newPasswordCheckTextField.text{
            if newPasswordTextField.text?.isValidPassword() == false{
                valid = false
                newPasswordTextField.setBorder(borderColor: .reddish, borderWidth: 1)
                setNewWarning(.rule)
            }
        }
        else{
            valid = false
            if newPasswordTextField.text?.isValidPassword() == false{
                newPasswordTextField.setBorder(borderColor: .reddish, borderWidth: 1)
                setNewWarning(.rule)
            }
            else{
                newPasswordCheckTextField.setBorder(borderColor: .reddish, borderWidth: 1)
                setNewWarning(.match)
            }
        }
        
        return valid
        
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
    
    func showPopupView(_ popupTitle: String, _ popupText: String){
        
        self.view.addSubview(blurImageView)
        self.view.addSubview(popupView)
        self.popupView.addSubview(popupImageView)
        self.popupView.addSubview(popupTitleLabel)
        self.popupView.addSubview(popupTextLabel)
        self.popupView.addSubview(yesButton)
        //constraints
        self.popupTitleLabel.text = popupTitle
        self.popupTextLabel.text = popupText
        self.blurImageView.snp.makeConstraints{
            $0.top.bottom.leading.trailing.equalToSuperview()
        }
        self.popupView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(290*heightRatio)
            $0.leading.equalToSuperview().offset(35*widthRatio)
            $0.bottom.equalToSuperview().offset(-289*heightRatio)
            $0.trailing.equalToSuperview().offset(-35*widthRatio)
        }
        self.popupImageView.snp.makeConstraints{
            $0.top.bottom.leading.trailing.equalToSuperview()
        }
        self.popupTitleLabel.snp.makeConstraints{
            $0.top.equalToSuperview().offset(84*heightRatio)
            $0.bottom.equalToSuperview().offset(-131*heightRatio)
            $0.centerX.equalToSuperview()
        }
        self.popupTextLabel.snp.makeConstraints{
            $0.top.equalToSuperview().offset(112*heightRatio)
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-88*heightRatio)
        }
        self.yesButton.snp.makeConstraints{
            $0.top.equalToSuperview().offset(171*heightRatio)
            $0.bottom.equalToSuperview().offset(-25*heightRatio)
            $0.leading.equalToSuperview().offset(88*widthRatio)
            $0.trailing.equalToSuperview().offset(-88*widthRatio)
        }
        backButton.isUserInteractionEnabled = false
        nowPasswordTextField.isUserInteractionEnabled = false
        newPasswordTextField.isUserInteractionEnabled = false
        newPasswordCheckTextField.isUserInteractionEnabled = false
        completeButton.isUserInteractionEnabled = false
        
    }
    
    //MARK: - @objc methods
    
    @objc func keyboardWillShow(_ notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey]
                                as? NSValue)?.cgRectValue {
            UIView.animate(withDuration: 0.3, animations: {
                self.completeButtonBottomConstraint.constant =  keyboardSize.height+16
            })
        }
    }
    
    @objc func keyboardWillHide(_ notification: NSNotification) {
        guard let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey]
                as? Double else {return}
        guard let curve = notification.userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey]
                as? UInt else {return}
        
        UIView.animate(withDuration: duration, delay: 0.0, options: .init(rawValue: curve),
                       animations: {
                        self.completeButtonBottomConstraint.constant = 50
                        self.view.layoutIfNeeded()
                       })
    }
    @objc func yesButtonAction(){
        guard let loginVC = UIStoryboard(name:"LogIn", bundle:nil).instantiateViewController(identifier: "LogInVC") as? LogInVC else{
                            return
                        }
        loginVC.modalPresentationStyle = .fullScreen
        self.present(loginVC,animated: true){
            self.navigationController?.popToRootViewController(animated: false)
        }
//        self.navigationController?.popToRootViewController(animated: false){
//            guard let loginVC = UIStoryboard(name:"LogIn", bundle:nil).instantiateViewController(identifier: "LogInVC") as? LogInVC else{
//                return
//            }
//            self.view.window?.rootViewController?.present(loginVC,animated:true,completion:nil)
//        }
    }
    
    // MARK: - IBActions
    
    @IBAction func touchUpBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func touchUpComplete(_ sender: Any) {
        if checkAllPassword() == true {
            //비밀번호 변경 API 성공
            self.view.endEditing(true)
            self.nowPasswordTextField.setBorder(borderColor: .softGreen, borderWidth: 1)
            self.newPasswordTextField.setBorder(borderColor: .softGreen, borderWidth: 1)
            self.newPasswordCheckTextField.setBorder(borderColor: .softGreen, borderWidth: 1)
            showPopupView("비밀번호가 변경되었어요!", "변경된 비밀번호로\n재로그인을 해주세요!")
        }
    }
    
}

extension PasswordChangeVC: UITextFieldDelegate{
    func textFieldDidBeginEditing(_ textField: UITextField) {
        //현재 비밀번호
        if textField == nowPasswordTextField{
            textField.setBorder(borderColor: .softGreen, borderWidth: 1)
        }
        //새 비밀번호
        else if textField == newPasswordTextField{
            textField.setBorder(borderColor: .softGreen, borderWidth: 1)
            newPasswordCheckTextField.text = ""
            newPasswordCheckTextField.setBorder(borderColor: .veryLightPinkFive, borderWidth: 1)
        }
        //새 비밀번호 확인
        else{
            textField.setBorder(borderColor: .softGreen, borderWidth: 1)
        }
        
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == nowPasswordTextField{
            if textField.text == ""{
                textField.setBorder(borderColor: .reddish, borderWidth: 1)
                setNowWarning(.empty)
            }
            else if textField.text != nowPassword{
                textField.setBorder(borderColor: .reddish, borderWidth: 1)
                setNowWarning(.match)
            }
            else{
                textField.setBorder(borderColor: .veryLightPinkFive, borderWidth: 1)
                setNowComplete()
            }
        }
        else if textField == newPasswordTextField{
            if textField.text == ""{
                textField.setBorder(borderColor: .reddish, borderWidth: 1)
                setNewWarning(.empty)
            }
            else if textField.text?.isValidPassword() == false{
                textField.setBorder(borderColor: .reddish, borderWidth: 1)
                setNewWarning(.rule)
            }
            else{
                textField.setBorder(borderColor: .veryLightPinkFive, borderWidth: 1)
                setNewComplete()
            }
        }
        else{
            if textField.text == ""{
                textField.setBorder(borderColor: .reddish, borderWidth: 1)
                setNewWarning(.empty)
            }
            else if newPasswordTextField.text?.isValidPassword() == false{
                newPasswordTextField.setBorder(borderColor: .reddish, borderWidth: 1)
                setNewWarning(.rule)
            }
            else if textField.text != newPasswordTextField.text{
                textField.setBorder(borderColor: .reddish, borderWidth: 1)
                setNewWarning(.match)
            }
            else{
                textField.setBorder(borderColor: .veryLightPinkFive, borderWidth: 1)
                setNewComplete()
            }
        }
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let temp: String = (textField.text ?? "" ) + string
        var idx = 0
        if temp.count-range.length-1>=0{
            idx = temp.count-range.length-1
        }
        else{
            idx = 0
        }
        let strIndex = temp.index(temp.startIndex,offsetBy: idx)
        let subStr = temp[temp.startIndex...strIndex]
        let str = String(subStr)
        //현재 비밀번호
        if textField == nowPasswordTextField{
            if str.isValidPassword() == false{
                setNowWarning(.rule)
            }
            else if str.isValidPassword() == true{
                setNowComplete()
            }
        }
        //새 비밀번호
        else if textField == newPasswordTextField{
            if str.isValidPassword() == false{
                textField.setBorder(borderColor: .reddish, borderWidth: 1)
                setNewWarning(.rule)
            }
            else if str.isValidPassword() == true{
                textField.setBorder(borderColor: .softGreen, borderWidth: 1)
                setNewComplete()
            }
        }
        //새 비밀번호 확인
        else if textField == newPasswordCheckTextField{
            if str != self.newPasswordTextField.text{
                textField.setBorder(borderColor: .reddish, borderWidth: 1)
                setNewWarning(.match)
            }
            else if str == self.newPasswordTextField.text{
                textField.setBorder(borderColor: .softGreen, borderWidth: 1)
                setNewOkay()
            }
        }
        return true
    }
    
    
}

enum WarningState{
    case rule, match,empty
}

extension UINavigationController{
    func popToRootViewController(animated: Bool = true, completion: @escaping () -> Void) {
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        popToRootViewController(animated: animated)
        CATransaction.commit()
    }
}

