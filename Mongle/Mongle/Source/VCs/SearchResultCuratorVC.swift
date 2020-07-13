//
//  SearchResultCuratorVC.swift
//  Mongle
//
//  Created by 이예슬 on 7/8/20.
//  Copyright © 2020 이주혁. All rights reserved.
//

import UIKit

class SearchResultCuratorVC: UIViewController {
    var searchKey = "스리"
    
    @IBOutlet weak var curatorCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        curatorCollectionView.delegate = self
        curatorCollectionView.dataSource = self
        
        // Do any additional setup after loading the view.
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
extension SearchResultCuratorVC: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
       
       //ofKind에 UICollectionView.elementKindSectionHeader로 헤더를 설정해주고
       //withReuseIdentifier에 헤더뷰 identifier를 넣어주고
       //생성한 헤더뷰로 캐스팅해준다.
       let headerview =  collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "SearchResultCuratorHeaderView", for: indexPath) as! SearchResultCuratorHeaderView
    
       return headerview
    }
}
extension SearchResultCuratorVC: UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CuratorListCVC", for: indexPath) as? CuratorListCVC else{ return CuratorListCVC()}
        
        cell.curatorNameLabel.text = "예스리"
        
        cell.curatorInfoLabel.text = "대학내일"
        let text = cell.curatorNameLabel.text
        
        
        let attributedString = NSMutableAttributedString(string: cell.curatorNameLabel.text!)
        attributedString.addAttribute(NSAttributedString.Key.foregroundColor,
                                      value: UIColor.softGreen,
                                      range: (text as! NSString).range(of: searchKey))
        cell.curatorNameLabel.attributedText = attributedString
        
        return cell
    }
    
    
}
extension SearchResultCuratorVC: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 375, height: 120)
    }
    //cell content inset 지정
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    //cell 상 하 간격 지정
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    //cell 좌 우 간격 지정
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

