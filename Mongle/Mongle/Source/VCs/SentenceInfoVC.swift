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
    @IBOutlet var tableViewBottomConstraint: NSLayoutConstraint!
    
    //MARK:- UI Component
    lazy var popup = MonglePopupView(frame: CGRect(x: 0, y: 0, width: 304, height: 193))
    lazy var blur = UIView().then {
        $0.backgroundColor = .black
        $0.alpha = 0.5
    }
    //MARK:- Property
    var themeText: String = "브랜딩이 어려울 때, 영감을 주는 문장"
    var sentenceText: String = """
처음 마주할 때의 인상, 사소한 것으로 인해 생기는 호감, 알아가면서 느끼는 다양한 감정과 머금고있는 풍경과 분위기까지. 처음 마주할 때의 인상, 사소한 것으로 인해 생기는 호감, 알아가면서 느끼는 다양한 감정과 머금고있는 풍경과 분위기까지. 처음 마주할 때의인상,사소한 것으로 인해 생기는 호감,
"""
    var hasTheme: Bool = true
    var isMySentence: Bool = true
    var canDisplayOtherSentece: Bool = true
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        layoutTableView.delegate = self
        layoutTableView.dataSource = self
        
    }
    
    func showPopUp(){
        
        popup.setPopUp(state: .delete,
                yesHandler: { [weak self] in
                    print(#function)
                    self?.navigationController?.popViewController(animated: true)
                    
        },
                noHandler: {[weak self] in
                    self?.blur.removeFromSuperview()
                    self?.popup.removeFromSuperview()
                    
        },
                confirmHandler: nil)
    
        
        self.view.addSubview(blur)
        self.view.addSubview(popup)
        
        blur.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
        popup.snp.makeConstraints {
            $0.width.equalTo(304)
            $0.height.equalTo(193)
            $0.centerX.centerY.equalToSuperview()
        }
    }
    
    @objc func touchUpBackButton(){
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func touchUpOtherThemeButton(){
        guard let dvc = UIStoryboard(name: "ThemeInfo", bundle: nil).instantiateViewController(identifier: "ThemeInfoVC") as? ThemeInfoVC else {
            return
        }
        
        self.navigationController?.pushViewController(dvc, animated: true)
    }
    
    
}

//MARK:- Extension
//MARK: UITableViewDelegate
extension SentenceInfoVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            guard let dvc = UIStoryboard(name: "SentenceInfo", bundle: nil).instantiateViewController(identifier: "SentenceInfoVC") as? SentenceInfoVC else {
                return
            }
            self.navigationController?.pushViewController(dvc, animated: true)
        }
    }
    
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
            
            
            var imageView = UIImageView(image: UIImage(named: "sentenceThemeOImgTheme"))
            
            let backButton = UIButton().then {
                $0.frame = CGRect(x: 0, y: 0, width: 48, height: 48)
                $0.setImage(UIImage(named: "sentenceThemeOBtnBack"), for: .normal)
                $0.addTarget(self, action: #selector(touchUpBackButton), for: .touchUpInside)
            }
            
            let themeLabel = UILabel().then {
                $0.text = themeText
                $0.textColor = .white
                $0.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 18.0)!
            }
            
            if !hasTheme {
                self.tableViewBottomConstraint.constant = -likeAndBookmarkView.frame.height
                themeLabel.text = "테마 없는 문장"
                imageView = UIImageView(image: UIImage(named: "sentenceThemeXBgThemeX"))
                backButton.setImage(UIImage(named: "sentenceThemeXBtnBack"), for: .normal)
                likeAndBookmarkView.isHidden = true
            }
            
            view.addSubview(imageView)
            view.addSubview(backButton)
            view.addSubview(themeLabel)
            
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
                $0.image = UIImage(named: "mySettingsIcArrow1")
                $0.frame = CGRect(x: 0, y: 0, width: 4, height: 8)
            }
            
            let stackView = UIStackView().then {
                $0.addArrangedSubview(label)
                $0.addArrangedSubview(image)
                $0.spacing = 6
                $0.axis = .horizontal
            }
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(touchUpOtherThemeButton))
            
            let backgroundView = UIView(frame: CGRect(x: 0, y: 0, width: 343, height: 45)).then {
                $0.makeRounded(cornerRadius: 10)
                $0.backgroundColor = UIColor(red: 188 / 255, green: 188 / 255, blue: 188 / 255, alpha: 0.19)
                $0.addSubview(stackView)
                $0.isUserInteractionEnabled = true
                $0.addGestureRecognizer(tapGesture)
            }
            
            
            stackView.snp.makeConstraints {
                $0.centerX.centerY.equalToSuperview()
            }
            
            image.snp.makeConstraints {
                $0.width.equalTo(4)
                $0.height.equalTo(8)
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
                
                let deleteAction = UIAlertAction(title: "삭제", style: .default) {[weak self] action in
                    
                    self?.showPopUp()
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
