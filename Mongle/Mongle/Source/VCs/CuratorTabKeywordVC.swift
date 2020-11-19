//
//  CuratorTabKeyword.swift
//  Mongle
//
//  Created by 이예슬 on 7/13/20.
//  Copyright © 2020 이주혁. All rights reserved.
//

import UIKit

class CuratorTabKeywordVC: UIViewController {
    
    var selectedKeyword:String?
    var keywordIdx:Int = 0
    var curatorList : [CuratorKeywordData] = []
    @IBOutlet weak var keywordTitleLabel: UILabel!
    @IBOutlet weak var naviView: UIView!
    @IBAction func touchUpBackBTN(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBOutlet weak var curatorListCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        curatorListCollectionView.delegate = self
        curatorListCollectionView.dataSource = self
        keywordTitleLabel.text = selectedKeyword
        
    }
    override func viewWillAppear(_ animated: Bool) {
        setCuratorList()
    }
    
    func setCuratorList(){
        print(self.keywordIdx)
        CuratorKeywordService.shared.getKeyword(keywordIdx: self.keywordIdx+1){ networkResult in
            switch networkResult {
            case .success(let recommend):
                guard let data = recommend as? [CuratorKeywordData] else {
                    return
                }
                
                self.curatorList = data
                print("추천 큐레이터: \(data)")
                DispatchQueue.main.async {
                    self.curatorListCollectionView.reloadData()
                    
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
    func showNaviShadow(){
        naviView.dropShadow(color: .black, offSet: CGSize(width: 0, height: 3), opacity: 0.04, radius: 6)
    }
    func hideNaviShadow(){
        naviView.layer.shadowOpacity = 0
    }

    

}
extension CuratorTabKeywordVC: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let curatorInfoVC = UIStoryboard(name:"CuratorTabInfo",bundle:nil).instantiateViewController(identifier: "CuratorTabInfoVC") as? CuratorTabInfoVC else{
            return
        }
        curatorInfoVC.curatorIdx = curatorList[indexPath.item].curatorIdx
        self.navigationController?.pushViewController(curatorInfoVC, animated: true)
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let y = scrollView.contentOffset.y
        if y>0{
            showNaviShadow()
        }
        else{
            hideNaviShadow()
        }
    }
    
}
extension CuratorTabKeywordVC: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return curatorList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CuratorListCVC", for: indexPath) as? CuratorListCVC else{
            return UICollectionViewCell()
        }
        cell.myVC = self
        cell.curatorProfileImageView.imageFromUrl(curatorList[indexPath.item].img, defaultImgPath: "sentenceThemeOImgCurator1010")
        cell.curatorNameLabel.text = curatorList[indexPath.item].name
        cell.curatorInfoLabel.text = curatorList[indexPath.item].introduce
        cell.curatorIdx = curatorList[indexPath.item].curatorIdx
        cell.subscriberLabel.text = "구독자 \(curatorList[indexPath.item].subscribe)명"
        if curatorList[indexPath.item].alreadySubscribed{
            cell.subscribeBTN.isSelected = true
            cell.subscribeBTN.backgroundColor = .veryLightPinkSeven
        }
        else{
            cell.subscribeBTN.isSelected = false
            cell.subscribeBTN.backgroundColor = .softGreen
        }
        return cell
    }
    
    
}
extension CuratorTabKeywordVC: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let devicewidth = UIScreen.main.bounds.width
        return CGSize(width: devicewidth, height: devicewidth/375*120)
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
