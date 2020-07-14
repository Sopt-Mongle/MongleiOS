//
//  CuratorTabMainVC.swift
//  Mongle
//
//  Created by 이예슬 on 7/13/20.
//  Copyright © 2020 이주혁. All rights reserved.
//

import UIKit

class CuratorTabMainVC: UIViewController {
    
    var keywordList:[String] = ["감성자극","동기부여","자기계발","깊은생각","독서기록","일상문장"]
    
    //MARK:- IBOutlet
    @IBOutlet weak var curatorTabTableView: UITableView!
    @IBOutlet weak var popularCollectionView: UICollectionView!
    @IBOutlet var keywordBTN: [UIButton]!
    
    @IBAction func touchKeywordBTN(_ sender: UIButton) {
        guard let keywordVC = UIStoryboard(name:"CuratorTabKeyword",bundle:nil).instantiateViewController(identifier: "CuratorTabKeywordVC") as? CuratorTabKeywordVC else {
            return
            
        }
        print(#function)
        print(sender.tag)
        keywordVC.selectedKeyword = keywordList[sender.tag]
        self.navigationController?.pushViewController(keywordVC, animated: true)
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        curatorTabTableView.delegate = self
        curatorTabTableView.dataSource = self
        popularCollectionView.delegate = self
        popularCollectionView.dataSource = self
        var idx = 0
        for btn in keywordBTN{
            btn.setTitle(keywordList[idx], for: .normal)
            btn.setTitleColor(.brownGrey, for: .normal)
            btn.titleLabel?.font = UIFont.systemFont(ofSize: 13)
            btn.tag = idx
            idx += 1
//            btn.setBorder(borderColor: .brownGrey, borderWidth: 1)
            //btn.backgroundColor = .white
            btn.setBackgroundImage(UIImage(named:"curatorBtnKeyword1"), for: .normal)
            
            
            
        }
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

extension CuratorTabMainVC: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
extension CuratorTabMainVC: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CuratorTabMainTVC", for: indexPath) as? CuratorTabMainTVC else{ return UITableViewCell()}
        cell.selectSentenceDelegate = { [weak self] dvc in
            self?.navigationController?.pushViewController(dvc, animated: true)
        }
        return cell
        
    }
    
    
}

//popularCollectionViewCell
extension CuratorTabMainVC: UICollectionViewDelegate{
    
}
extension CuratorTabMainVC: UICollectionViewDelegateFlowLayout{
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
extension CuratorTabMainVC: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MainPopularCuratorCVC", for: indexPath) as? MainPopularCuratorCVC else{ return UICollectionViewCell() }
        cell.profileNameLabel.text = "이예슬"
//        cell.profileImageView.image = UIImage(named:"maengleCharacters")
//        cell.profileImageView.backgroundColor = .yellow
        
        return cell
    }
    
    
}

//

