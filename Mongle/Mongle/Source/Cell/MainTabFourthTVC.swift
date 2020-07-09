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

    let themas = ["가나다라마바사아자차", "가나다라마바사아자차", "가나다라마바사아자차"]
    
    @IBOutlet var popularThemaCollectionview: UICollectionView! {
        didSet {
            popularThemaCollectionview.delegate = self
            popularThemaCollectionview.dataSource = self
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}

extension MainTabFourthTVC: UICollectionViewDelegate {
    
}

extension MainTabFourthTVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        themas.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainPopularThemaCVC.identifier, for: indexPath) as? MainPopularThemaCVC else {
            return UICollectionViewCell()
        }
        
        cell.blurStyle = .blue
        
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


