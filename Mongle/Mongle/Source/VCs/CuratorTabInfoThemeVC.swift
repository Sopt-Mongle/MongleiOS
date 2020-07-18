//
//  curatorInfoThemeVC.swift
//  Mongle
//
//  Created by 이예슬 on 7/15/20.
//  Copyright © 2020 이주혁. All rights reserved.
//

import UIKit

class CuratorTabInfoThemeVC: UIViewController {
    var themeList :[CuratorTheme]=[]
    var curatorIdx = -1
    // MARK: - Outlet
    @IBOutlet weak var themeTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        themeTableView.delegate = self
        themeTableView.dataSource = self
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        getCuratorData()
        
    }
    func getCuratorData(){
        print(curatorIdx)
        CuratorInfoService.shared.getCuratorInfo(curatorIdx: self.curatorIdx){ networkResult in
            switch networkResult {
            case .success(let curatorInfo):
                guard let data = curatorInfo as? CuratorInfoData else {
                    return
                }
                self.themeList = data.theme
                
                print("herere")
                
                print("큐레이터 정보: \(data)개")
                
                DispatchQueue.main.async {
                    self.themeTableView.reloadData()
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
}

extension CuratorTabInfoThemeVC: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let themeVC = UIStoryboard(name:"ThemeInfo",bundle:nil).instantiateViewController(identifier: "ThemeInfoVC") as? ThemeInfoVC else{
            return
        }
        themeVC.themeIdx = self.themeList[indexPath.row].themeIdx
        self.navigationController?.pushViewController(themeVC, animated: true)
    }
    
}
extension CuratorTabInfoThemeVC: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.themeList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = themeTableView.dequeueReusableCell(withIdentifier: "searchResultThemeTVC",
                                                            for: indexPath) as? SearchResultThemeTVC else { return UITableViewCell() }
        cell.themeTitleLabel.text = themeList[indexPath.item].theme
        cell.themeInfoLabel.text = "\(themeList[indexPath.item].saves) | 문장 \(themeList[indexPath.item].sentenceNum)개"
        
        return cell
    }
    
}
