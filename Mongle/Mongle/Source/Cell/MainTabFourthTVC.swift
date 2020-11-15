//
//  MainTabFourthTVC.swift
//  Mongle
//
//  Created by 이주혁 on 2020/07/07.
//  Copyright © 2020 이주혁. All rights reserved.
//

import UIKit



class MainTabFourthTVC: UITableViewCell {
    
    static let idnetifier = "MainTabFourthTVC"

    @IBOutlet var popularThemaCollectionview: UICollectionView! {
        didSet {
            popularThemaCollectionview.delegate = self
            popularThemaCollectionview.dataSource = self
        }
    }
    
    var themas: [MainThemeData] = []
    let topInset: CGFloat = 21
    let horizonInset: CGFloat = 16
    let bottomInset: CGFloat = 38
    var selectedCell: ((_ viewController: UIViewController) -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
    }
}

extension MainTabFourthTVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let theme = self.themas[indexPath.item]
        
        
        
        guard let dvc = UIStoryboard(name: "ThemeInfo", bundle: nil).instantiateViewController(identifier: "ThemeInfoVC") as? ThemeInfoVC else {
            return
        }
        dvc.themeIdx = theme.themeIdx
        
        if let delegate = selectedCell {
            delegate(dvc)
        }
    }
}

extension MainTabFourthTVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.themas.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainPopularThemaCVC.identifier, for: indexPath) as? MainPopularThemaCVC else {
            return UICollectionViewCell()
        }
        
        let theme = self.themas[indexPath.item]
        cell.setData(name: theme.theme, count: theme.sentenceNum, imageUrl: theme.themeImg, isBookMark: false)
        
        return cell
    }
}

extension MainTabFourthTVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.bounds.width - horizonInset - 33) / 2
        let height = collectionView.bounds.height - topInset - bottomInset
        
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: topInset, left: horizonInset, bottom: bottomInset, right: horizonInset)
    }
}
