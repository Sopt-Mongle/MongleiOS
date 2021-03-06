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
    @IBOutlet var pageCollectionView: UICollectionView!
    
    
    // MARK:- Property
    var counts:[Int] = [10,0,4]
    
    var pageViewWidth : Int = 0
    var displayIndex: Int = 0
    var displayCell =  UICollectionViewCell()
    
    var editorData: [EditorPickData] = []
    
    var selectedCellDelegate: ((UIViewController) -> Void) = { _ in }

    
    // MARK:- Override Method
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        
        mainDisplayPictureCollectionView.delegate = self
        mainDisplayPictureCollectionView.dataSource = self
        pageCollectionView.delegate = self
        pageCollectionView.dataSource = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
    }
    
    
}


//MARK:- Extension
//MARK: UICollectionViewDelegate
extension MainTabFirstTVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if collectionView == mainDisplayPictureCollectionView {
            guard let dvc = UIStoryboard(name: "ThemeInfo", bundle: nil).instantiateViewController(identifier: "ThemeInfoVC") as? ThemeInfoVC else {
                return
            }
            dvc.themeIdx = self.editorData[indexPath.row].themeIdx
            selectedCellDelegate(dvc)
        }
    }
}
//MARK: UICollectionViewDataSource
extension MainTabFirstTVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return editorData.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == mainDisplayPictureCollectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainPictureCVC.identifier, for: indexPath) as? MainPictureCVC else {
                return UICollectionViewCell()
            }
            let editor = editorData[indexPath.item]
            cell.displayPictureImageView.imageFromUrl(editor.illust)
            
            cell.themeNameLabel.text = editor.theme
            cell.themeCountLabel.text = "문장 \(editor.sentenceNum)개"
            
            
            return cell
        }
        else if collectionView == pageCollectionView {
            if displayIndex == indexPath.item {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "displayCell", for: indexPath)
                cell.backgroundColor = .softGreen
                cell.makeRounded(cornerRadius: cell.frame.width / 4 - 1.5)
                return cell
            }
            else {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "undisplayCell", for: indexPath)
                cell.makeRounded(cornerRadius: cell.frame.width / 2)
                cell.backgroundColor = UIColor(red: 239 / 255, green: 249 / 255, blue: 239 / 255, alpha: 1.0)
                
                return cell
            }
        }
        else {
            return UICollectionViewCell()
        }
    }
}
//MARK: UICollectionViewDelegateFlowLayout
extension MainTabFirstTVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if collectionView == self.mainDisplayPictureCollectionView {
            return CGSize(width: collectionView.bounds.width,
                          height: collectionView.bounds.height)
            
            
        }
        else if collectionView == self.pageCollectionView {
            if displayIndex == indexPath.item {
                return CGSize(width: 19, height: 7)
            }
            else {
                return CGSize(width: 7, height: 7)
            }
        }
        else {
            return CGSize()
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == self.mainDisplayPictureCollectionView {
            return 0
        }
        else {
            return 7
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == self.mainDisplayPictureCollectionView {
            return 0
        }
        else {
            return 7
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if collectionView == self.mainDisplayPictureCollectionView {
            return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }
        else {
            pageViewWidth = (editorData.count - 1) * 7 + 19 + (editorData.count - 1) * 7
            let left = CGFloat(collectionView.bounds.width) - CGFloat(self.pageViewWidth)

            return UIEdgeInsets(top: 0, left: left / 2, bottom: 0, right: left / 2)
        }
    }
    
}

//MARK: UIScrollViewDelegate
extension MainTabFirstTVC: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if scrollView == self.mainDisplayPictureCollectionView {
            self.displayIndex = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
            self.pageCollectionView.reloadData()
        }
    }
}
