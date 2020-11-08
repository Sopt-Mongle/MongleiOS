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
    //MARK:- Custom Properties
    
    let nowPassword = "testpw"
    
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
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        
        self.view.endEditing(true)
        
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
    
    @IBAction func touchUpBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    func setNowWarning(_ warning: WarningState){
        switch warning{
            case .match:
                nowWarningLabel.text = "현재 비밀번호가 일치하지 않아요!"
            case .empty:
                nowWarningLabel.text = "현재 비밀번호를 입력해주세요!"
            default:
                break
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
        newWarningImage.alpha = 1
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
            else if textField.text?.isValidPassword() != true{
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
        let str = (textField.text ?? "" ) + string
        print(str)
        //새 비밀번호
        if textField == newPasswordTextField{
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
                setNewComplete()
            }
        }
        return true
    }
    
    
}

enum WarningState{
    case rule, match,empty
}
