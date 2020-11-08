//
//  MainTabThirdTVC.swift
//  Mongle
//
//  Created by 이주혁 on 2020/07/07.
//  Copyright © 2020 이주혁. All rights reserved.
//

import UIKit

class MainTabThirdTVC: UITableViewCell {
    static let identifier = "MainTabThirdTVC"

    @IBOutlet var popularCuratorCollectionView: UICollectionView!
    
//    let curators = ["예슬", "주혁", "윤재", "윤재", "윤재", "윤재"]
    var curators: [MainCuratorData] = []
    var cellSelectDelegate: ((UIViewController)->Void) = { _ in }
    
    let topInset: CGFloat = 10
    let horizonInset: CGFloat = 16
    let bottomInset: CGFloat = 25
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        popularCuratorCollectionView.delegate = self
        popularCuratorCollectionView.dataSource = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
    }
}

extension MainTabThirdTVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let curator = self.curators[indexPath.item]
//        guard let dvc = UIStoryboard(name: "CuratorTabInfo", bundle: nil).instantiateViewController(identifier: "CuratorTabInfoVC") as? CuratorTabInfoVC else {
//            return
//        }
//        dvc.curatorIdx = curator.curatorIdx
//        cellSelectDelegate(dvc)
        
    }
}

extension MainTabThirdTVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return curators.count
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainPopularCuratorCVC.identifier, for: indexPath) as? MainPopularCuratorCVC else {
            return UICollectionViewCell()
        }
//        let curator = self.curators[indexPath.item]
//        cell.setData(imgUrl: curator.img ?? "themeImgCurator", name: curator.name, tag: curator.keyword ?? " ")
        return cell
    }

}

extension MainTabThirdTVC: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.bounds.width - horizonInset) / 4
        let height = collectionView.bounds.height - topInset - bottomInset
        
        return CGSize(width:  width,
                      height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: topInset,
                            left: horizonInset,
                            bottom: bottomInset,
                            right: horizonInset)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

