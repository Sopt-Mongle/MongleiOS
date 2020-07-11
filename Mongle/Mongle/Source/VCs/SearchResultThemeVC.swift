//
//  SearchResultThemeVC.swift
//  Mongle
//
//  Created by 이예슬 on 7/8/20.
//  Copyright © 2020 이주혁. All rights reserved.
//

import UIKit

class SearchResultThemeVC: UIViewController {
    
    // MARK: - Outlet
    @IBOutlet weak var themeTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        themeTableView.delegate = self
        themeTableView.dataSource = self
        themeTableView.reloadData()
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

extension SearchResultThemeVC: UITableViewDelegate{
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let themeHeaderView = UIView()
        let resultCountLabel = UILabel()
        resultCountLabel.text = "검색된 테마 23개"
        resultCountLabel.font = UIFont.systemFont(ofSize: 13)
        themeHeaderView.addSubview(resultCountLabel)
        resultCountLabel.snp.makeConstraints{
            $0.leading.equalToSuperview().offset(16)
            $0.top.equalToSuperview().offset(12)
            $0.trailing.equalToSuperview().offset(-260)
        }
        let dividerView = UIView()
        themeHeaderView.addSubview(dividerView)
        dividerView.backgroundColor = .veryLightPink
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
    
}
extension SearchResultThemeVC: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = themeTableView.dequeueReusableCell(withIdentifier: "searchResultThemeTVC", for: indexPath) as? SearchResultThemeTVC else { return UITableViewCell() }
        return cell
    }
    
    
}
