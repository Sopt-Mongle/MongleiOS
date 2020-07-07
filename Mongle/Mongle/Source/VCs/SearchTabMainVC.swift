//
//  SearchTabMainVC.swift
//  Mongle
//
//  Created by 이예슬 on 7/3/20.
//  Copyright © 2020 이주혁. All rights reserved.
//

import UIKit

class SearchTabMainVC: UIViewController{
    
    var recentKeyArray : [String] = ["최근","검색어","테스트중","몽글","알러뷰"]
    var recommendKeyArray : [String] = ["에세이","몽글","테마","큐레이터","몽골","오늘저녁또떡"]
    var searchKey : String?
    // MARK:- IBOutlet
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var stringCounter: UILabel!
    @IBOutlet weak var recentSearchCV: UICollectionView!
    @IBOutlet weak var recommendSearchCV: UICollectionView!
    @IBOutlet weak var searchBTN: UIButton!
    

    @IBAction func touchUpSearchBTN(_ sender: Any) {
        //searchKey = searchTextField.text
        if searchTextField.hasText{
            searchKey = searchTextField.text
            if recentKeyArray.contains(searchKey!){
                let length = recentKeyArray.count
                for idx in 0..<length {
                    if recentKeyArray[idx] == searchKey{
                        recentKeyArray.remove(at:idx)
                        break
                    }
                }
            }
            recentKeyArray.insert(searchKey!,at: 0)
            recentSearchCV.reloadData()
            
        }
        searchTextField.text = ""
        
        
        
    }
    @IBAction func removeSearchHistoryBTN(_ sender: Any) {
        recentKeyArray = []
        recentSearchCV.reloadData()
    }
    
    // MARK:- LifeCycle Method
    override func viewDidLoad() {
        super.viewDidLoad()
        recentSearchCV.delegate = self
        recentSearchCV.dataSource = self
        recommendSearchCV.delegate = self
        recommendSearchCV.dataSource = self
        
        //recommendSearchCV.collectionViewLayout = LeftAlignedCollectionViewFlowLayout()
        //UserDefaults.standard.s
        //searchTextField.delegate = self
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        searchTextField.becomeFirstResponder()
    }
//
//    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
//        let attributes = super.layoutAttributesForElements(in: rect)
//
//        var leftMargin = sectionInset.left
//        var maxY: CGFloat = -1.0
//        attributes?.forEach { layoutAttribute in
//            if layoutAttribute.frame.origin.y >= maxY {
//                leftMargin = sectionInset.left
//            }
//
//            layoutAttribute.frame.origin.x = leftMargin
//
//            leftMargin += layoutAttribute.frame.width + minimumInteritemSpacing
//            maxY = max(layoutAttribute.frame.maxY , maxY)
//        }
//
//        return attributes
//    }
    
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}

//extension SearchTabMainVC: UITextFieldDelegate{
//    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//        let strLength = textField.text?.count ?? 0
//        //print(strLength)
//        let lngthToAdd = string.count
//        //print(lngthToAdd)
//        let lengthCount = strLength + lngthToAdd
//        self.stringCounter.text = "\(lengthCount)"
//        return true
//    }
//
//}
extension SearchTabMainVC : UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (collectionView == recentSearchCV){
            let count = recentKeyArray.count
            if count == 0 {
                return 1
            }
            else{
                return recentKeyArray.count
            }
        }
        else{
            return recommendKeyArray.count
        }
        

    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == recentSearchCV{
            guard let recentCell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecentSearchCVC", for: indexPath) as? RecentSearchCVC else {
                return RecentSearchCVC()
            }
            let count = recentKeyArray.count
            if count == 0{
                recentCell.setBorder(borderColor: .clear, borderWidth: 0)
                recentCell.recentSearchKeyLabel.textColor = .lightGray
                recentCell.setRecent(key: "최근 검색어가 없습니다.")
            }
            else{
                //recentCell.layer.cornerRadius = recentCell.bounds.width/3 + 3.5
                recentCell.setBorder(borderColor: .softGreen, borderWidth: 1)
                recentCell.recentSearchKeyLabel.textColor = .softGreen
                recentCell.setRecent(key: recentKeyArray[indexPath.item])
            }
            return recentCell
        }
        else{
            guard let recommendCell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecommendSearchCVC", for: indexPath) as? RecommendSearchCVC else {
                return RecommendSearchCVC()
            }
            let count = recommendKeyArray.count
            if count == 0{
                recommendCell.setBorder(borderColor: .clear, borderWidth: 0)
                recommendCell.recommendSearchKeyLabel.textColor = .lightGray
                recommendCell.setRecommend(key: "추천 검색어가 없습니다.")
            }
            else{
                recommendCell.layer.cornerRadius = recommendCell.bounds.width/3 + 3.5
                recommendCell.backgroundColor = .ice
                recommendCell.recommendSearchKeyLabel.textColor = .tea
                recommendCell.setRecommend(key: recommendKeyArray[indexPath.item])
            }
            return recommendCell
        }
    
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == recentSearchCV{
            let cell = collectionView.cellForItem(at: indexPath) as? RecentSearchCVC
            searchTextField.text = cell?.recentSearchKeyLabel.text
            touchUpSearchBTN(self.searchBTN)
            
        }
        else{
            let cell = collectionView.cellForItem(at: indexPath) as? RecommendSearchCVC
            searchTextField.text = cell?.recommendSearchKeyLabel.text
            touchUpSearchBTN(self.searchBTN)
        }
    }

    
    
//    func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
//        let attributes = self.layoutAttributesForElements(in: rect)
//
//        var leftMargin = sectionInset.left
//        var maxY: CGFloat = -1.0
//        attributes?.forEach { layoutAttribute in
//            if layoutAttribute.frame.origin.y >= maxY {
//                leftMargin = sectionInset.left
//            }
//
//            layoutAttribute.frame.origin.x = leftMargin
//
//            leftMargin += layoutAttribute.frame.width + minimumInteritemSpacing
//            maxY = max(layoutAttribute.frame.maxY , maxY)
//        }
//
//        return attributes
//    }
//        layout
}

//class LeftAlignedCollectionViewFlowLayout: UICollectionViewFlowLayout {
//
//    override public func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
//
//        // We may not change the original layout attributes
//        // or UICollectionViewFlowLayout might complain.
//        let layoutAttributesObjects = copy(super.layoutAttributesForElements(in: rect))
//
//        layoutAttributesObjects?.forEach({ (layoutAttributes) in
//            if layoutAttributes.representedElementCategory == .cell { // Do not modify header views etc.
//                let indexPath = layoutAttributes.indexPath
//                // Retrieve the correct frame from layoutAttributesForItem(at: indexPath):
//                if let newFrame = layoutAttributesForItem(at: indexPath)?.frame {
//                    layoutAttributes.frame = newFrame
//                }
//            }
//        })
//
//        return layoutAttributesObjects
//    }
//    private func copy(_ layoutAttributesArray: [UICollectionViewLayoutAttributes]?) -> [UICollectionViewLayoutAttributes]? {
//        return layoutAttributesArray?.map{ $0.copy() } as? [UICollectionViewLayoutAttributes]
//    }
//}
//

