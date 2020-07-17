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
    
    var selectSentenceDelegate: ((_ viewControllers: UIViewController) -> ()) = { _ in }
    
//    let sentences = ["결국 봄이 언제나 찾아왔지만, 하마터면 오지않을 뻔했던 봄을 생각하면 마음이 섬찟해진다. ", "결국 봄이 언제나 찾아왔지만, 하마터면 오지않을 뻔했던 봄을 생각하면 마음이 섬찟해진다. "]
    var sentences: [TodaySentenceData] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        todaySentenceCollectionView.delegate = self
        todaySentenceCollectionView.dataSource = self
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
    }

}

extension MainTabSecondTVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let dvc = UIStoryboard.init(name: "SentenceInfo", bundle: nil).instantiateViewController(identifier: "SentenceInfoVC") as? SentenceInfoVC else {
            return
        }
        dvc.sentenceIdx = self.sentences[indexPath.item].sentenceIdx
        dvc.isMySentence = false
        selectSentenceDelegate(dvc)
    }
}
extension MainTabSecondTVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sentences.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainTodaySentenceCVC.identifier, for: indexPath) as? MainTodaySentenceCVC else {
            return UICollectionViewCell()
        }
        let sentence = sentences[indexPath.item]
        cell.setData(sentence: sentence.sentence, bookName: sentence.title)
        return cell
    }
}

extension MainTabSecondTVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 299, height: 125)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 7, left: 16, bottom: 26, right: 16)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
}


