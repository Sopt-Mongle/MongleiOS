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
    
    
    let themas = ["브랜딩이 어려울 때영감을 주는 문장", "번아웃을 극복하고 싶을 때 봐야하는 문장문장", "가나다라마바사아자차"]
    var selectedCell: ((_ viewController: UIViewController) -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
    }
}

extension MainTabFourthTVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let dvc = UIStoryboard(name: "ThemeInfo", bundle: nil).instantiateViewController(identifier: "ThemeInfoVC") as? ThemeInfoVC else {
            return
        }
        dvc.themeText = themas[indexPath.item]
        if let delegate = selectedCell {
            delegate(dvc)
        }
    }
}

extension MainTabFourthTVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        themas.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainPopularThemaCVC.identifier, for: indexPath) as? MainPopularThemaCVC else {
            return UICollectionViewCell()
        }
        cell.themaNameLabel.text = themas[indexPath.item]
        
        return cell
    }
}

extension MainTabFourthTVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 159, height: 159)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 16, bottom: 43, right: 16)
    }
}
