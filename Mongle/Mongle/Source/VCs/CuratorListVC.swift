//
//  CuratorListVC.swift
//  Mongle
//
//  Created by 이예슬 on 7/7/20.
//  Copyright © 2020 이주혁. All rights reserved.
//

import UIKit

class CuratorListVC: UIViewController {
    var curatorInfoList : [[String]] = [["봄","대학내일 | 인생회고"],["예슬","아예일까 | 디예일까"],["래리유","빵쟁이 | 동현"],["아요","아요짱 | 아요러브"],["메롱","배고파 | 죽겠어"],["메롱","배고파 | 죽겠어"],["메롱","배고파 | 죽겠어"],["메롱","배고파 | 죽겠어"],["메롱","배고파 | 죽겠어"]]
    // MARK:- IBOutlet
    @IBOutlet weak var curatorListCV: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        curatorListCV.delegate = self
        curatorListCV.dataSource = self
        // Do any additional setup after loading the view.
    }
    


}
// MARK:- Extensions
extension CuratorListVC : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return curatorInfoList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CuratorListCVC", for: indexPath) as? CuratorListCVC else{ return CuratorListCVC()}
        cell.curatorNameLabel.text = curatorInfoList[indexPath.item][0]
        cell.curatorInfoLabel.text = curatorInfoList[indexPath.item][1]
        
        return cell
    }
    
    //flow layout
    //cell width height 지정
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
