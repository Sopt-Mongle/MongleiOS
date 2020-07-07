//
//  WritingThemeViewController.swift
//  Mongle
//
//  Created by Yunjae Kim on 2020/07/03.
//  Copyright © 2020 이주혁. All rights reserved.
//

import UIKit
import Then
import SnapKit

class WritingThemeVC: UIViewController, UITextFieldDelegate {
    
    
    // MARK:- IBOutlet
    @IBOutlet weak var textQuantityLabel: UILabel!
    @IBOutlet weak var applyButton: UIButton!
    @IBOutlet weak var themeNameTextField: UITextField!
    @IBOutlet weak var warningImageView: UIImageView!
    @IBOutlet weak var warningLabel: UILabel!
    @IBOutlet weak var greenLineLabel: UILabel!
    @IBOutlet weak var xButton: UIButton!
    
    
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
        partialGreenColor()
        textNum = 0;
        textNum = themeNameTextField.text?.count

        themeNameTextField.addTarget(self, action: #selector(textFieldDidChange),
                                     for: .editingChanged)
        
        warningLabel.alpha = 0
        warningImageView.alpha = 0
        xButton.setImage(UIImage(named: "searchBtnBack"), for: .normal)
        
    }
    override func viewWillAppear(_ animated: Bool) {
        registerForKeyboardNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        unregisterForKeyboardNotifications()
        themeNameTextField.text = ""
        
    }
    func partialGreenColor(){
//        let range =
        
        guard let text = self.textQuantityLabel.text else {
            return
        }
        textQuantityLabel.textColor = .softGreen
        let attributedString = NSMutableAttributedString(string: textQuantityLabel.text!)
        attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.black,
                                      range: (text as NSString).range(of: "/80"))
        textQuantityLabel.attributedText = attributedString
    }
    
    @objc func textFieldDidChange(){
       textNum = themeNameTextField.text?.count
       textQuantityLabel.text = String(textNum!)+"/80"
        partialGreenColor()
    }

   
    // MARK:- Functions
    func setThemeNameTextField(){
        themeNameTextField.setBorder(borderColor: .white, borderWidth: 1.0)

    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        let newLength = (textField.text?.count)! + string.count - range.length
        return !(newLength > 80)
    }
    
    func setApplyButton(){
        
        applyButton.makeRounded(cornerRadius: 25)
        applyButton.backgroundColor = .softGreen
        
        
    }

    @objc func updateTextLength(){
        textNum = themeNameTextField.text?.count
        textQuantityLabel.text = String(textNum!)+"/80"
        partialGreenColor()
        
    }
    
    func showWarning(){
        greenLineLabel.backgroundColor = .reddish
        warningImageView.alpha = 1
        warningLabel.alpha = 1
        
    }
    
     override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){

          self.view.endEditing(true)

    }

    func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func unregisterForKeyboardNotifications() {
           NotificationCenter.default.removeObserver(self, name:
            UIResponder.keyboardWillShowNotification, object: nil)
           NotificationCenter.default.removeObserver(self, name:
            UIResponder.keyboardWillHideNotification, object: nil)
       }
    
    @objc func keyboardWillShow(_ notification: NSNotification) {
        

        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            UIView.animate(withDuration: 0.3, animations: {
                self.applyButton.transform = CGAffineTransform(translationX: 0, y: -keyboardSize.height)
            })
            self.view.layoutIfNeeded()
        
        
    }
    }
    
    @objc func keyboardWillHide(_ notification: NSNotification) {
        guard let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double else {return}
        guard let curve = notification.userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey] as? UInt else {return}
        
        UIView.animate(withDuration: duration, delay: 0.0, options: .init(rawValue: curve), animations: {
            self.applyButton.transform = .identity
        })
        
        self.view.layoutIfNeeded()
    }
        
    
    // MARK:- IBAction Functions
    
    @IBAction func resetTextQuantity(_ sender: UITextField) {
        textNum = themeNameTextField.text?.count
       
        textQuantityLabel.text = String(textNum!)+"/80"
        partialGreenColor()
        
    }
    @IBAction func applyButtonAction(_ sender: Any) {
        if themeNameTextField.text?.count == 0{
            showWarning()
            
        }
        
        
        
    }
    

    
    @IBAction func xButtonisTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
        
    }
    
    
   
}



