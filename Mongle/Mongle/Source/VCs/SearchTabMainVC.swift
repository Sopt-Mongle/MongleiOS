//
//  SearchTabMainVC.swift
//  Mongle
//
//  Created by 이예슬 on 7/3/20.
//  Copyright © 2020 이주혁. All rights reserved.
//
import UIKit

class SearchTabMainVC: UIViewController{
    
    var prevIdx: Int?
    var recentKeyArray : [String] = []
    var recommendKeyArray : [String] = []
    var searchKey : String?
    
    // MARK:- IBOutlet
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var recentSearchCV: UICollectionView!
    @IBOutlet weak var recommendSearchCV: UICollectionView!
    @IBOutlet weak var searchBTN: UIButton!
    
    // MARK:- LifeCycle Method
    override func viewDidLoad() {
        super.viewDidLoad()
        searchTextField.delegate = self
        recentSearchCV.delegate = self
        recentSearchCV.dataSource = self
        recommendSearchCV.delegate = self
        recommendSearchCV.dataSource = self
        
        initGestureRecognizer()
        setCollctionViewLayout()
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        self.navigationController?.hidesBottomBarWhenPushed = false
        
    }
    override func viewWillAppear(_ animated: Bool) {
        searchTextField.becomeFirstResponder()
        setRecentSearchData()
        setRecommendSearchData()
    }
    func setCollctionViewLayout(){
        let alignedFlowLayout = AlignedCollectionViewFlowLayout(horizontalAlignment: .left, verticalAlignment: .top)
        alignedFlowLayout.minimumLineSpacing = 8
        alignedFlowLayout.minimumInteritemSpacing = 8
        alignedFlowLayout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        alignedFlowLayout.estimatedItemSize = CGSize(width: 71, height: 37)
        recommendSearchCV.collectionViewLayout = alignedFlowLayout
        

    }
    
    func setRecentSearchData(){
        SearchMainService.shared.getRecentSearch() { networkResult in
            switch networkResult {
            case .success(let searchKeys):
                guard let data = searchKeys as? [String] else {
                    return
                }
                
                self.recentKeyArray = data
        
                DispatchQueue.main.async {
                    self.recentSearchCV.reloadData()
                }

                
            case .requestErr(let message):
            
                guard let message = message as? String else { return }
                self.simpleAlert(title: "error", message: message)
                self.showToast(text: message)
                print("ㅁㅁ\(message)")
            case .pathErr:
                
                print("ㅁㅁpath")
            case .serverErr:
                 print("ㅁㅁserverErr")
            case .networkFail:
                print("ㅁㅁnetworkFail")
            }
                
            
        }
    }
    func setRecommendSearchData(){
        SearchMainService.shared.getRecommendSearch() { networkResult in
            switch networkResult {
            case .success(let searchKeys):
                guard let data = searchKeys as? [String] else {
                    return
                }
                
                self.recommendKeyArray = data
                print("ㅁㅁㅁㅁㅁ추천검색어\(data)ㅁㅁㅁㅁㅁ")
                DispatchQueue.main.async {
                    self.recommendSearchCV.reloadData()
                }

                
            case .requestErr(let message):
            
                guard let message = message as? String else { return }
                self.simpleAlert(title: "error", message: message)
                self.showToast(text: message)
                print("ㅁㅁ\(message)")
            case .pathErr:
                
                print("ㅁㅁpath")
            case .serverErr:
                 print("ㅁㅁserverErr")
            case .networkFail:
                print("ㅁㅁnetworkFail")
            }
                
            
        }
    }
    func deleteRecentSearch(){
        SearchMainService.shared.deleteRecentSearch() { networkResult in
            switch networkResult {
            case .success(let message):
                print("qqqqqqqqqqq\(message)")
                guard let message = message as? String else { return }
//                self.showToast("최근 검색어가 전체삭제 되었어요!")
                print(message)
                self.recentKeyArray = []
                self.recentSearchCV.reloadData()
                //self.setRecentSearchData()
                
                
                
            case .requestErr(let message):
            
                guard let message = message as? String else { return }
                self.simpleAlert(title: "error", message: message)
                self.showToast(text: message)
                print("ㅁㅁ\(message)")
            case .pathErr:
                
                print("ㅁㅁpath")
            case .serverErr:
                 print("ㅁㅁserverErr")
            case .networkFail:
                print("ㅁㅁnetworkFail")
            }
                
            
        }
    }
    
    //MARK:- Set Gesture
    func initGestureRecognizer() {
        let textFieldTap = UITapGestureRecognizer(target: self, action: #selector(handleTapTextField(_:)))
        textFieldTap.delegate = self
        self.view.addGestureRecognizer(textFieldTap)
    }

    // 다른 위치 탭했을 때 키보드 없어지는 코드
    @objc func handleTapTextField(_ sender: UITapGestureRecognizer) {
        self.searchTextField.resignFirstResponder()
    }

    @objc func keyboardWillHide(_ notification: NSNotification) {
        guard let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double else {return}
        guard let curve = notification.userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey] as? UInt else {return}
    }
    // MARK:- register/unregister Notification Observer
    // observer
    func registerForKeyboardNotifications() {

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    
    func unregisterForKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    // MARK:- IBAction
    @IBAction func touchUpSearchBTN(_ sender: Any) {
        //searchKey = searchTextField.text
        if searchTextField.hasText{
            searchKey = searchTextField.text ?? ""
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
        
        let sb = UIStoryboard.init(name: "SearchTabResult", bundle: nil)
        if let dvc = sb.instantiateViewController(identifier: "searchTabResultVC") as? SearchTabResultVC {
            dvc.searchKeyword = self.searchKey ?? "실패"
//            dvc.hidesBottomBarWhenPushed = false
            self.navigationController?.pushViewController(dvc, animated: true)
        }
        
        
    }
    @IBAction func touchUpBack(_ sender: Any) {
//        self.navigationController?.popViewController(animated: true)
//        self.showToast(text: "뒤로가기")
        self.tabBarController?.selectedIndex = prevIdx!
    }
    @IBAction func removeSearchHistoryBTN(_ sender: Any) {
        deleteRecentSearch()
    }
    
}

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
//                recommendCell.layer.cornerRadius = recommendCell.bounds.width/3 + 3.5
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
            if (recentKeyArray.count != 0){
                searchTextField.text = cell?.recentSearchKeyLabel.text
                
                touchUpSearchBTN(self.searchBTN)
            }
            
        }
        else{
            let cell = collectionView.cellForItem(at: indexPath) as? RecommendSearchCVC
            searchTextField.text = cell?.recommendSearchKeyLabel.text
            touchUpSearchBTN(self.searchBTN)
        }
        
    }
    
}
//MARK:- UIGestureRecognizerDelegate Extension
//여기는 제스쳐 인식 제외하는거 false로 해줌
extension SearchTabMainVC: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestrueRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if (touch.view?.isDescendant(of: self.searchTextField))! || (touch.view?.isDescendant(of: self.recentSearchCV))! || (touch.view?.isDescendant(of: self.recommendSearchCV))!{

            return false
        }
        return true
    }
}


extension SearchTabMainVC: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
//        self.touchUpSearchBTN(self.searchBTN)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.touchUpSearchBTN(self.searchBTN)
        
        
        return true
    }
}
