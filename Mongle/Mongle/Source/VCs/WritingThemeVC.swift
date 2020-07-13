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
    
    @IBOutlet weak var warningImageView: UIImageView!
    @IBOutlet weak var warningLabel: UILabel!
    @IBOutlet weak var labelConstraints: NSLayoutConstraint!
    
    @IBOutlet weak var warningImageView2: UIImageView!
    @IBOutlet weak var warningLabel2: UILabel!
    
    
    var theme : String?
    
    
    // MARK:- Class Variables
    var textNum : Int?
    
    var images = ["mainImgTheme2","mainImgTheme2","mainImgTheme2","mainImgTheme2","mainImgTheme2",
                  "mainImgTheme2","mainImgTheme2","mainImgTheme2","mainImgTheme2","mainImgTheme2"]
  
    var checkIndex : Int = -1
    
    let blurView = UIView().then{
        $0.backgroundColor = .blur1
//        $0.alpha = 0
        
    }
    
    let popupView = UIView().then {
        $0.backgroundColor = .white
    }
    

    let popUpImageView = UIImageView().then {
        $0.image = UIImage(named: "mainImgTheme2")?.withRenderingMode(.alwaysOriginal)
    }
    
    
    let popUpThemeLabel = UILabel().then {
        $0.textColor = .white
        $0.font = $0.font.withSize(18)
//        $0.alpha = 0
        $0.numberOfLines = 0
    
        
    }
    
    let popUpAskingLabel = UILabel().then {
        $0.textColor = .black
        $0.font = $0.font.withSize(15)
        $0.text = "테마를 등록하시겠어요?"
//        $0.alpha = 0
       
         
        
    }
    let popUpNoticeLabel = UILabel().then {
        $0.textColor = .brownGreyThree
        $0.numberOfLines = 0
//        $0.alpha = 0
        $0.textAlignment = .center
        $0.font = $0.font.withSize(13)
        $0.text = "테마는 한 번 등록하면\n수정 및 삭제를 할 수 없어요!"
        
        
    }
    
    let yesButton = UIButton(type: .custom).then {
        $0.backgroundColor = .white
        $0.setTitleColor(.softGreen, for: .normal)
        $0.setTitle("네", for: .normal)
        $0.setBorder(borderColor: .softGreen, borderWidth: 1.0)
        $0.addTarget(self, action: #selector(yesButtonDidTap), for: .touchUpInside)
        
    }
    let noButton = UIButton().then {
        $0.backgroundColor = .white
        $0.setTitleColor(.softGreen, for: .normal)
        $0.setTitle("아니요", for: .normal)
        $0.setBorder(borderColor: .softGreen, borderWidth: 1.0)
        $0.addTarget(self, action: #selector(noButtonTap), for: .touchUpInside)
    }
    
    
    // MARK:- LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        themeNameTextField.delegate = self
      
        themeCollectionView.delegate = self
        themeCollectionView.dataSource = self
        setItems()
        
        
        
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
    @objc func noButtonTap(){
        for view in popupView.subviews {
            view.removeFromSuperview()
        }
        popupView.removeFromSuperview()
        blurView.removeFromSuperview()
        
        
        
    }
    
    @objc func yesButtonDidTap(){
        yesButton.backgroundColor = .softGreen
        yesButton.setTitleColor(.white, for: .normal)
        
        guard let vcName = UIStoryboard(name: "EndOfMakingTheme",
                                        bundle: nil).instantiateViewController(
                                            withIdentifier: "EndOfMakingThemeVC") as? EndOfMakingThemeVC
            else{
                return
        }
        
        vcName.modalPresentationStyle = .fullScreen
        
        self.present(vcName, animated: true, completion: nil)
                
        
    }
    
    func setItems(){
        setThemeNameTextField()
        setApplyButton()
        textQuantityLabel.text = "0/40"
        warningImageView.image = UIImage(named: "warning")?.withRenderingMode(.alwaysOriginal)
        warningLabel.text = "테마 이름을 적어주세요!"
        warningLabel.textColor = .reddish
        warningLabel.alpha = 0
        warningImageView.alpha = 0
        themeNameTextField.makeRounded(cornerRadius: 10)
    
        warningImageView2.image = UIImage(named: "warning")?.withRenderingMode(.alwaysOriginal)
        warningLabel2.text = "테마 배경 이미지를 선택해주세요!"
        warningLabel2.textColor = .reddish
        warningLabel2.alpha = 0
        warningImageView2.alpha = 0
        
        
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
        
        
    }
    
    func setPopUp(){
        
        self.view.addSubview(blurView)
        self.view.addSubview(popupView)
        popupView.addSubview(popUpImageView)
        
        
        blurView.snp.makeConstraints{
            $0.top.bottom.leading.trailing.equalToSuperview()
        }
        
        popupView.snp.makeConstraints{
            $0.top.equalToSuperview().offset(233)
            $0.leading.equalToSuperview().offset(36)
            $0.trailing.equalToSuperview().offset(-35)
            $0.bottom.equalToSuperview().offset(-229.2)
            
        }
        
        
        popupView.addSubview(popUpThemeLabel)
        popupView.addSubview(popUpAskingLabel)
        popupView.addSubview(popUpNoticeLabel)
        popupView.addSubview(yesButton)
        popupView.addSubview(noButton)

        
        popUpImageView.snp.makeConstraints{
            $0.top.equalToSuperview().offset(46)
            $0.bottom.equalToSuperview().offset(-175.8)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            
        }
      
        popUpThemeLabel.snp.makeConstraints{
            $0.leading.equalToSuperview().offset(27)
            $0.top.equalToSuperview().offset(73)
            $0.trailing.equalToSuperview().offset(-27)
        }
        
        popUpThemeLabel.text = themeNameTextField.text!
        
        popUpAskingLabel.snp.makeConstraints{
            $0.leading.equalToSuperview().offset(83)
            $0.top.equalToSuperview().offset(200)
            $0.trailing.equalToSuperview().offset(83)
        }
        popUpNoticeLabel.snp.makeConstraints{
            $0.top.equalToSuperview().offset(228)
            $0.centerX.equalToSuperview()
        }
        
        yesButton.snp.makeConstraints{
            $0.top.equalToSuperview().offset(288)
            $0.leading.equalToSuperview().offset(20)
            $0.width.equalTo(127)
            $0.height.equalTo(37)
            
        }

        yesButton.makeRounded(cornerRadius: 17)
       
        
        
        noButton.snp.makeConstraints{
            $0.trailing.equalToSuperview().offset(-16)
            $0.top.equalToSuperview().offset(288)
            $0.width.equalTo(127)
            $0.height.equalTo(37)
        }
         noButton.makeRounded(cornerRadius: 17)
        
        

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
        textQuantityLabel.alpha = 1
        setThemeNameTextField()
        warningLabel.alpha = 0
        warningImageView.alpha = 0
        labelConstraints.constant = 62
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
        self.view.endEditing(true)

        if themeNameTextField.text == "" {
            warningLabel.alpha = 1
            warningImageView.alpha = 1
            textQuantityLabel.alpha = 0
            themeNameTextField.setBorder(borderColor: .reddish, borderWidth: 1.0)
            labelConstraints.constant = 87
        }
        else if checkIndex == -1 {
            warningImageView2.alpha = 1
            warningLabel2.alpha = 1
            
        }
            
        else {
            setPopUp()
            
            popUpThemeLabel.text = themeNameTextField.text
            
        }
        
        
        
//        self.yesButton.isUserInteractionEnabled = true
//        self.popUpView.transform = CGAffineTransform(translationX: 0, y: 500)
//
//        UIView.animate(withDuration: 1.0,delay: 0.0, animations: {
//
//
//
//            self.popUpView.transform = .identity
//        })
        
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
        warningLabel2.alpha = 0
        warningImageView2.alpha = 0
        checkIndex = indexPath.item
     
        
        self.themeCollectionView.reloadData()
        
        
        
    }
    
    
}

