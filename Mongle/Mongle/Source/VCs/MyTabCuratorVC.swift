//
//  MyTabCuratorVC.swift
//  Mongle
//
//  Created by 이예슬 on 7/15/20.
//  Copyright © 2020 이주혁. All rights reserved.
//

import UIKit
import SnapKit

class MyTabCuratorVC: UIViewController {
    
    var myCuratorList : [MyCuratorData] = []
    //MARK:- IBOutlet
    @IBOutlet weak var curatorListCollectionView: UICollectionView!
    
    //MARK: - LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        curatorListCollectionView.delegate = self
        curatorListCollectionView.dataSource = self

    }
    override func viewWillAppear(_ animated: Bool) {
        setMyCurator()
    }
    
    //MARK: - Custom Methods
    func setMyCurator(){
        MyCuratorService.shared.getMy(){ networkResult in
            
            switch networkResult {
            case .success(let theme):
                guard let data = theme as? [MyCuratorData] else {
                    return
                }
                print("성공")
                self.myCuratorList = data
                print("내 프로필 테마: \(data)")
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

}
extension MyTabCuratorVC: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let curatorInfoVC = UIStoryboard(name:"CuratorTabInfo",bundle:nil).instantiateViewController(identifier: "CuratorTabInfoVC") as? CuratorTabInfoVC else{
            return
        }
        curatorInfoVC.curatorIdx = myCuratorList[indexPath.item].curatorIdx
        self.navigationController?.pushViewController(curatorInfoVC, animated: true)
    }
    
}
extension MyTabCuratorVC: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return myCuratorList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CuratorListCVC", for: indexPath) as? CuratorListCVC else{
            return UICollectionViewCell()
        }
        cell.myVC = self
        cell.curatorProfileImageView.imageFromUrl(myCuratorList[indexPath.item].img, defaultImgPath: "sentenceThemeOImgCurator1010")
        cell.curatorNameLabel.text = myCuratorList[indexPath.item].name
        cell.subscriberNum = myCuratorList[indexPath.item].subscribe
        cell.curatorProfileImageView.imageFromUrl(myCuratorList[indexPath.item].img, defaultImgPath: "sentenceThemeOImgCurator1010")
        cell.subscribeBTN.isSelected = myCuratorList[indexPath.item].alreadySubscribed
        cell.curatorIdx = myCuratorList[indexPath.item].curatorIdx
        cell.subscriberLabel.text = "구독자 \(myCuratorList[indexPath.item].subscribe)명"
        cell.curatorInfoLabel.text = myCuratorList[indexPath.item].introduce
        if myCuratorList[indexPath.item].alreadySubscribed{
            cell.subscribeBTN.backgroundColor = .veryLightPinkSeven
        }
        else{
            cell.subscribeBTN.backgroundColor = .softGreen
        }
        return cell
    }
    
    
}
extension MyTabCuratorVC: UICollectionViewDelegateFlowLayout{
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
