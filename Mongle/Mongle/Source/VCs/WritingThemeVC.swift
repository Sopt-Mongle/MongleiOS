//
//  WritingThemeViewController.swift
//  Mongle
//
//  Created by Yunjae Kim on 2020/07/03.
//  Copyright © 2020 이주혁. All rights reserved.
//

import UIKit

class WritingThemeVC: UIViewController, UITextFieldDelegate {
    
    
    // MARK:- IBOutlet
    @IBOutlet weak var textQuantityLabel: UILabel!
    @IBOutlet weak var applyButton: UIButton!
    @IBOutlet weak var themeNameTextField: UITextField!
    
    
    // MARK:- Class Variables
    var textNum : Int?
  

    
    
    // MARK:- LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        themeNameTextField.delegate = self
        setThemeNameTextField()
        // Do any additional setup after loading the view.
        setApplyButton()
        textQuantityLabel.text = "0/80"
        textNum = 0;
        textNum = themeNameTextField.text?.count

        themeNameTextField.addTarget(self, action: #selector(textFieldDidChange),
                                     for: .editingChanged)
        
        
    }
    
    
    @objc func textFieldDidChange(){
       textNum = themeNameTextField.text?.count
       textQuantityLabel.text = String(textNum!)+"/80"
    }

   
    // MARK:- Functions
    func setThemeNameTextField(){
        themeNameTextField.setBorder(borderColor: .white, borderWidth: 1.0)

    }
    
    func setApplyButton(){
        
        applyButton.makeRounded(cornerRadius: 25)
        applyButton.backgroundColor = .softGreen
        
        
    }
    
    @objc func updateTextLength(){
        textNum = themeNameTextField.text?.count
        textQuantityLabel.text = String(textNum!)+"/80"
        
    }
    
    
    
    
    // MARK:- IBAction Functions
    
    @IBAction func resetTextQuantity(_ sender: UITextField) {
        textNum = themeNameTextField.text?.count
       
        textQuantityLabel.text = String(textNum!)+"80"
        
    }
    @IBAction func applyButtonAction(_ sender: Any) {
        textNum = themeNameTextField.text?.count
        print(textNum!)
        
    }
    

    
    @IBAction func xButtonisTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
        
    }
    
    
    

}
