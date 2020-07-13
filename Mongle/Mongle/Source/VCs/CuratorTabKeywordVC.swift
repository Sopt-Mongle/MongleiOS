//
//  CuratorTabKeyword.swift
//  Mongle
//
//  Created by 이예슬 on 7/13/20.
//  Copyright © 2020 이주혁. All rights reserved.
//

import UIKit

class CuratorTabKeywordVC: UIViewController {
    
    var selectedKeyword:String?
    @IBOutlet weak var keywordTitleLabel: UILabel!
    @IBAction func touchUpBackBTN(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBOutlet weak var curatorListCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        curatorListCollectionView.delegate = self
        curatorListCollectionView.dataSource = self
        keywordTitleLabel.text = selectedKeyword
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension CuratorTabKeywordVC: UICollectionViewDelegate{
    
}
extension CuratorTabKeywordVC: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CuratorListCVC", for: indexPath) as? CuratorListCVC else{
            return UICollectionViewCell()
        }
        return cell
    }
    
    
}
extension CuratorTabKeywordVC: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 375, height: 120)
    }
    //cell content inset 지정
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    //cell 상 하 간격 지정
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    //cell 좌 우 간격 지정
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
