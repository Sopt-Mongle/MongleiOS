//
//  SearchResultSentenceVC.swift
//  Mongle
//
//  Created by 이예슬 on 7/8/20.
//  Copyright © 2020 이주혁. All rights reserved.
//

import UIKit

class SearchResultSentenceVC: UIViewController {
    var searchKey:String = "봄"
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

}
extension SearchResultSentenceVC: UITableViewDelegate{
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let resultCountLabel = UILabel().then {
            $0.text = "검색된 문장 23개"
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
    }
    
}
extension SearchResultSentenceVC: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "searchResultSentenceTVC", for: indexPath) as? SearchResultSentenceTVC else{
            return UITableViewCell()
        }
        let text = cell.sentenceLabel.text
        
        
        let attributedString = NSMutableAttributedString(string: cell.sentenceLabel.text!)
        attributedString.addAttribute(NSAttributedString.Key.foregroundColor,
                                      value: UIColor.softGreen,
                                      range: (text as! NSString).range(of: searchKey))
        cell.sentenceLabel.attributedText = attributedString
        
        return cell
    }
    
    
    
}
