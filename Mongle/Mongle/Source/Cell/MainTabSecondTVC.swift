//
//  MainTabSecondTVC.swift
//  Mongle
//
//  Created by 이주혁 on 2020/07/06.
//  Copyright © 2020 이주혁. All rights reserved.
//

import UIKit

class MainTabSecondTVC: UITableViewCell {
    static let identifier = "MainTabSecondTVC"
    
    @IBOutlet var todaySentenceCollectionView: UICollectionView!
    
    let sentences = ["가나다라", "마바사아자차카타파하"]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

extension MainTabSecondTVC: UICollectionViewDelegate {
    
}
extension MainTabSecondTVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sentences.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        <#code#>
    }
}
