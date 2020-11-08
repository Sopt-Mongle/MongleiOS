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
    
    let topInset:CGFloat = 21.0
    let leadingInset: CGFloat = 16.0
    let bottomInset: CGFloat = 38.0
    
//    let sentences = ["결국 봄이 언제나 찾아왔지만, 하마터면 오지않을 뻔했던 봄을 생각하면 마음이 섬찟해진다. ", "결국 봄이 언제나 찾아왔지만, 하마터면 오지않을 뻔했던 봄을 생각하면 마음이 섬찟해진다. "]
    var sentences: [TodaySentenceData] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        todaySentenceCollectionView.delegate = self
        todaySentenceCollectionView.dataSource = self
        
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
        cell.setData(sentence: "sad", bookName: "asd")
        return cell
    }
}

extension MainTabSecondTVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width - leadingInset - 60, height: collectionView.bounds.height - topInset - bottomInset)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: topInset,
                            left: leadingInset,
                            bottom: bottomInset,
                            right: leadingInset)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
}


