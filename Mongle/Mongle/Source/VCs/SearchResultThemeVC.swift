//
//  SearchResultThemeVC.swift
//  Mongle
//
//  Created by 이예슬 on 7/8/20.
//  Copyright © 2020 이주혁. All rights reserved.
//

import UIKit

class SearchResultThemeVC: UIViewController {
    var searchKey:String = ""
    var themeList:[SearchThemeData] = []
    // MARK: - Outlet
    @IBOutlet weak var themeTableView: UITableView!
    @IBOutlet weak var noThemeView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        themeTableView.delegate = self
        themeTableView.dataSource = self
        themeTableView.reloadData()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        setSearchThemeData(searchKey)
        
    }
    func setSearchThemeData(_ searchKey: String){
        SearchThemeService.shared.search(words:searchKey) { networkResult in
            switch networkResult {
            case .success(let searchResult):
                guard let data = searchResult as? [SearchThemeData] else {
                    return
                }
                
                self.themeList = data
                print("최근검색어: \(data)개")
                DispatchQueue.main.async {
                    self.themeTableView.reloadData()
                    if self.themeList.count == 0{
                        self.noThemeView.isHidden = false
                    }
                    else{
                        self.noThemeView.isHidden = true
                    }
                }
                
                
            case .requestErr(let message):
                
                guard let message = message as? String else { return }
            
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

/*
 // MARK: - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
 // Get the new view controller using segue.destination.
 // Pass the selected object to the new view controller.
 }
 */



extension SearchResultThemeVC: UITableViewDelegate{
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let resultCountLabel = UILabel().then {
            $0.text = "검색된 테마 \(themeList.count)개"
            $0.font = UIFont.systemFont(ofSize: 13)
            $0.textColor = .brownishGrey
        }
        let dividerView = UIView().then {
            $0.backgroundColor = .veryLightPink
        }
        let themeHeaderView = UIView().then {
            $0.addSubview(dividerView)
            $0.addSubview(resultCountLabel)
            $0.backgroundColor = .white
        }
        resultCountLabel.snp.makeConstraints{
            $0.leading.equalToSuperview().offset(16)
            $0.top.equalToSuperview().offset(12)
            $0.trailing.equalToSuperview().offset(-260)
        }
        dividerView.snp.makeConstraints{
            $0.width.equalToSuperview()
            $0.height.equalTo(0.5)
            $0.top.equalTo(resultCountLabel.snp.bottom).offset(11)
            $0.bottom.equalToSuperview()
        }
        
        return themeHeaderView
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
       guard let themeVC = UIStoryboard(name:"ThemeInfo",bundle:nil).instantiateViewController(identifier: "ThemeInfoVC") as? ThemeInfoVC else{
            return
        }
        themeVC.themeIdx = self.themeList[indexPath.row].themeIdx
        self.navigationController?.pushViewController(themeVC, animated: true)
    }
    
}
extension SearchResultThemeVC: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return themeList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = themeTableView.dequeueReusableCell(withIdentifier: "searchResultThemeTVC", for: indexPath) as? SearchResultThemeTVC else { return UITableViewCell() }
        cell.themeTitleLabel.text = themeList[indexPath.row].theme
        cell.bookmarkCount = "\(themeList[indexPath.row].saves)"
        cell.sentenceCount = "\(themeList[indexPath.row].sentenceNum)"
        
        let text = cell.themeTitleLabel.text
        
        
        let attributedString = NSMutableAttributedString(string: cell.themeTitleLabel.text!)
        attributedString.addAttribute(NSAttributedString.Key.foregroundColor,
                                      value: UIColor.softGreen,
                                      range: (text as! NSString).range(of: searchKey))
        cell.themeTitleLabel.attributedText = attributedString
        cell.setCount()
        
        return cell
    }
    
}
