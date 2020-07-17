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
    
    @IBOutlet var likeCountLabel: UILabel!
    @IBOutlet var bookCountLabel: UILabel!
    
    @IBOutlet var likeImageview: UIImageView!
    @IBOutlet var bookmarkImageView: UIImageView!
    
    @IBOutlet var likeView: UIView!
    @IBOutlet var bookmarkView: UIView!
    
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
    var sentence: Sentence?
    var themeImage: UIImage?
    var otherSentences: [Sentence] = []
    var hasTheme: Bool = true
    var isMySentence: Bool = true
    var canDisplayOtherSentece: Bool = true
    var sentenceIdx: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addGesture()
        layoutTableView.delegate = self
        layoutTableView.dataSource = self
    }
    override func viewWillAppear(_ animated: Bool) {
        getSentenceInfo()
        getOtherSentece()
    }
    
    func getSentenceInfo(){
        SentenceService.shared.getSentence(idx: self.sentenceIdx ?? 0) { networkResult in
            switch networkResult {
            case .success(let data):
                if let _data = data as? [Sentence] {
                    self.sentence = _data[0]

                    self.layoutTableView.reloadSections(IndexSet(arrayLiteral: 0), with: .automatic)
                    self.updateStateLayout()
                }
                self.showToast(text: "d연결성공")
            case .requestErr(let msg):
                self.showToast(text: msg as? String ?? "")
            case .pathErr:
                self.showToast(text: "pathErr")
            case .serverErr:
                self.showToast(text: "serverErr")
            case .networkFail:
                self.showToast(text: "networkFail")
            }
        }
    }
    func getOtherSentece(){
        SentenceService.shared.getSentence(idx: self.sentenceIdx ?? 0) { networkResult in
            switch networkResult {
            case .success(let data):
                if let _data = data as? [Sentence] {
                    self.otherSentences = _data
//                    print(self.ot)
                    self.layoutTableView.reloadSections(IndexSet(arrayLiteral: 1), with: .automatic)
                    self.showToast(text: "다른 문장 성공")
                }
            case .requestErr(let msg):
                self.showToast(text: msg as? String ?? "request err")
            case .pathErr:
                self.showToast(text: "pathErr")
            case .serverErr:
                self.showToast(text: "serverErr")
            case .networkFail:
                self.showToast(text: "networkFail")
            }
        }
    }
    
    func updateStateLayout(){
        
        guard let _sentence = self.sentence else {
            return
        }
        var likeCountText = "\(_sentence.likes)"
        var savesCountText = "\(_sentence.saves)"
        
        if _sentence.likes > 1000 {
            likeCountText = "999+"
        }
        if _sentence.saves > 1000 {
            savesCountText = "999+"
        }
        self.likeCountLabel.text = likeCountText
        self.bookCountLabel.text = savesCountText
        
        if _sentence.alreadyLiked {
            self.likeCountLabel.textColor = .softGreen
        }
        else {
            self.likeCountLabel.textColor = .veryLightPink
            
        }
        
        if _sentence.alreadyBookmarked {
            self.bookCountLabel.textColor = .softGreen
        }
        else {
            self.bookCountLabel.textColor = .veryLightPink
        }
    }
    
    func addGesture(){
        let likeTapGesture = UITapGestureRecognizer(target: self, action: #selector(touchUpLike))
        let saveTapGesture = UITapGestureRecognizer(target: self, action: #selector(touchUpBookmark))
        self.likeView.isUserInteractionEnabled = true
        self.bookmarkView.isUserInteractionEnabled = true
        
        self.likeView.addGestureRecognizer(likeTapGesture)
        self.bookmarkView.addGestureRecognizer(saveTapGesture)
    }
    
    @objc func touchUpLike(){
        SentenceService.shared.putSentenceLike(idx: self.sentenceIdx ?? 0) { networkResult in
            switch networkResult {
            case .success(let data):
                if let _data = data as? SentenceLikeData {
                    self.sentence?.alreadyLiked = _data.isLike
                    self.sentence?.likes = _data.likes
                    self.updateStateLayout()
                    if _data.isLike {
                        self.showToast(text: "좋아요 성공")
                    }
                    else {
                        self.showToast(text: "좋아요 해제")
                    }
                }
            case .requestErr(let msg):
                self.showToast(text: msg as? String ?? "")
            case .pathErr:
                self.showToast(text: "pathErr")
            case .serverErr:
                self.showToast(text: "serverErr")
            case .networkFail:
                self.showToast(text: "networkFail")
            }
        }
    }
    
    @objc func touchUpBookmark(){
        SentenceService.shared.putBookmark(idx: self.sentenceIdx ?? 0) { networkResult in
            switch networkResult {
                
            case .success(let data):
                
                if let _data = data as? SentenceBookmarkData {
                    self.sentence?.alreadyBookmarked = _data.isSave
                    self.sentence?.saves = _data.saves
                    self.updateStateLayout()
                    if _data.isSave {
                        self.showToast(text: "북마크 성공")
                    }
                    else {
                        self.showToast(text: "북마크 해제")
                    }
                }
            case .requestErr(let msg):
                self.showToast(text: msg as? String ?? "requestErr")
            case .pathErr:
                self.showToast(text: "pathErr")
            case .serverErr:
                self.showToast(text: "serverErr")
            case .networkFail:
                self.showToast(text: "networkFail")
            }
        }
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
            
            
            var imageView = UIImageView(image: self.themeImage)
            
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
            return self.otherSentences.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SentenceInfoTVC.identifier) as? SentenceInfoTVC else {
                return UITableViewCell()
            }
            cell.setSentenceData(sentence: self.sentence?.sentence ?? "",
                                 profileImg: self.sentence?.writerImg ?? "",
                                 curatorName: self.sentence?.writer ?? "",
                                 isLiked: true,
                                 isBookmarked: true)
            cell.setBookData(bookName: self.sentence?.title ?? "",
                             writerName: self.sentence?.author ?? "",
                             publisherName: self.sentence?.publisher ?? "",
                             bookImageUrl: self.sentence?.writerImg ?? "")
            
//            cell.sentenceLabel.text = self.sentenceText
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
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SentenceInThemeTVC.identifier, for: indexPath) as? SentenceInThemeTVC else {
                return UITableViewCell()
            }
            print(indexPath.row)
            let otherSentnece = self.otherSentences[indexPath.row]

            cell.setData(sentence: otherSentnece.sentence,
                         bookName: otherSentnece.title,
                         likeCount: otherSentnece.likes,
                         bookMarkCount: otherSentnece.saves)
            return cell
            
        }
    }
}
