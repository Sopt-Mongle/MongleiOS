//
//  MyTabThemeVC.swift
//  Mongle
//
//  Created by 이예슬 on 7/15/20.
//  Copyright © 2020 이주혁. All rights reserved.
//

import UIKit

class MyTabThemeVC: UIViewController {
    var doNotReload = false
    var searchKey:String = "번아웃"
    var bookmarkBtnIdx = 0
    var labelList :[UILabel] = []
    // MARK: - IBOutlet
    @IBOutlet weak var themeTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        themeTableView.delegate = self
        themeTableView.dataSource = self
        themeTableView.reloadData()
        // Do any additional setup after loading the view.
    }
    @objc func sentenceWithoutThemeDidTap(){
        print("didtap")
        guard let vc = UIStoryboard(name: "ThemeInfo",
                                        bundle: nil).instantiateViewController(
                                            withIdentifier: "ThemeInfoVC") as? ThemeInfoVC
            else{
                print("gusrf lrt")
                return
        }
        vc.hasTheme = false
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    @objc func savedThemeDidTap(){
        self.bookmarkBtnIdx = 0
        self.doNotReload = false

        self.themeTableView.reloadData()

    }
    @objc func madeThemeDidTap(){
        self.bookmarkBtnIdx = 1
        self.doNotReload = true
        
        self.themeTableView.reloadData()
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
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView().then{
            $0.backgroundColor = .white
        }
        let withoutTheme = UIButton().then {
            $0.setTitle("", for: .normal)
            $0.setTitleColor(.veryLightPink, for: .normal)
            $0.setImage(UIImage(named:"myThemeBookmarkBtnThemeX"), for: .normal)
            $0.contentVerticalAlignment = .top
            $0.contentHorizontalAlignment = .leading
            $0.contentEdgeInsets = UIEdgeInsets(top: 17, left: 16, bottom: 0, right: 0)
            $0.addTarget(self, action: #selector(self.sentenceWithoutThemeDidTap), for: .touchUpInside)
            headerView.addSubview($0)
        }
        let savedThemeLabel = UILabel().then {
            $0.text = "저장한 테마"
            $0.textColor = .veryLightPink
            $0.textAlignment = .center
            $0.backgroundColor = .white
            $0.font = UIFont.systemFont(ofSize: 13)
            $0.makeRounded(cornerRadius: 14)
   
            headerView.addSubview($0)
        }
        let madeThemeLabel = UILabel().then {
            $0.text = "만든 테마"
            $0.textColor = .white
            $0.textAlignment = .center
            $0.backgroundColor = .softGreen
            $0.font = UIFont.systemFont(ofSize: 13)
            $0.makeRounded(cornerRadius: 14)
 
            headerView.addSubview($0)
        }
        
        if self.doNotReload{
            savedThemeLabel.textColor = .veryLightPink
            savedThemeLabel.backgroundColor = .white
            madeThemeLabel.textColor = .white
            madeThemeLabel.backgroundColor = .softGreen
            
        }
        else {
            madeThemeLabel.textColor = .veryLightPink
            madeThemeLabel.backgroundColor = .white
            savedThemeLabel.textColor = .white
            savedThemeLabel.backgroundColor = .softGreen
        }
        
        
        let savedThemeTouchArea = UIButton().then{
            $0.setTitle("", for: .normal)
            $0.backgroundColor = .clear
            $0.addTarget(self, action: #selector(self.savedThemeDidTap), for: .touchUpInside)
            headerView.addSubview($0)
        }
        let madeThemeTouchArea = UIButton().then{
            $0.setTitle("", for: .normal)
            $0.backgroundColor = .clear
            $0.addTarget(self, action: #selector(self.madeThemeDidTap), for: .touchUpInside)
            headerView.addSubview($0)
        }
        let divider = UIView().then{
            $0.backgroundColor = .veryLightPinkSix
            
            headerView.addSubview($0)
        }
        
        
        withoutTheme.snp.makeConstraints{
            $0.leading.equalToSuperview().offset(0)
            $0.top.equalToSuperview().offset(0)
            $0.bottom.equalToSuperview().offset(0)
        }
        savedThemeLabel.snp.makeConstraints{
            $0.width.equalTo(82)
            $0.height.equalTo(28)
            $0.top.equalToSuperview().offset(9)
            $0.left.equalToSuperview().offset(218)
            $0.bottom.equalToSuperview().offset(-12)
        }
        madeThemeLabel.snp.makeConstraints{
            $0.width.equalTo(72)
            $0.height.equalTo(28)
            $0.top.equalToSuperview().offset(9)
            $0.left.equalToSuperview().offset(300)
            $0.bottom.equalToSuperview().offset(-12)
        }
        
        divider.snp.makeConstraints{
            $0.height.equalTo(1)
            $0.left.equalToSuperview()
            $0.right.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        savedThemeTouchArea.snp.makeConstraints{
            $0.width.equalTo(84)
            $0.top.equalToSuperview()
            $0.left.equalToSuperview().offset(203)
            $0.bottom.equalToSuperview()
        }
        madeThemeTouchArea.snp.makeConstraints{
            $0.width.equalTo(84)
            $0.top.equalToSuperview()
            $0.left.equalToSuperview().offset(287)
            $0.right.equalToSuperview().offset(-16)
            $0.bottom.equalToSuperview()
        }

        return headerView
        
    }
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
        print(indexPath.row)
        guard let cell = themeTableView.dequeueReusableCell(withIdentifier: "searchResultThemeTVC", for: indexPath) as? SearchResultThemeTVC else { return UITableViewCell() }

        return cell
    }
    
}