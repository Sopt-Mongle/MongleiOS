//
//  SearchResultSentenceVC.swift
//  Mongle
//
//  Created by 이예슬 on 7/8/20.
//  Copyright © 2020 이주혁. All rights reserved.
//

import UIKit

class SearchResultSentenceVC: UIViewController {
    var sentenceList : [SearchSentenceData] = []
    var searchKey:String = ""
    @IBOutlet weak var sentenceTableView: UITableView!
    @IBOutlet weak var noSentenceView: UIView!
    
    //MARK:- LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        sentenceTableView.delegate = self
        sentenceTableView.dataSource = self
        sentenceTableView.contentInset.bottom = 60
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool){
        setSearchSentenceData(searchKey)
        if sentenceList.count == 0{
            noSentenceView.isHidden = false
        }
        else{
            noSentenceView.isHidden = true
        }
    }
    func setSearchSentenceData(_ searchKey: String){
        SearchSentenceService.shared.search(words:searchKey) { networkResult in
            switch networkResult {
            case .success(let searchResult):
                guard let data = searchResult as? [SearchSentenceData] else {
                    return
                }
                
                self.sentenceList = data
                DispatchQueue.main.async {
                    self.sentenceTableView.reloadData()
                    if self.sentenceList.count == 0{
                        self.noSentenceView.isHidden = false
                    }
                    else{
                        self.noSentenceView.isHidden = true
                    }
                }
                
                
            case .requestErr(let message):
                
                guard let message = message as? String else { return }
            
                print(message)
            case .pathErr:
                
                print("pathErr")
            case .serverErr:
                print("serverErr")
            case .networkFail:
                print("networkFail")
            }
            
            
        }
    }

}
extension SearchResultSentenceVC: UITableViewDelegate{
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let resultCountLabel = UILabel().then {
            $0.text = "검색된 문장 \(sentenceList.count)개"
            $0.font = UIFont.systemFont(ofSize: 13)
            $0.textColor = .brownishGrey
        }
        let dividerView = UIView().then {
            $0.backgroundColor = .veryLightPink
        }
        let sentenceHeaderView = UIView().then {
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
        
        return sentenceHeaderView
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let sentenceVC = UIStoryboard(name:"SentenceInfo",bundle:nil).instantiateViewController(identifier: "SentenceInfoVC") as? SentenceInfoVC else {
            return
            
        }
        sentenceVC.sentenceIdx = self.sentenceList[indexPath.row].sentenceIdx
        self.navigationController?.pushViewController(sentenceVC, animated: true)
    }
    
}
extension SearchResultSentenceVC: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sentenceList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "searchResultSentenceTVC", for: indexPath) as? SearchResultSentenceTVC else{
            return UITableViewCell()
        }
        cell.themeLabel.text = sentenceList[indexPath.row].theme
        cell.sentenceLabel.text = sentenceList[indexPath.row].sentence
        cell.curatorLabel.text = sentenceList[indexPath.row].writer
        
        let text = cell.sentenceLabel.text
        
        
        let attributedString = NSMutableAttributedString(string: cell.sentenceLabel.text!)
        attributedString.addAttribute(NSAttributedString.Key.foregroundColor,
                                      value: UIColor.softGreen,
                                      range: (text as! NSString).range(of: searchKey))
        cell.sentenceLabel.attributedText = attributedString
        
        return cell
    }
    
    
    
}
