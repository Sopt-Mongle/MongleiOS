//
//  MainTabFirstTVC.swift
//  Mongle
//
//  Created by 이주혁 on 2020/07/06.
//  Copyright © 2020 이주혁. All rights reserved.
//

import UIKit

class MainTabFirstTVC: UITableViewCell {
    static let identifier = "MainTabFirstTVC"
    
    // MARK:- @IBOutlet
    @IBOutlet var mainDisplayPictureCollectionView: UICollectionView!
    
    // MARK:- Property
    let pictures = ["mongleCharacters", "mongleCharacters", "mongleCharacters"]
    
    // MARK:- Override Method
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        mainDisplayPictureCollectionView.delegate = self
        mainDisplayPictureCollectionView.dataSource = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
}


//
extension MainTabFirstTVC: UICollectionViewDelegate {
    
}

extension MainTabFirstTVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return pictures.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainPictureCVC.identifier, for: indexPath) as? MainPictureCVC else {
            return UICollectionViewCell()
        }
        cell.displayPictureImageView.image = UIImage(named: pictures[indexPath.item])
//        cell.backgroundColor = .blue
        return cell
    }
}

extension MainTabFirstTVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: collectionView.bounds.height)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        <#code#>
//    }
//
}
