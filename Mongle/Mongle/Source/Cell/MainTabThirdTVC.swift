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
    
}

extension MainTabThirdTVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return curators.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainPopularCuratorCVC.identifier, for: indexPath) as? MainPopularCuratorCVC else {
            return UICollectionViewCell()
        }
        let curator = self.curators[indexPath.item]
        cell.setData(imgUrl: curator.img ?? "themeImgCurator", name: curator.name, tag: curator.keyword ?? " ")
        return cell
    }

}

extension MainTabThirdTVC: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 96, height: 135)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 16, bottom: 16, right: 16)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

