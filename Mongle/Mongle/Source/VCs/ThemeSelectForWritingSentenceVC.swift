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
    
    
    //MARK:- LifeCycleMethods
    override func viewDidLoad() {
        
        super.viewDidLoad()
        setItems()
       
        themeCollectionView.dataSource = self
        themeCollectionView.delegate = self
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
        
        
    }
    
    func setThemes(){
        let theme1 = ThemeForSentence(imgName: "mainImgTheme2", themeTitle: "몽글몽글몽글몽글몽글몽글몽글몽글몽글몽글몽글")
        let theme2 = ThemeForSentence(imgName: "mainImgTheme2", themeTitle: "몽글몽글몽글몽글몽글몽글몽글몽글몽글몽글몽글")
        let theme3 = ThemeForSentence(imgName: "mainImgTheme2", themeTitle: "몽글몽글몽글몽글몽글몽글몽글몽글몽글몽글몽글")
        let theme4 = ThemeForSentence(imgName: "mainImgTheme2", themeTitle: "몽글몽글몽글몽글몽글몽글몽글몽글몽글몽글몽글")
        let theme5 = ThemeForSentence(imgName: "mainImgTheme2", themeTitle: "몽글몽글몽글몽글몽글몽글몽글몽글몽글몽글몽글")
        let theme6 = ThemeForSentence(imgName: "mainImgTheme2", themeTitle: "몽글몽글몽글몽글몽글몽글몽글몽글몽글몽글몽글")
        
        themes = [theme1,theme2,theme3,theme4,theme5,theme6]
        
    }
    
    
    @IBAction func backButtonAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}

extension ThemeSelectForWritingSentenceVC : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return themes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath)
        -> UICollectionViewCell {
     
            guard let themeCell = collectionView.dequeueReusableCell(withReuseIdentifier: ThemeSelectForSentenceCVC.identifier, for: indexPath) as? ThemeSelectForSentenceCVC else {
                
                return UICollectionViewCell()}
            themeCell.setItems(themes[indexPath.row])
            
            return themeCell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        return CGSize(width : (collectionView.frame.width-40)/2, height: collectionView.frame.height/3 )
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
}







