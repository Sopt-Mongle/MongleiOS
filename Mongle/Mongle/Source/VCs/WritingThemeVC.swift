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
    @IBOutlet weak var xButton: UIButton!
    
    @IBOutlet weak var secondLabel: UILabel!
    @IBOutlet weak var themeCollectionView: UICollectionView!
    
    
    
    // MARK:- Class Variables
    var textNum : Int?
    
    var images = ["mainImgTheme2","mainImgTheme2","mainImgTheme2","mainImgTheme2","mainImgTheme2",
                  "mainImgTheme2","mainImgTheme2","mainImgTheme2","mainImgTheme2","mainImgTheme2"]
  
    var checkIndex : Int?
    

    
    
    // MARK:- LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        themeNameTextField.delegate = self
        setThemeNameTextField()
        // Do any additional setup after loading the view.
        setApplyButton()
        textQuantityLabel.text = "0/40"
        
        textNum = 0;
        textNum = themeNameTextField.text?.count

        themeNameTextField.addTarget(self, action: #selector(textFieldDidChange),
                                     for: .editingChanged)
        textQuantityLabel.textColor = .veryLightPink
      
        xButton.setImage(UIImage(named: "writingThemeBtnClose")?.withRenderingMode(.alwaysOriginal),
                         for: .normal)
        secondLabel.textColor = .greyishBrown
        secondLabel.text = "테마 배경 이미지를 선택해주세요!"
        partialGreenColor2()
        themeCollectionView.delegate = self
        themeCollectionView.dataSource = self

        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        registerForKeyboardNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        unregisterForKeyboardNotifications()
        
        themeNameTextField.text = ""
        
    }
    
    
    
    
    
    
   
    // MARK:- Functions
    func setThemeNameTextField(){
        themeNameTextField.setBorder(borderColor: .veryLightPinkFive, borderWidth: 1.0)
        themeNameTextField.addLeftPadding(left: 7.5)
        
    }
    
    func partialGreenColor(){
        
        
        guard let text = self.textQuantityLabel.text else {
            return
        }
        textQuantityLabel.textColor = .softGreen
        let attributedString = NSMutableAttributedString(string: textQuantityLabel.text!)
        attributedString.addAttribute(NSAttributedString.Key.foregroundColor,
                                      value: UIColor.veryLightPink,
                                      range: (text as NSString).range(of: "/40"))
        if themeNameTextField.text == "" {
            textQuantityLabel.textColor = .veryLightPink
        }
        textQuantityLabel.attributedText = attributedString
    }
    
    func partialGreenColor2(){
        
        
        guard let text = self.secondLabel.text else {
            return
        }
        let attributedString = NSMutableAttributedString(string: secondLabel.text!)
        attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.softGreen,
                                      range: (text as NSString).range(of: "테마 배경 이미지"))
        
        secondLabel.attributedText = attributedString
        
        
    }
    
    @objc func textFieldDidChange(){
       textNum = themeNameTextField.text?.count
       textQuantityLabel.text = String(textNum!)+"/40"
        partialGreenColor()
    }

    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        let newLength = (textField.text?.count)! + string.count - range.length
        return !(newLength > 40)
    }
    
    func setApplyButton(){
        
        applyButton.makeRounded(cornerRadius: 25)
        applyButton.backgroundColor = .softGreen
        
        
    }

    @objc func updateTextLength(){
        textNum = themeNameTextField.text?.count
        textQuantityLabel.text = String(textNum!)+"/40"
        partialGreenColor()
        
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
                self.applyButton.transform =
                    CGAffineTransform(translationX: 0, y: -(keyboardSize.height-34))
            })
            self.view.layoutIfNeeded()
        
        
    }
    }
    
    @objc func keyboardWillHide(_ notification: NSNotification) {
        guard let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey]
            as? Double else {return}
        guard let curve = notification.userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey]
            as? UInt else {return}
        
        UIView.animate(withDuration: duration, delay: 0.0, options: .init(rawValue: curve),
                       animations: {
            self.applyButton.transform = .identity
        })
        
        self.view.layoutIfNeeded()
    }
        
    
    // MARK:- IBAction Functions
    
    @IBAction func resetTextQuantity(_ sender: UITextField) {
        textNum = themeNameTextField.text?.count
       
        textQuantityLabel.text = String(textNum!)+"/40"
        partialGreenColor()
        
    }
    @IBAction func applyButtonAction(_ sender: Any) {
        if themeNameTextField.text?.count == 0{
            
            
        }
        
        
        
    }
    

    
    @IBAction func xButtonisTapped(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
        
    }
    
    
   
}



extension WritingThemeVC : UICollectionViewDelegate, UICollectionViewDataSource,
UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int)
        -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath)
        -> UICollectionViewCell {
            guard let themeCell = collectionView.dequeueReusableCell(
                withReuseIdentifier: ThemeMakeImagesCVC.identifier,
                for: indexPath) as? ThemeMakeImagesCVC else {
         
                return UICollectionViewCell()}
           
            let check : Bool = indexPath.item == checkIndex
            themeCell.setItems(images[indexPath.item], check)
          
            themeCell.makeRounded(cornerRadius: 10)
            return themeCell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {

        return CGSize(width : 77, height: 77 )
    }
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        checkIndex = indexPath.item
     
        
        self.themeCollectionView.reloadData()
        
        
        
    }
    
    
}

