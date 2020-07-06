//
//  SearchTabMainVC.swift
//  Mongle
//
//  Created by 이예슬 on 7/3/20.
//  Copyright © 2020 이주혁. All rights reserved.
//

import UIKit

class SearchTabMainVC: UIViewController {
    
    var recentKeyArray : [String] = ["최근","검색어","테스트중","몽글","알러뷰"]
    // MARK:- IBOutlet
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var stringCounter: UILabel!
    @IBOutlet weak var recentSearchCV: UICollectionView!
    @IBOutlet weak var recommendSearchCV: UICollectionView!
    
    @IBAction func removeSearchHistoryBTN(_ sender: Any) {
        recentKeyArray = []
        recentSearchCV.reloadData()
    }
    
    // MARK:- LifeCycle Method
    override func viewDidLoad() {
        super.viewDidLoad()
        //recentSearchCV.delegate = self
        recentSearchCV.dataSource = self
        
        //searchTextField.delegate = self
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        searchTextField.becomeFirstResponder()
    }
    
    
    
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
        let count = recentKeyArray.count
        if count == 0 {
            return 1
        }
        else{
            return recentKeyArray.count
        }

    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecentSearchCVC", for: indexPath) as? RecentSearchCVC else {
            return RecentSearchCVC()
        }
        let count = recentKeyArray.count
        if count == 0{
            cell.setBorder(borderColor: .clear, borderWidth: 0)
            cell.recentSearchKeyLabel.textColor = .lightGray
            cell.setRecent(key: "최근 검색어가 없습니다.")
        }
        else{
            cell.layer.cornerRadius = cell.bounds.width/3 + 3.5
            cell.setBorder(borderColor: .softGreen, borderWidth: 1)
            cell.recentSearchKeyLabel.textColor = .softGreen
            cell.setRecent(key: recentKeyArray[indexPath.item])
        }
        return cell
   
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
