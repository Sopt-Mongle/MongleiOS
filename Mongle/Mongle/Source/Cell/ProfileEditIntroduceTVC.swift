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
        
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.contentView.endEditing(true)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
    }
    @objc func textFieldChanged(sender: UITextField){
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
        introduceTextField.setBorder(borderColor: .reddish, borderWidth: 1.0)
    }
    func hideWarning(){
        introduceWarningLabel.alpha = 0
        introduceWarningImageview.alpha = 0
        introduceTextField.setBorder(borderColor: .veryLightPink, borderWidth: 1.0)
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
}

extension ProfileEditIntroduceTVC: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.setBorder(borderColor: .softGreen, borderWidth: 1.0)
        selectedTextFieldDelegate()
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        unSelectedTextfieldDelegate()
        introduceDelegate(textField.text!)
        
    }
    
    
}

