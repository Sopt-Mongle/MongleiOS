//
//  AccountEditVC.swift
//  Mongle
//
//  Created by 이예슬 on 10/1/20.
//  Copyright © 2020 이주혁. All rights reserved.
//

import UIKit

class AccountEditVC: UIViewController {
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var nowPasswordTextField: UITextField!
    
    @IBOutlet weak var newPasswordTextField: UITextField!
    @IBOutlet weak var newPasswordCheckTextField: UITextField!
    @IBOutlet weak var completeButton: UIButton!
    
    @IBOutlet weak var withdrawButton: UIButton!
    //MARK:- LifeCycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setLayout()
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

        //Buttons
        self.completeButton.backgroundColor = .softGreen
        self.completeButton.setTitleColor(.white, for: .normal)
        self.withdrawButton.backgroundColor = .clear
        self.withdrawButton.setTitleColor(.veryLightPink,for:.normal)
        
    }
}
