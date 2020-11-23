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
    
    let nowPassword = UserDefaults.standard.string(forKey: "password")
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
        self.nowPasswordTextField.addTarget(self, action: #selector(textFieldDidChange(sender:)), for: .editingChanged)
        self.newPasswordTextField.addTarget(self, action: #selector(textFieldDidChange(sender:)), for: .editingChanged)
        self.newPasswordCheckTextField.addTarget(self, action: #selector(textFieldDidChange(sender:)), for: .editingChanged)
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
            default:
                nowWarningLabel.text = ""
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
                newWarningLabel.text = "새 비밀번호를 입력해주세요!"
            case .newempty:
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

    }
    @objc func textFieldDidChange(sender:UITextField) {
            if let text = sender.text {
                if sender == nowPasswordTextField{
                    
                    if text == ""{
                        setNowComplete()
                    }
                    else if text.isValidPassword() == false{
                        setNowWarning(.rule)
                    }
                    else if text.isValidPassword() == true{
                        setNowComplete()
                    }
                }
                //새 비밀번호
                else if sender == newPasswordTextField{
                    if text == ""{
                        setNewComplete()
                    }
                    else if text.isValidPassword() == false{
                        setNewWarning(.rule)
                    }
                    else if text.isValidPassword() == true{
                        sender.setBorder(borderColor: .softGreen, borderWidth: 1)
                        setNewComplete()
                    }
                }
                //새 비밀번호 확인
                else if sender == newPasswordCheckTextField{
                    if text != self.newPasswordTextField.text {
                        sender.setBorder(borderColor: .reddish, borderWidth: 1)
                        if text != ""{
                            setNewWarning(.match)
                        }
                        else{
                            setNewWarning(.newempty)
                        }
                    }
                    else if text == self.newPasswordTextField.text{
                        sender.setBorder(borderColor: .softGreen, borderWidth: 1)
                        setNewOkay()
                    }
                }
            }
                
    }
    
    // MARK: - IBActions
    
    @IBAction func touchUpBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func touchUpComplete(_ sender: Any) {
        if checkAllPassword() == true {
            //비밀번호 변경 API 성공
            PasswordChangeService.shared.putRequest(password: self.newPasswordTextField.text!){
                networkResult in
                switch networkResult{
                    case .success(let message):
                        guard let message = message as? String else { return }
                        print(message)
                        UserDefaults.standard.setValue(self.newPasswordTextField.text!, forKey: "password")
                        self.view.endEditing(true)
                        self.nowPasswordTextField.setBorder(borderColor: .softGreen, borderWidth: 1)
                        self.newPasswordTextField.setBorder(borderColor: .softGreen, borderWidth: 1)
                        self.newPasswordCheckTextField.setBorder(borderColor: .softGreen, borderWidth: 1)
                        self.showPopupView("비밀번호가 변경되었어요!", "변경된 비밀번호로\n재로그인을 해주세요!")
                        
                    case .requestErr(let message):
                        
                        guard let message = message as? String else { return }
                        print(message)
                        self.showToast(text: message)
                    case .pathErr:
                        
                        print("path")
                    case .serverErr:
                        print("serverErr")
                        self.showToast(text: "서버 내부 오류")
                    case .networkFail:
                        print("networkFail")
                        self.showToast(text: "네트워크 실패")
                    }
            
            }
            
        }
    }
    
}

//MARK: - UITextFieldDelegate

extension PasswordChangeVC: UITextFieldDelegate{
    //입력시작
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.setBorder(borderColor: .softGreen, borderWidth: 1)
        //새 비밀번호
        if textField == nowPasswordTextField{
            setNowComplete()
        }
        else if textField == newPasswordTextField{
            //새 비밀번호 확인 초기화 시키고 회색 border
            setNewComplete()
            newPasswordCheckTextField.text = ""
            newPasswordCheckTextField.setBorder(borderColor: .veryLightPinkFive, borderWidth: 1)
        }
        else{
            setNewComplete()
        }
    }
    //입력완료
    func textFieldDidEndEditing(_ textField: UITextField) {
        //현재 비밀번호
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
        //새 비밀번호
        else if textField == newPasswordTextField{
            //빈칸
            if textField.text == ""{
                textField.setBorder(borderColor: .reddish, borderWidth: 1)
                setNewWarning(.empty)
            }
            //규칙 위반
            else if textField.text?.isValidPassword() == false{
                textField.setBorder(borderColor: .reddish, borderWidth: 1)
                setNewWarning(.rule)
            }
            //정상
            else{
                textField.setBorder(borderColor: .veryLightPinkFive, borderWidth: 1)
                setNewComplete()
            }
        }
        //새 비밀번호 확인
        else{
            //새 비밀번호 빈칸
            if newPasswordTextField.text == ""{
                setNewWarning(.empty)
                newPasswordTextField.setBorder(borderColor: .reddish, borderWidth: 1)
                newPasswordCheckTextField.setBorder(borderColor: .reddish, borderWidth: 1)
                
            }
            //새 비밀번호 정상
            else if newPasswordTextField.text?.isValidPassword() == true{
                //새 비밀번호 확인 빈칸
                if textField.text == ""{
                    setNewWarning(.newempty)
                }
                //모두 일치
                else{
                    setNewComplete()
                    newPasswordCheckTextField.setBorder(borderColor:.veryLightPinkFive, borderWidth: 1)
                }
        
            }
            //새 비밀번호 안 정상
            else{
                newPasswordTextField.setBorder(borderColor: .reddish, borderWidth: 1)
                setNewWarning(.rule)
            }
        }
    }
    //입력중
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
//        let temp: String = (textField.text ?? "" ) + string
//        var idx = 0
//        if temp.count-range.length-1>=0{
//            idx = temp.count-range.length-1
//        }
//        else{
//            idx = 0
//        }
//        let strIndex = temp.index(temp.startIndex,offsetBy: idx)
//        let subStr = temp[temp.startIndex...strIndex]
//        //실제 입력값
//        let str = String(subStr)
//        //현재 비밀번호
//        if textField == nowPasswordTextField{
//            
//            if str == ""{
//                setNowComplete()
//            }
//            else if str.isValidPassword() == false{
//                setNowWarning(.rule)
//            }
//            else if str.isValidPassword() == true{
//                setNowComplete()
//            }
//        }
//        //새 비밀번호
//        else if textField == newPasswordTextField{
//            print("\(str) 실제 입력")
//            if str == ""{
//                setNewComplete()
//            }
//            else if str.isValidPassword() == false{
//                setNewWarning(.rule)
//            }
//            else if str.isValidPassword() == true{
//                textField.setBorder(borderColor: .softGreen, borderWidth: 1)
//                setNewComplete()
//            }
//        }
//        //새 비밀번호 확인
//        else if textField == newPasswordCheckTextField{
//            if str != self.newPasswordTextField.text {
//                textField.setBorder(borderColor: .reddish, borderWidth: 1)
//                if str != ""{
//                    setNewWarning(.match)
//                }
//                else{
//                    setNewWarning(.newempty)
//                }
//            }
//            else if str == self.newPasswordTextField.text{
//                textField.setBorder(borderColor: .softGreen, borderWidth: 1)
//                setNewOkay()
//            }
//        }
        return true
    }
    
    
}

enum WarningState{
    case rule, match,empty, newempty
}
