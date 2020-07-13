//
//  SentenceInfoVC.swift
//  Mongle
//
//  Created by 이주혁 on 2020/07/12.
//  Copyright © 2020 이주혁. All rights reserved.
//

import UIKit

class SentenceInfoVC: UIViewController {
    
    //MARK:- IBOutlet
    @IBOutlet var layoutTableView: UITableView!
    @IBOutlet var likeAndBookmarkView: UIView!
    
    //MARK:- Property
    var themeText: String = "브랜딩이 어려울 때, 영감을 주는 문장"
    var sentenceText: String = """
처음 마주할 때의 인상, 사소한 것으로 인해 생기는 호
감, 알아가면서 느끼는 다양한 감정과 머금고있는 풍
경과 분위기까지. 처음 마주할 때의 인상, 사소한 것으
로 인해 생기는 호감, 알아가면서 느끼는 다양한 감정
과 머금고있는 풍경과 분위기까지. 처음 마주할 때의
인상, 사소한 것으로 인해 생기는 호감, 
"""
    var hasTheme: Bool = true
    var isMySentence: Bool = true
    var canDisplayOtherSentece: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        layoutTableView.delegate = self
        layoutTableView.dataSource = self
        
    }
    
    @objc func touchUpBackButton(){
        self.navigationController?.popViewController(animated: true)
    }
    
    
}

//MARK:- Extension
//MARK: UITableViewDelegate
extension SentenceInfoVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 144
        }
        else {
            return 95
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0
        }
        else {
            return 106
        }
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            let view = UIView(frame: CGRect(x: 0, y: 0, width: 375, height: 144))
            
            
            let imageView = UIImageView(image: UIImage(named: "mongleCharacters"))
            imageView.backgroundColor = .brown
            
            let blurView = UIView().then {
               
                    
                    $0.backgroundColor = UIColor(red: 90 / 255, green: 145 / 255, blue: 105 / 255, alpha: 0.55)

            }
            
            let backButton = UIButton().then {
                $0.frame = CGRect(x: 0, y: 0, width: 48, height: 48)
                $0.setImage(UIImage(named: "searchBtnBack"), for: .normal)
                $0.addTarget(self, action: #selector(touchUpBackButton), for: .touchUpInside)
            }
            
            let themeLabel = UILabel().then {
                $0.text = themeText
                $0.textColor = .white
                $0.font = UIFont.systemFont(ofSize: 18)
            }
            
            if !hasTheme {
                blurView.backgroundColor = .brownGreyThree
                backButton.imageView?.tintColor = .white
                likeAndBookmarkView.isHidden = true
            }
            
            view.addSubview(imageView)
            view.addSubview(blurView)
            view.addSubview(backButton)
            view.addSubview(themeLabel)
            
            blurView.snp.makeConstraints {
                $0.top.leading.trailing.bottom.equalToSuperview()
            }
            
            imageView.snp.makeConstraints {
                $0.top.leading.trailing.bottom.equalToSuperview()
            }
            backButton.snp.makeConstraints {
                $0.top.equalToSuperview().offset(37)
                $0.leading.equalToSuperview()
                $0.height.width.equalTo(48)
            }
            
            themeLabel.snp.makeConstraints {
                $0.leading.equalToSuperview().offset(28)
                $0.bottom.equalToSuperview().offset(-19)
            }
            
            return view
        }
        else {
            let view = UIView(frame: CGRect(x: 0, y: 0, width: 375, height: 95))
            let otherSentences = UILabel().then {
                $0.font = UIFont.systemFont(ofSize: 18)
                $0.text = "이 테마의 다른 문장"
            }
            view.addSubview(otherSentences)
            otherSentences.snp.makeConstraints {
                $0.leading.equalToSuperview().offset(16)
                $0.bottom.equalToSuperview().offset(-22)
            }
            
            
            return view
        }
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if section == 1 {
            let view = UIView(frame: CGRect(x: 0, y: 0, width: 375, height: 106))
            
            let label = UILabel().then {
                $0.font = UIFont.systemFont(ofSize: 13)
                $0.textColor = UIColor(red: 139 / 255, green: 139 / 255, blue: 139 / 255, alpha: 1.0)
                $0.text = "테마 보러 가기"
            }
            let image = UIImageView().then {
                $0.image = UIImage(named: "searchBtnBack")
                $0.backgroundColor = .red
            }
            
            let stackView = UIStackView().then {
                $0.addArrangedSubview(label)
                $0.addArrangedSubview(image)
                $0.spacing = 6
                $0.axis = .horizontal
            }
            let backgroundView = UIView(frame: CGRect(x: 0, y: 0, width: 343, height: 45)).then {
                $0.makeRounded(cornerRadius: 10)
                $0.backgroundColor = .veryLightPink
                $0.addSubview(stackView)
            }
            
            stackView.snp.makeConstraints {
                $0.centerX.centerY.equalToSuperview()
            }
            
            
            view.addSubview(backgroundView)
            
            backgroundView.snp.makeConstraints {
                $0.leading.equalToSuperview().offset(16)
                $0.trailing.equalToSuperview().offset(-16)
                $0.top.equalToSuperview().offset(24)
                $0.bottom.equalToSuperview().offset(-36)
            }
            return view
        }
        else {
            return nil
        }
    }
}

//MARK: UITableViewDataSource
extension SentenceInfoVC: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if canDisplayOtherSentece {
            return 2
        }
        else {
            return 1
        }
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        else {
            return 2
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SentenceInfoTVC.identifier) as? SentenceInfoTVC else {
                return UITableViewCell()
            }
            print(self.sentenceText)
            cell.sentenceLabel.text = self.sentenceText
            cell.editButtonDelegate = { [weak self] sheet in
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
        
            cell.editButton.isHidden = !isMySentence
            
            return cell
        }
        else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SentenceInThemeTVC.identifier) else {
                return UITableViewCell()
            }   
            
            return cell
        }
    }
}
