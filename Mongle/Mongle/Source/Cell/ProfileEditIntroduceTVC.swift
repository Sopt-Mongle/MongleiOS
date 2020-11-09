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
    lazy var warningStackView: UIStackView = UIStackView()
    var selectedTextFieldDelegate: (() -> ()) = { }
    var unSelectedTextfieldDelegate: (() -> ()) = { }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        introduceTextField.delegate = self
        introduceTextField.text = MyProfileClass.shared.introduce ?? ""
        introduceTextField.addLeftPadding(left: 15)
        introduceTextField.makeRounded(cornerRadius: 10)
        introduceTextField.setBorder(borderColor: .veryLightPinkFive, borderWidth: 1)
        introduceTextField.addTarget(self, action: #selector(textFieldChanged(sender:)), for: .editingChanged)
        // Initialization code
        
        warningStackView = makeWarningStackView(message: "소개를 입력해주세요!", isCorrect: false)
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
    }
    @objc func textFieldChanged(sender: UITextField){
        if isValidIntroductionInput() {
            warningStackView.removeFromSuperview()
            sender.setBorder(borderColor: .softGreen, borderWidth: 1.0)
        }
        else {
            sender.setBorder(borderColor: .reddish, borderWidth: 1.0)
            self.addSubview(warningStackView)
        }
    }
    
    func makeWarningStackView(message: String, isCorrect: Bool) -> UIStackView{

        var imageStr: String = ""
        var stateColor: UIColor?
        
        if isCorrect {
            imageStr = "mySettingsProfileNamePossibleIcPossible"
            stateColor = .softGreen
        }
        else {
            imageStr = "warning"
            stateColor = .reddish
        }
        
        let label = UILabel().then {
            $0.text = message
            $0.textColor = stateColor
            $0.font = UIFont.systemFont(ofSize: 13)
            $0.sizeToFit()
        }
        
        let imageView = UIImageView().then {
            $0.frame = CGRect(x: 0, y: 0, width: 15, height: 15)
            $0.image = UIImage(named: imageStr)
        }
        
        imageView.snp.makeConstraints {
            $0.width.height.equalTo(15)
        }
        
        
        let stackView = UIStackView().then {
            $0.spacing = 8
            $0.distribution = .fill
            $0.axis = .horizontal
            $0.addArrangedSubview(imageView)
            $0.addArrangedSubview(label)
        }
        
        return stackView
    }
    func isValidIntroductionInput() -> Bool {
        guard let text = introduceTextField.text else {
            return false
        }
        if text.count > 0 && text.count < 30 {
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
        textField.setBorder(borderColor: .veryLightPink, borderWidth: 1.0)
        unSelectedTextfieldDelegate()
    }
    
    
}

