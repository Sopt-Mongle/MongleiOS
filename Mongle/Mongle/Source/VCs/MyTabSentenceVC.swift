//
//  MyTabSentenceVC.swift
//  Mongle
//
//  Created by 이예슬 on 7/15/20.
//  Copyright © 2020 이주혁. All rights reserved.
//

import UIKit

class MyTabSentenceVC: UIViewController {
    var sentenceText: String = """
    처음 마주할 때의 인상, 사소한 것으로 인해 생기는 호
    감, 알아가면서 느끼는 다양한 감정과 머금고있는 풍
    경과 분위기까지. 처음 마주할 때의 인상, 사소한 것으
    로 인해 생기는 호감, 알아가면서 느끼는 다양한 감정
    과 머금고있는 풍경과 분위기까지. 처음 마주할 때의
    인상, 사소한 것으로 인해 생기는 호감,
    """
    var doNotReload = false
    var bookmarkBtnIdx = 0
    var mySentenceData : MySentenceData?
    var mySentenceSave : [MySentenceSave] = []
    var mySentenceWrite : [MySentenceSave] = []
    
    //MARK: - IBOutlet
    @IBOutlet weak var sentenceTableView: UITableView!
    
    //MARK: - LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        sentenceTableView.delegate = self
        sentenceTableView.dataSource = self
        
    }
    override func viewWillAppear(_ animated: Bool) {
        setMySentence()
    }
    
    //MARK: - Custom Methods
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
    func setMySentence(){
        MySentenceService.shared.getMy(){ networkResult in
            
            switch networkResult {
            case .success(let theme):
                guard let data = theme as? MySentenceData else {
                    return
                }
                print("성공")
                self.mySentenceData = data
                self.mySentenceSave = data.save
                self.mySentenceWrite = data.write
                print("내 프로필 테마: \(data)")
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
//MARK: - UITableViewDelegate
extension MyTabSentenceVC: UITableViewDelegate{
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView().then{
            $0.backgroundColor = .white
        }
        
        let savedSentenceLabel = UILabel().then {
            $0.text = "저장한 문장"
            $0.textColor = .veryLightPink
            $0.textAlignment = .center
            $0.backgroundColor = .white
            $0.font = UIFont.systemFont(ofSize: 13)
            $0.makeRounded(cornerRadius: 14)
            
            headerView.addSubview($0)
        }
        let madeSentenceLabel = UILabel().then {
            $0.text = "쓴 문장"
            $0.textColor = .white
            $0.textAlignment = .center
            $0.backgroundColor = .softGreen
            $0.font = UIFont.systemFont(ofSize: 13)
            $0.makeRounded(cornerRadius: 14)
            
            headerView.addSubview($0)
        }
        
        let savedSentenceTouchArea = UIButton().then{
            $0.setTitle("", for: .normal)
            $0.backgroundColor = .clear
            $0.addTarget(self, action: #selector(self.savedThemeDidTap), for: .touchUpInside)
            headerView.addSubview($0)
        }
        let madeSentenceTouchArea = UIButton().then{
            $0.setTitle("", for: .normal)
            $0.backgroundColor = .clear
            $0.addTarget(self, action: #selector(self.madeThemeDidTap), for: .touchUpInside)
            headerView.addSubview($0)
        }
        //
        
        if self.doNotReload{
            savedSentenceLabel.textColor = .veryLightPink
            savedSentenceLabel.backgroundColor = .white
            madeSentenceLabel.textColor = .white
            madeSentenceLabel.backgroundColor = .softGreen
            
            
        }
        else {
            madeSentenceLabel.textColor = .veryLightPink
            madeSentenceLabel.backgroundColor = .white
            savedSentenceLabel.textColor = .white
            savedSentenceLabel.backgroundColor = .softGreen
            
        }
        
        savedSentenceLabel.snp.makeConstraints{
            $0.width.equalTo(82)
            $0.height.equalTo(28)
            $0.top.equalToSuperview().offset(15)
            $0.right.equalToSuperview().offset(-78)
            $0.bottom.equalToSuperview().offset(-6)
        }
        madeSentenceLabel.snp.makeConstraints{
            $0.width.equalTo(62)
            $0.height.equalTo(28)
            $0.top.equalToSuperview().offset(15)
            $0.right.equalToSuperview().offset(-16)
            $0.bottom.equalToSuperview().offset(-6)
        }
        savedSentenceTouchArea.snp.makeConstraints{
            $0.width.equalTo(82)
            $0.top.equalToSuperview()
            $0.right.equalToSuperview().offset(-78)
            $0.bottom.equalToSuperview()
        }
        madeSentenceTouchArea.snp.makeConstraints{
            $0.width.equalTo(62)
            $0.top.equalToSuperview()
            $0.right.equalToSuperview().offset(-16)
            $0.bottom.equalToSuperview()
        }

        return headerView
        
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 49
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let sentenceVC = UIStoryboard(name:"SentenceInfo",bundle:nil).instantiateViewController(identifier: "SentenceInfoVC") as? SentenceInfoVC else {
            return
            
        }
        if doNotReload{
            sentenceVC.sentenceIdx = mySentenceWrite[indexPath.row].sentenceIdx
        }
        else{
            sentenceVC.sentenceIdx = mySentenceSave[indexPath.row].sentenceIdx
        }
        
        self.navigationController?.pushViewController(sentenceVC, animated: true)
    }
    
}
//MARK:- UITableViewDataSource
extension MyTabSentenceVC: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if doNotReload{
            return mySentenceWrite.count
        }
        else{
            return mySentenceSave.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if doNotReload{
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "SentenceMoreTVC", for: indexPath) as? SentenceMoreTVC else{
                return UITableViewCell()
            }
            cell.moreBTNDelegate = { [weak self] sheet in
                let editAction = UIAlertAction(title: "수정", style: .default) { action in
                    guard let dvc = UIStoryboard.init(name: "SentenceEdit", bundle: nil).instantiateViewController(identifier: "SentenceEditVC") as? SentenceEditVC else {
                        return
                    }
                    dvc.text = self?.sentenceText
                    self?.navigationController?.pushViewController(dvc, animated: true)
                }.then {
                    $0.titleTextColor = .black
                }
                
                let deleteAction = UIAlertAction(title: "삭제", style: .default) { action in
                    
                }.then {
                    $0.titleTextColor = .black
                }
                
                let cancelAction = UIAlertAction(title: "취소", style: .cancel) { action in
                }.then {
                    $0.titleTextColor = .black
                }

                sheet.addAction(editAction)
                sheet.addAction(deleteAction)
                sheet.addAction(cancelAction)
                self?.present(sheet, animated: true, completion: nil)
            }
            cell.themeLabel.text = mySentenceWrite[indexPath.row].theme
            cell.sentenceLabel.text = mySentenceWrite[indexPath.row].sentence
            cell.curatorLabel.text = mySentenceWrite[indexPath.row].writer
            return cell
        }
        else{
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "searchResultSentenceTVC", for: indexPath) as? SearchResultSentenceTVC else{
                return UITableViewCell()
            }
            cell.themeLabel.text = mySentenceSave[indexPath.row].theme
            cell.sentenceLabel.text = mySentenceSave[indexPath.row].sentence
            cell.curatorLabel.text = mySentenceSave[indexPath.row].writer
            return cell
            
        }
        
        
    }
    
    
    
}
