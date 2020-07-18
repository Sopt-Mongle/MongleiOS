//
//  SearchResultSentenceVC.swift
//  Mongle
//
//  Created by 이예슬 on 7/8/20.
//  Copyright © 2020 이주혁. All rights reserved.
//

import UIKit

class CuratorTabInfoSentenceVC: UIViewController {
    var curatorIdx = -1
    var sentenceList:[CuratorSentence] = []
    @IBOutlet weak var sentenceTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        sentenceTableView.delegate = self
        sentenceTableView.dataSource = self
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        getCuratorData()
        
    }
    //MARK: - Custom Methods
    func getCuratorData(){
        print(curatorIdx)
        CuratorInfoService.shared.getCuratorInfo(curatorIdx: self.curatorIdx){ networkResult in
            switch networkResult {
            case .success(let curatorInfo):
                guard let data = curatorInfo as? CuratorInfoData else {
                    return
                }
                self.sentenceList = data.sentence
                
                print("herere")
                
                print("문장 정보: \(data)개")
                
                DispatchQueue.main.async {
                    self.sentenceTableView.reloadData()
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
extension CuratorTabInfoSentenceVC: UITableViewDelegate{

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let sentenceVC = UIStoryboard(name:"SentenceInfo",bundle:nil).instantiateViewController(identifier: "SentenceInfoVC") as? SentenceInfoVC else {
            return
            
        }
        sentenceVC.sentenceIdx = self.sentenceList[indexPath.row].sentenceIdx
        self.navigationController?.pushViewController(sentenceVC, animated: true)
    }
    
}
extension CuratorTabInfoSentenceVC: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sentenceList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "searchResultSentenceTVC", for: indexPath) as? SearchResultSentenceTVC else{
            return UITableViewCell()
        }
        cell.sentenceLabel.text = sentenceList[indexPath.item].sentence
        cell.themeLabel.text = sentenceList[indexPath.item].theme
        cell.curatorLabel.text = sentenceList[indexPath.item].writer
      
        
        return cell
    }
    
    
    
}

