//
//  SearchResultCuratorVC.swift
//  Mongle
//
//  Created by 이예슬 on 7/8/20.
//  Copyright © 2020 이주혁. All rights reserved.
//

import UIKit

class SearchResultCuratorVC: UIViewController {
    var searchKey = ""
    var curatorList : [SearchCuratorData] = []
    //MARK:- IBOutlet
    @IBOutlet weak var curatorCollectionView: UICollectionView!
    @IBOutlet weak var noCuratorView: UIView!
    
    //MARK:- LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        curatorCollectionView.delegate = self
        curatorCollectionView.dataSource = self

        
    }
    override func viewWillAppear(_ animated: Bool) {
        setSearchCuratorData(searchKey)
        
    }
    
    func setSearchCuratorData(_ searchKey: String){
        SearchCuratorService.shared.search(words:searchKey) { networkResult in
            switch networkResult {
            case .success(let searchResult):
                guard let data = searchResult as? [SearchCuratorData] else {
                    return
                }
                
                self.curatorList = data
                print("최근검색어: \(data)")
                DispatchQueue.main.async {
                    self.curatorCollectionView.reloadData()
                    if self.curatorList.count == 0{
                        self.noCuratorView.isHidden = false
                    }
                    else{
                        self.noCuratorView.isHidden = true
                    }
                }
                
                
            case .requestErr(let message):
                
                guard let message = message as? String else { return }
                
                self.showToast(text: message)
                print(message)
            case .pathErr:
                
                print("path")
            case .serverErr:
                print("serverErr")
            case .networkFail:
                print("networkFail")
            }
        
        }
      
    }
    
    
}
extension SearchResultCuratorVC: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        
        let headerview =  collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "SearchResultCuratorHeaderView", for: indexPath) as! SearchResultCuratorHeaderView
        headerview.headerViewLabel.text
            = "검색된 큐레이터 \(curatorList.count)명"
        return headerview
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        guard let curatorInfoVC = UIStoryboard(name:"CuratorTabInfo",bundle:nil).instantiateViewController(identifier: "CuratorTabInfoVC") as? CuratorTabInfoVC else{
            return
        }
        curatorInfoVC.curatorIdx = curatorList[indexPath.item].curatorIdx
        self.navigationController?.pushViewController(curatorInfoVC, animated: true)
    }
}
extension SearchResultCuratorVC: UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return curatorList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CuratorListCVC", for: indexPath) as? CuratorListCVC else{ return CuratorListCVC()}
        
        cell.curatorNameLabel.text = curatorList[indexPath.item].name
        cell.subscriberNum = curatorList[indexPath.item].subscribe
        cell.curatorProfileImageView.imageFromUrl(curatorList[indexPath.item].img, defaultImgPath: "maengleCharacters")
        cell.subscribeBTN.isSelected = curatorList[indexPath.item].alreadySubscribed
        cell.curatorIdx = curatorList[indexPath.item].curatorIdx
        cell.subscriberLabel.text = "구독자 \(curatorList[indexPath.item].subscribe)명"
        if curatorList[indexPath.item].alreadySubscribed{
            cell.subscribeBTN.backgroundColor = .veryLightPinkSeven
        }
        else{
            cell.subscribeBTN.backgroundColor = .softGreen
        }
    
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

