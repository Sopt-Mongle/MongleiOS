//
//  MyTabSentenceVC.swift
//  Mongle
//
//  Created by 이예슬 on 7/15/20.
//  Copyright © 2020 이주혁. All rights reserved.
//

import UIKit

class MyTabSentenceVC: UIViewController {
    var doNotReload = false
    var bookmarkBtnIdx = 0
    @IBOutlet weak var sentenceTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        sentenceTableView.delegate = self
        sentenceTableView.dataSource = self
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
    @objc func savedThemeDidTap(){
        self.bookmarkBtnIdx = 0
        self.doNotReload = false

        self.sentenceTableView.reloadData()

    }
    @objc func madeThemeDidTap(){
        self.bookmarkBtnIdx = 1
        self.doNotReload = true
        
        self.sentenceTableView.reloadData()
    }


}
extension MyTabSentenceVC: UITableViewDelegate{
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView().then{
            $0.backgroundColor = .white
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
        guard let sentenceVC = UIStoryboard(name:"SentenceInfo",bundle:nil).instantiateViewController(identifier: "SentenceInfoVC") as? SentenceInfoVC else {
            return
            
        }
        self.navigationController?.pushViewController(sentenceVC, animated: true)
    }
    
}
extension MyTabSentenceVC: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "searchResultSentenceTVC", for: indexPath) as? SearchResultSentenceTVC else{
            return UITableViewCell()
        }
        
        return cell
    }
    
    
    
}
