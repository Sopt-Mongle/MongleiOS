//
//  ThemeInfoVC.swift
//  Mongle
//
//  Created by 이주혁 on 2020/07/10.
//  Copyright © 2020 이주혁. All rights reserved.
//

import UIKit

class ThemeInfoVC: UIViewController {
    
    //MARK:- IBOutlet
    @IBOutlet var sentenceTableView: UITableView! {
        didSet {
            sentenceTableView.delegate = self
            sentenceTableView.dataSource = self
        }
    }
    @IBOutlet var sentencesBackgroundView: UIView!
    @IBOutlet var themeBackgroundView: UIView!
    @IBOutlet var writeInThemeButton: UIButton!
    @IBOutlet var themeInfoStackView: UIStackView!
    @IBOutlet var themeNameLabel: UILabel!
    @IBOutlet var sentenceCountLabel: UILabel!
    @IBOutlet var bookmarkCountLabel: UILabel!
    
    @IBOutlet var curatorProfileImageView: UIImageView!
    @IBOutlet var curatorNameLabel: UILabel!
    
    @IBOutlet var themeImageView: UIImageView!
    @IBOutlet var bottomBackgroundView: UIView!
    @IBOutlet var sentencesBackGroudViewBottomConstraint: NSLayoutConstraint!
    
    @IBOutlet var backButton: UIButton!
    //MARK:- Property
    var hasTheme: Bool = true
    var themeIdx: Int?
    var themeData: Theme?
    var sentences: [Sentence] = []
//    var sentences = [
//        "아아아아아아나난나ㅏ나난나나\n나나나나나난나ㅏ난아아아아아아나난나ㅏ나난",
//        "아아아아아아나난나ㅏ나난나\n나나나나나나난나ㅏ난",
//        "아아아아아아나난나ㅏ나난나나나나나나나난나ㅏ난",
//        "아아아아아아나난나ㅏ나난나\n나나나나나나난나ㅏ난",
//        "아아아아아아나난나ㅏ나난나나나나나나나난나ㅏ난",
//        "아아아아아아나난나ㅏ나난나\n나나나나나나난나ㅏ난",
//        "아아아아아아나난나ㅏ나난나나나나나나나난나ㅏ난",
//        "아아아아아아나난나ㅏ나난나\n나나나나나나난나ㅏ난",
//        "아아아아아아나난나ㅏ나난나나나나나나나난나ㅏ난"
//    ]
    var themeText: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setInitLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setThemeData()
    }
    
    func setInitLayout(){
        themeBackgroundView.backgroundColor = .clear
        if hasTheme {
            self.themeNameLabel.text = themeText ?? ""
            sentencesBackGroudViewBottomConstraint.constant = 0
            bottomBackgroundView.isHidden = false
            themeImageView.image = UIImage(named: "sentenceThemeOImgTheme")
        }
        else {
            backButton.setImage(UIImage(named: "sentenceThemeXBtnBack"), for: .normal)
            themeImageView.image = UIImage(named: "themeWritingThemeXSentenceBg")
            sentencesBackgroundView.backgroundColor = .black
            sentencesBackGroudViewBottomConstraint.constant = -bottomBackgroundView.frame.height
            
            curatorProfileImageView.isHidden = true
            themeInfoStackView.isHidden = true
            bottomBackgroundView.isHidden = true
            curatorNameLabel.snp.makeConstraints {
                $0.leading.equalToSuperview().offset(16)
            }
        }
        
        curatorProfileImageView.makeRounded(cornerRadius: curatorProfileImageView.frame.width / 2)
        sentencesBackgroundView.layer.cornerRadius = 25
        sentencesBackgroundView.clipsToBounds = true
        writeInThemeButton.backgroundColor = .softGreen
        // .layerMaxXMinYCorner : 오른쪽 위
        // .layerMaxXMaxYCorner : 오른쪽 아래
        // .layerMinXMaxYCorner : 왼쪽 아래
        // .layerMinXMinYCorner : 왼쪽 위
        sentencesBackgroundView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
    }
    
    func setThemeData(){
        ThemeService.shared.getThemeInfo(idx: self.themeIdx ?? 0) { networkResult in
            switch networkResult {
            case .success(let data):
                if let _data = data as? ThemeInfoData {
                    self.themeData = _data.theme[0]
                    self.sentences = _data.sentence
                    self.updateLayout()
                    self.sentenceTableView.reloadData()
                    self.showToast(text: "연결성공")
                }
                
            case .requestErr(let msg):
                self.showToast(text: msg as! String)
            case .pathErr:
                self.showToast(text: "pathErr")
            case .serverErr:
                self.showToast(text: "serverErr")
            case .networkFail:
                self.showToast(text: "networkFail")
            }
        }
    }
    
    func updateLayout(){
        self.themeNameLabel.text = self.themeData?.theme
        self.themeImageView.imageFromUrl(self.themeData?.themeImg, defaultImgPath: "themeWritingThemeXSentenceBg")
        self.curatorNameLabel.text = self.themeData?.writer
        self.curatorProfileImageView.imageFromUrl(self.themeData?.writerImg, defaultImgPath: "themeImgCurator")
        self.sentenceCountLabel.text = "\(self.themeData?.sentenceNum ?? 0)"
        self.bookmarkCountLabel.text = "\(self.themeData?.saves ?? 0)"
    }
    
    //MARK:- IBAction
    @IBAction func touchUpBackButton(sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func touchUpWriteInSentenceInThemeButton(_ sender: UIButton) {

        guard let dvc = UIStoryboard(name: "WritingSentenceInTheme", bundle: nil).instantiateViewController(identifier: "WritingSentenceInThemeVC") as? WritingSentenceInThemeVC else {
            return
        }
        self.navigationController?.pushViewController(dvc, animated: true)
    }
    
    @IBAction func touchUpBookMarkButton(sender: UIButton) {
        ThemeService.shared.putBookmark(idx: self.themeIdx ?? 0) { networkResult in
            switch networkResult {
            case .success(let data):
                if let _data = data as? ThemeBookmarkData {
                    self.bookmarkCountLabel.text = "\(_data.saves)"
                    
                    if _data.isSave {
                        self.showToast(text: "북마크 성공")
                    }
                    else {
                        self.showToast(text: "북마크 해제")
                    }
                    sender.isSelected = _data.isSave
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
}

// MARK:- Extension
// MARK: UITableViewDelegate
extension ThemeInfoVC: UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 19
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 375, height: 19))
        //view.backgroundColor = .blue
        return view
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let dvc = UIStoryboard(name: "SentenceInfo", bundle: nil).instantiateViewController(identifier: "SentenceInfoVC") as? SentenceInfoVC else {
            return
        }
//        dvc.sentenceText = self.sentences[indexPath.row]
        self.navigationController?.pushViewController(dvc, animated: true)
    }
    
}
// MARK: UITableViewDataSource
extension ThemeInfoVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sentences.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SentenceInThemeTVC.identifier,
                                                       for: indexPath) as? SentenceInThemeTVC
            else {
                return UITableViewCell()
        }
        let sentence = sentences[indexPath.row]
        cell.setData(sentence: sentence.sentence,
                     bookName: sentence.title,
                     likeCount: sentence.likes,
                     bookMarkCount: sentence.saves)
        
//        cell.sentenceLabel.text = self.sentences[indexPath.row]
        return cell
    }
}
