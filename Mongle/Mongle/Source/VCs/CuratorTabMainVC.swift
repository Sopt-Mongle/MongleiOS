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
    var popularList:[CuratorRecommendData] = []
    var themeList:[CuratorTabTheme] = []
    let refreshControl = UIRefreshControl()
    //MARK:- IBOutlet
    @IBOutlet weak var naviView: UIView!
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
        keywordVC.keywordIdx = sender.tag + 1
        self.navigationController?.pushViewController(keywordVC, animated: true)
        
        
    }
    //MARK: - LifeCycle Methods
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
            btn.backgroundColor = .white
            idx += 1
            
        }
        curatorTabTableView.contentInset.bottom = 60
        curatorTabTableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        
    }
    override func viewWillAppear(_ animated: Bool) {
        setRecommendedCurator()
        setThemeInCurator()
    }
    func setRecommendedCurator(){
        CuratorRecommendService.shared.getRecommend(){ networkResult in
            switch networkResult {
            case .success(let recommend):
                guard let data = recommend as? [CuratorRecommendData] else {
                    return
                }
                
                self.popularList = data
                print("추천 큐레이터: \(data)")
                DispatchQueue.main.async {
                    self.popularCollectionView.reloadData()
                    
                }
                
                
            case .requestErr(let message):
                
                guard let message = message as? String else { return }
                
                self.showToast(text: message)
                print(message)
            case .pathErr:
                
                print("path")
            case .serverErr:
                print("serverErr")
            case .networkFail:
                print("networkFail")
            }
            
        }
        
    }
    func setThemeInCurator(){
        ThemeInCuratorService.shared.getCurator(){
            networkResult in
            switch networkResult {
            case .success(let theme):
                guard let data = theme as? ThemeInCuratorData else {
                    return
                }
                
                self.themeList = data.theme
                print("테마 속 큐레이터: \(data)")
                DispatchQueue.main.async {
                    self.curatorTabTableView.reloadData()
                }
                
                
            case .requestErr(let message):
                
                guard let message = message as? String else { return }
                
                self.showToast(text: message)
                print(message)
            case .pathErr:
                
                print("path")
            case .serverErr:
                print("serverErr")
            case .networkFail:
                print("networkFail")
            }
        }
    }
    func showNaviShadow(){
        naviView.dropShadow(color: .black, offSet: CGSize(width: 0, height: 7), opacity: 0.04, radius: 6)
    }
    func hideNaviShadow(){
        naviView.layer.shadowOpacity = 0
    }
    
    @objc func refresh(){
        setRecommendedCurator()
        setThemeInCurator()
        self.refreshControl.endRefreshing()
    }

}
// MARK: - UITableViewDelegate
extension CuratorTabMainVC: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let y = scrollView.contentOffset.y
        if y>0{
            showNaviShadow()
        }
        else{
            hideNaviShadow()
        }
    }
}
extension CuratorTabMainVC: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return themeList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CuratorTabMainTVC", for: indexPath) as? CuratorTabMainTVC else{ return UITableViewCell()}
        cell.curatorList = self.themeList[indexPath.row].curators
        cell.selectSentenceDelegate = { [weak self] dvc in
            self?.navigationController?.pushViewController(dvc, animated: true)
        }
        cell.count = self.themeList[indexPath.row].curatorNum
        cell.themeTitleLabel.text = self.themeList[indexPath.row].theme
        cell.themeTitleImageView.imageFromUrl(self.themeList[indexPath.row].themeImg, defaultImgPath: "mainImgTheme1")
        cell.themeCuratorCountLabel.text = "큐레이터 \(self.themeList[indexPath.row].curatorNum)명"
        cell.curatorListCollectionView.reloadData()
        cell.myVC = self
        return cell
        
    }
    
    
}
// MARK: - UICollectionViewDelegate
//popularCollectionViewCell
extension CuratorTabMainVC: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let curatorInfoVC = UIStoryboard(name:"CuratorTabInfo",bundle:nil).instantiateViewController(identifier: "CuratorTabInfoVC") as? CuratorTabInfoVC else{
            return
        }
        curatorInfoVC.curatorIdx = popularList[indexPath.item].curatorIdx
        self.navigationController?.pushViewController(curatorInfoVC, animated: true)
    }
    
    
}
extension CuratorTabMainVC: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 96, height: 135)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
extension CuratorTabMainVC: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return popularList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MainPopularCuratorCVC", for: indexPath) as? MainPopularCuratorCVC else{ return UICollectionViewCell() }
        cell.setData(imgUrl: self.popularList[indexPath.item].img ?? "", name: self.popularList[indexPath.item].name, tag: self.popularList[indexPath.item].keyword ?? "동기부여")

        
        return cell
    }
    
    
}



