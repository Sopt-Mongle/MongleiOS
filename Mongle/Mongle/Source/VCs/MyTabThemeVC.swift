//
//  MyTabThemeVC.swift
//  Mongle
//
//  Created by 이예슬 on 7/15/20.
//  Copyright © 2020 이주혁. All rights reserved.
//

import UIKit

class MyTabThemeVC: UIViewController {
    var searchKey:String = "번아웃"
    // MARK: - IBOutlet
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

extension MyTabThemeVC: UITableViewDelegate{
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let resultCountLabel = UILabel().then {
//            $0.text = "검색된 테마 23개"
//            $0.font = UIFont.systemFont(ofSize: 13)
//            $0.textColor = .brownishGrey
//        }
//        let dividerView = UIView().then {
//            $0.backgroundColor = .veryLightPink
//        }
//        let themeHeaderView = UIView().then {
//            $0.addSubview(dividerView)
//            $0.addSubview(resultCountLabel)
//            $0.backgroundColor = .white
//        }
//        resultCountLabel.snp.makeConstraints{
//            $0.leading.equalToSuperview().offset(16)
//            $0.top.equalToSuperview().offset(12)
//            $0.trailing.equalToSuperview().offset(-260)
//        }
//        dividerView.snp.makeConstraints{
//            $0.width.equalToSuperview()
//            $0.height.equalTo(0.5)
//            $0.top.equalTo(resultCountLabel.snp.bottom).offset(11)
//            $0.bottom.equalToSuperview()
//        }
//
//        return themeHeaderView
        
//    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let themeVC = UIStoryboard(name:"ThemeInfo",bundle:nil).instantiateViewController(identifier: "ThemeInfoVC") as? ThemeInfoVC else{
            return
        }
        self.navigationController?.pushViewController(themeVC, animated: true)
    }
    
}
extension MyTabThemeVC: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = themeTableView.dequeueReusableCell(withIdentifier: "searchResultThemeTVC", for: indexPath) as? SearchResultThemeTVC else { return UITableViewCell() }
        
        let text = cell.themeTitleLabel.text
        
        
        let attributedString = NSMutableAttributedString(string: cell.themeTitleLabel.text!)
        attributedString.addAttribute(NSAttributedString.Key.foregroundColor,
                                      value: UIColor.softGreen,
                                      range: (text as! NSString).range(of: searchKey))
        cell.themeTitleLabel.attributedText = attributedString
        
        return cell
    }
    
}
