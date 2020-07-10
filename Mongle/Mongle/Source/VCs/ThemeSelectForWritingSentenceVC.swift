//
//  ThemeSelectForWritingSentenceVC.swift
//  Mongle
//
//  Created by Yunjae Kim on 2020/07/10.
//  Copyright © 2020 이주혁. All rights reserved.
//

import UIKit

class ThemeSelectForWritingSentenceVC: UIViewController {
    
    //MARK:- IBOutlet
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var themeTextField: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var selectButton: UIButton!
    @IBOutlet weak var themeCollectionView: UICollectionView!
    
    
    
    //MARK:- User Define Variables
    var themes : [ThemeForSentence] = []
    var searchKeyWord : String?
    
    
    //MARK:- LifeCycleMethods
    override func viewDidLoad() {
        
        super.viewDidLoad()
        setItems()
       
        themeCollectionView.dataSource = self
        themeCollectionView.delegate = self
        setThemes()
        // Do any additional setup after loading the view.
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
        
        
        //themeCollectionView.backgroundColor = .clear
        
    }
    
    func setThemes(){
        let theme1 = ThemeForSentence(imgName: "mainImgTheme2", themeTitle: "기분이 우울할 때 위로가 되는 문장")
        let theme2 = ThemeForSentence(imgName: "mainImgTheme2", themeTitle: "번아웃을 극복하고 싶을 때 봐야하는 문장")
        let theme3 = ThemeForSentence(imgName: "mainImgTheme2", themeTitle: "브랜딩이 어려울 때 영감을 주는 문장")
        let theme4 = ThemeForSentence(imgName: "mainImgTheme2", themeTitle: "번아웃을 극복하고 싶을 때 봐야하는 문장")
        let theme5 = ThemeForSentence(imgName: "mainImgTheme2", themeTitle: "브랜딩이 어려울 때 영감을 주는 문장")
        let theme6 = ThemeForSentence(imgName: "mainImgTheme2", themeTitle: "번아웃을 극복하고 싶을 때 봐야하는 문장")
        
        themes = [theme1,theme2,theme3,theme4,theme5,theme6]
        
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
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func searchButtonAction(_ sender: Any) {
        searchKeyWord = themeTextField.text
       
        for j in 0...themeCollectionView.numberOfItems(inSection: 0) - 1
        {
            if let cell = themeCollectionView.cellForItem(at: NSIndexPath(row: j, section: 0) as IndexPath) {
                                
            }
            
        }
     
     
        
    }
    
    
}

extension ThemeSelectForWritingSentenceVC : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return themes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath)
        -> UICollectionViewCell {
            print("1")
            guard let themeCell = collectionView.dequeueReusableCell(withReuseIdentifier: ThemeSelectForSentenceCVC.identifier, for: indexPath) as? ThemeSelectForSentenceCVC else {
                
                return UICollectionViewCell()}
            themeCell.setItems(themes[indexPath.row])
            
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
        ThirdViewOfWritingSentenceVC.fromAfterView = true
        ThirdViewOfWritingSentenceVC.textViewInput = themes[indexPath.row].themeTitle
        dismiss(animated: true, completion: nil)
    }
    
    
}







