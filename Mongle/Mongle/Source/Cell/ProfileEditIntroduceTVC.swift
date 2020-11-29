//
//  ProfileEditIntroduceTVC.swift
//  Mongle
//
//  Created by 이주혁 on 2020/07/14.
//  Copyright © 2020 이주혁. All rights reserved.
//

import UIKit

class ProfileEditIntroduceTVC: UITableViewCell {
    static let identifier = "ProfileEditIntroduceTVC"
    
    @IBOutlet var introduceTextField: UITextField! {
        didSet {
            introduceTextField.autocorrectionType = .no
        }
    }
    @IBOutlet weak var introduceCountLabel: UILabel!
    @IBOutlet weak var introduceWarningImageview: UIImageView!
    @IBOutlet weak var introduceWarningLabel: UILabel!
    var selectedTextFieldDelegate: (() -> ()) = { }
    var unSelectedTextfieldDelegate: (() -> ()) = { }
    var introduceDelegate: ((String) -> ()) = { _ in }
    static var isIntroduceValid:Bool?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        introduceTextField.delegate = self
        introduceTextField.addLeftPadding(left: 15)
        introduceTextField.makeRounded(cornerRadius: 10)
        introduceTextField.setBorder(borderColor: .veryLightPinkFive, borderWidth: 1)
        introduceTextField.addTarget(self, action: #selector(textFieldChanged(sender:)), for: .editingChanged)
        // Initialization code
        introduceTextField.text =
            UserDefaults.standard.string(forKey: "UserProfileIntroduce")
        ProfileEditIntroduceTVC.isIntroduceValid = isValidIntroductionInput()
        partialGreenColor()
        introduceCountLabel.text = "\((introduceTextField.text?.count)!)/30"
        introduceCountLabel.adjustsFontSizeToFitWidth = true
        introduceCountLabel.alpha = 0
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.contentView.endEditing(true)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
    }
    @objc func textFieldChanged(sender: UITextField){
        if let text = sender.text {
            // 초과되는 텍스트 제거
            if text.count > 30 {
                let index = text.index(text.startIndex, offsetBy: 29)
                let newString = text[text.startIndex...index]
                sender.text = String(newString)
            }
            partialGreenColor()
        }
        ProfileEditIntroduceTVC.isIntroduceValid = isValidIntroductionInput()
        if ProfileEditIntroduceTVC.isIntroduceValid! {
            hideWarning()
            
        }
        else {
            showWarning()
            
        }
    }
    
    
    func showWarning(){
        introduceWarningLabel.alpha = 1
        introduceWarningImageview.alpha = 1
    }
    func hideWarning(){
        introduceWarningLabel.alpha = 0
        introduceWarningImageview.alpha = 0
    }
    func isValidIntroductionInput() -> Bool {
        guard let text = introduceTextField.text else {
            return false
        }
        if text.count > 0 && text.count <= 30 {
           return true
        }
        return false
        
    }
    func partialGreenColor(){
        
        guard let text = self.introduceTextField.text else {
            return
        }
        if text == ""{
            introduceCountLabel.text = "0/30"
            introduceCountLabel.textColor = .veryLightPink
        }
        else{
            introduceCountLabel.text = "\(text.count)/30"
            introduceCountLabel.textColor = .softGreen
            let attributedString = NSMutableAttributedString(string: introduceCountLabel.text!)
            attributedString.addAttribute(NSAttributedString.Key.foregroundColor,
                                          value: UIColor.veryLightPink,
                                          range: (introduceCountLabel.text! as NSString).range(of: "/30"))
            introduceCountLabel.attributedText = attributedString
            }
    }
}

extension ProfileEditIntroduceTVC: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.setBorder(borderColor: .softGreen, borderWidth: 1.0)
        selectedTextFieldDelegate()
        introduceCountLabel.alpha = 1
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        if isValidIntroductionInput(){
            hideWarning()
            textField.setBorder(borderColor: .veryLightPinkFive, borderWidth: 1)
        }
        else{
            showWarning()
            textField.setBorder(borderColor: .reddish, borderWidth: 1.0)
        }
        
        unSelectedTextfieldDelegate()
        introduceDelegate(textField.text!)
        introduceCountLabel.alpha = 0
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else {return false}
            
            // 중간에 추가되는 텍스트 막기
            if text.count >= 30 && range.length == 0 && range.location < 30 {
                return false
            }
            
            return true
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }
    
    
}

