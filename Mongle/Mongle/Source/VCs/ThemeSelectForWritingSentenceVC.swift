//
//  ThemeSelectForWritingSentenceVC.swift
//  Mongle
//
//  Created by Yunjae Kim on 2020/07/10.
//  Copyright © 2020 이주혁. All rights reserved.
//

import UIKit
import Then
import SnapKit

class ThemeSelectForWritingSentenceVC: UIViewController {
    
    //MARK:- IBOutlet
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var themeTextField: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var selectButton: UIButton!
    @IBOutlet weak var themeCollectionView: UICollectionView!
    @IBOutlet weak var warningImageView: UIImageView!
    @IBOutlet weak var warningLabel: UILabel!
    
    
    @IBOutlet weak var blurView: UIImageView!
    @IBOutlet weak var collectionViewConstraint: NSLayoutConstraint!
    
    
    
    //MARK:- User Define Variables
    var themes : [ThemeForSentence] = []
    var searchKeyWord : String?
    var checkIndex : Int = -1
    var isSearched : Bool = false
    var searchResultLabel = UILabel().then {
        $0.text = "검색결과"
        $0.alpha = 0
    }
    
    var resultQuantityLabel = UILabel().then {
        $0.alpha = 0
        $0.text = "총"
    }
    
    var emptyImageView = UIImageView().then {
        $0.image = UIImage(named : "writingSentenceBook4EmptyImgMongle")
        
    }
    
    var emptyLabel1 = UILabel().then {
        $0.text = "검색 결과가 없습니다."
        $0.font = $0.font.withSize(16)
        $0.textColor = .black
        
        
    }
    var emptyLabel2 = UILabel().then {
        $0.text = "다른 키워드로 검색해보세요!"
        $0.font = $0.font.withSize(13)
        $0.textColor = .veryLightPink
        
    }
    var isWarning : Bool = false
    var themeDelegate : ThemeSendDelegate?
    
    var shouldBeHidden : Bool = false
    
    //MARK:- LifeCycleMethods
    override func viewDidLoad() {
        
        super.viewDidLoad()
        setItems()
        
        setWarning()
        themeCollectionView.dataSource = self
        themeCollectionView.delegate = self
        setThemes()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        registerForKeyboardNotifications()
    }
    override func viewWillDisappear(_ animated: Bool) {
        checkIndex = -1
        unregisterForKeyboardNotifications()
    }
    

   
    //MARK:- User Define Functions
    func setItems(){
        backButton.setImage(UIImage(named: "searchBtnBack")?.withRenderingMode(.alwaysOriginal), for: .normal)
        searchButton.setImage(UIImage(named: "searchBtnSearch")?.withRenderingMode(.alwaysOriginal), for: .normal)
        selectButton.backgroundColor = .softGreen
        selectButton.makeRounded(cornerRadius: 25)
        selectButton.setTitleColor(.white, for: .normal)
        
        themeTextField.placeholder = "테마를 검색해주세요"
        themeTextField.addLeftPadding(left: 10)
        
        blurView.image = UIImage(named: "writingSentenceTheme2BoxBlur")?.withRenderingMode(.alwaysOriginal)
        
        //themeCollectionView.backgroundColor = .clear
        
    }
    
    func setWarning(){
        
        warningImageView.image = UIImage(named: "warning")
        warningLabel.textColor = .reddish
        warningImageView.alpha = 0
        warningLabel.alpha = 0
        
        
        
    }
    
    func showEmpty(){
        self.view.addSubview(emptyImageView)
        self.view.addSubview(emptyLabel1)
        self.view.addSubview(emptyLabel2)
        
        emptyImageView.snp.makeConstraints{
            $0.top.equalToSuperview().offset(372)
            $0.leading.equalToSuperview().offset(155)
            $0.width.equalTo(65)
            $0.height.equalTo(70)
        }
        emptyLabel1.snp.makeConstraints{
            $0.top.equalToSuperview().offset(457)
            $0.leading.equalToSuperview().offset(121)
        }
        
        emptyLabel2.snp.makeConstraints{
            $0.top.equalToSuperview().offset(482)
            $0.leading.equalToSuperview().offset(117)
        }
        hideWarning()
        themeCollectionView.isHidden = true
        resultQuantityLabel.alpha = 0
        searchResultLabel.alpha = 0
        
        
        
    }
    
    
    func showWarning(){
        print(isSearched)
        warningLabel.alpha = 1
        warningImageView.alpha = 1
        
        if isSearched == true{
        
            
            collectionViewConstraint.constant = 73
            searchResultLabel.snp.remakeConstraints{
                $0.leading.equalToSuperview().offset(17)
                $0.top.equalToSuperview().offset(187)
                
            }
                
            resultQuantityLabel.snp.remakeConstraints {
                $0.top.equalToSuperview().offset(188)
                $0.trailing.equalToSuperview().offset(-15)
            }
            
        }
        else{
            collectionViewConstraint.constant = 49
            

            
        }

        
    }
    func hideWarning(){
        warningLabel.alpha = 0
        warningImageView.alpha = 0
        
        if isSearched {
            collectionViewConstraint.constant = 48
        }
        else {
            collectionViewConstraint.constant = 24
        }
        
        
    }
    
    func setThemes(){
        let theme1 = ThemeForSentence(imgName: "writingSentenceTheme3ImgThemeX", themeTitle: "테마 없는 문장",state : true)
        let theme2 = ThemeForSentence(imgName: "mainImgTheme2", themeTitle: "번아웃을 극복하고 싶을 때 봐야하는 문장",state : true)
        let theme3 = ThemeForSentence(imgName: "mainImgTheme2", themeTitle: "브랜딩이 어려울 때 영감을 주는 문장",state : true)
        let theme4 = ThemeForSentence(imgName: "mainImgTheme2", themeTitle: "번아웃을 극복하고 싶을 때 봐야하는 문장",state : true)
        let theme5 = ThemeForSentence(imgName: "mainImgTheme2", themeTitle: "브랜딩이 어려울 때 영감을 주는 문장",state : true)
        let theme7 = ThemeForSentence(imgName: "mainImgTheme2", themeTitle: "번아웃을 극복하고 싶을 때 봐야하는 문장",state : true)
        let theme8 = ThemeForSentence(imgName: "mainImgTheme2", themeTitle: "번아웃을 극복하고 싶을 때 봐야하는 문장",state : true)
        let theme9 = ThemeForSentence(imgName: "mainImgTheme2", themeTitle: "번아웃을 극복하고 싶을 때 봐야하는 문장",state : true)
        let theme10 = ThemeForSentence(imgName: "mainImgTheme2", themeTitle: "번아웃을 극복하고 싶을 때 봐야하는 문장",state : true)
        
        themes = [theme1,theme2,theme3,theme4,theme5,theme7,theme8,theme9,theme10]
        
    }
    func partialGreenColor(textField : UITextField, keyword : String){
        
        guard let text = textField.text else {
            return
        }
        textField.textColor = .black
        let attributedString = NSMutableAttributedString(string: textField.text!)
        attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.softGreen,
                                      range: (text as NSString).range(of: keyword))
        textField.attributedText = attributedString
    }
    
    @IBAction func backButtonAction(_ sender: Any) {
        themeDelegate?.sendTheme(themeText: "", isSelected: false, fromAfter: true)
        dismiss(animated: true, completion: nil)
    }
    func hideEmpty(){
        emptyLabel2.removeFromSuperview()
        emptyLabel1.removeFromSuperview()
        emptyImageView.removeFromSuperview()
        
        
    }
    
    @IBAction func searchButtonAction(_ sender: Any) {
        
        if themeTextField.text == "으악" {
            shouldBeHidden = true
            themeCollectionView.reloadData()
            showEmpty()
            self.view.endEditing(true)
        }
        else{
            
            hideEmpty()
            
            searchKeyWord = themeTextField.text
            
            isSearched = true
            setResultLabels()
            shouldBeHidden = false
            
            
            
            themeCollectionView.reloadData()
            
            self.view.endEditing(true)
        }
        

        
    }
    
    func setResultLabels(){
        
        self.view.addSubview(searchResultLabel)
        self.view.addSubview(resultQuantityLabel)
        
        searchResultLabel.text = "'" + themeTextField.text! + "'검색결과"
        guard let text = searchResultLabel.text else {
            return
        }
        searchResultLabel.textColor = .softGreen
        let attributedString = NSMutableAttributedString(string: searchResultLabel.text!)
        attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.greyishBrownTwo,
                                      range: (text as NSString).range(of: "검색결과"))
        searchResultLabel.attributedText = attributedString
        searchResultLabel.font = searchResultLabel.font.withSize(13)
        
        resultQuantityLabel.font = resultQuantityLabel.font.withSize(13)
        
        
        resultQuantityLabel.text = "총 10건"
        resultQuantityLabel.textColor = .veryLightPink
        
        
        if isWarning{
            collectionViewConstraint.constant = 73
            searchResultLabel.snp.makeConstraints {
                $0.leading.equalToSuperview().offset(17)
                $0.top.equalToSuperview().offset(187)
            }
            
            resultQuantityLabel.snp.makeConstraints {
                $0.top.equalToSuperview().offset(188)
                $0.trailing.equalToSuperview().offset(-15)
            }
            
        }
        else{
            collectionViewConstraint.constant = 48
            searchResultLabel.snp.makeConstraints {
                $0.leading.equalToSuperview().offset(17)
                $0.top.equalToSuperview().offset(162)
            }
            
            resultQuantityLabel.snp.makeConstraints {
                $0.top.equalToSuperview().offset(163)
                $0.trailing.equalToSuperview().offset(-15)
            }
        }
       
        
       
        
        searchResultLabel.alpha = 1
        resultQuantityLabel.alpha = 1
        
        
        
    }
    
   
    
    
    @IBAction func selectButtonAction(_ sender: Any) {
        if checkIndex == -1{
            isWarning = true
            showWarning()
            
        }
        else{
            
            dismiss(animated: true, completion: nil)
        }
      
    

        
        
        
        
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
        self.themeCollectionView.isHidden = true
        
     
    }
    
    @objc func keyboardWillHide(_ notification: NSNotification) {
   
        self.themeCollectionView.isHidden = false
    }
    
    
    
}

extension ThemeSelectForWritingSentenceVC : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if shouldBeHidden{
            return 0
        }
        
        return themes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath)
        -> UICollectionViewCell {
            guard let themeCell = collectionView.dequeueReusableCell(withReuseIdentifier: ThemeSelectForSentenceCVC.identifier, for: indexPath) as? ThemeSelectForSentenceCVC else {
                
                return UICollectionViewCell()}
            
            let check : Bool = indexPath.item == checkIndex
        
        
            themeCell.setItems(themes[indexPath.item], self.themeTextField.text!,check)
            themeCell.makeRounded(cornerRadius: 22)
            
            return themeCell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        return CGSize(width : 166, height: 166 )
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 11
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 11
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
 
        
        themeDelegate?.sendTheme(themeText: themes[indexPath.item].themeTitle,
                                 isSelected: true, fromAfter: true)
        hideWarning()
        isWarning = true
        checkIndex = indexPath.item
        
        if isSearched {
            searchResultLabel.snp.remakeConstraints{
                $0.top.equalToSuperview().offset(162)
                $0.leading.equalToSuperview().offset(17)
                
            }
            resultQuantityLabel.snp.remakeConstraints{
                $0.top.equalToSuperview().offset(163)
                $0.trailing.equalToSuperview().offset(-15)
            }
            
            
        }
       
        self.themeCollectionView.reloadData()
        //collectionView.reloadData()
    }
    
    
}







