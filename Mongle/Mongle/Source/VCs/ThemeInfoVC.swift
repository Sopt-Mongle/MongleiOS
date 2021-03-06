//
//  ThemeInfoVC.swift
//  Mongle
//
//  Created by 이주혁 on 2020/07/10.
//  Copyright © 2020 이주혁. All rights reserved.
//

import UIKit
import Kingfisher

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
    @IBOutlet var themeBlurView: UIView!
    
    @IBOutlet var blurImageView: UIImageView!
    
    @IBOutlet var bottomBackgroundView: UIView!
    @IBOutlet var sentencesBackGroudViewBottomConstraint: NSLayoutConstraint!

    @IBOutlet var buttonSpaceConstraint: NSLayoutConstraint!
    @IBOutlet var saveButton: UIButton!
    @IBOutlet var backButton: UIButton!
    //MARK:- Property
    var themeImage: UIImage?
    var hasTheme: Bool = true
    var themeIdx: Int?
    var themeData: Theme?
    var sentences: [Sentence] = []
    
    var noThemeSentence: [NoThemeSentence] = []
    var noThemeCount: Int = 0
    var themeText: String?
    
    var noThemeSentenceSelectedDelegate:(NoThemeSentence)->Void = { _ in }
//    var selectBookDelegate: BookSearchDataDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setInitLayout()
//        setBlur()
        navigationController?.interactivePopGestureRecognizer?.delegate = nil
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setThemeData()
    }
    func setBlur() {
        // 1
        themeBlurView.backgroundColor = .clear
        // 2
        let blurEffect = UIBlurEffect(style: .light)
        let vibrancyEffect = UIVibrancyEffect(blurEffect: blurEffect)
        let vibrancyView = UIVisualEffectView(effect: vibrancyEffect)
        
        vibrancyView.translatesAutoresizingMaskIntoConstraints = false
        // 3
//        vibrancyView.contentView.addSubview(optionsView)
        // 3
        let blurView = UIVisualEffectView(effect: blurEffect)
        // 4
        blurView.translatesAutoresizingMaskIntoConstraints = false
        blurView.contentView.addSubview(vibrancyView)
        
        themeBlurView.insertSubview(blurView, at: 0)
        
        blurView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
        vibrancyView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    func setInitLayout(){
        themeBackgroundView.backgroundColor = .clear
        if UIScreen.main.bounds.width > 400 {
            buttonSpaceConstraint.constant = UIScreen.main.bounds.width * 5 / 100
        }
        else {
            buttonSpaceConstraint.constant = UIScreen.main.bounds.width * 3.5 / 100
        }
        
        
        
//        if hasTheme {
//            
//            self.themeNameLabel.text = themeText ?? ""
//            sentencesBackGroudViewBottomConstraint.constant = 0
//            bottomBackgroundView.isHidden = false
//            themeImageView.image = themeImage
////                UIImage(named: "sentenceThemeOImgTheme")
//        }
//        else {
//            themeNameLabel.text = "테마 없는 문장"
//            backButton.setImage(UIImage(named: "sentenceThemeXBtnBack"), for: .normal)
//            themeImageView.image = UIImage(named: "themeWritingThemeXSentenceBg")
//            sentencesBackgroundView.backgroundColor = .black
//            sentencesBackGroudViewBottomConstraint.constant = -bottomBackgroundView.frame.height
//            
//            curatorProfileImageView.isHidden = true
//            themeInfoStackView.isHidden = true
//            bottomBackgroundView.isHidden = true
//            curatorNameLabel.snp.makeConstraints {
//                $0.leading.equalToSuperview().offset(16)
//            }
//        }
        sentenceTableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: bottomBackgroundView.frame.height, right: 0)
        
//        writeInThemeButton.makeRounded(cornerRadius: self.writeInThemeButton.bounds.width * 31 / 253)
        
//        saveButton.makeRounded(cornerRadius: saveButton.bounds.width * 31 / 77)
//        saveButton.setBorder(borderColor: .veryLightPinkSix, borderWidth: 1)
        curatorProfileImageView.makeRounded(cornerRadius: curatorProfileImageView.frame.width / 2)
        sentencesBackgroundView.layer.cornerRadius = 25
        sentencesBackgroundView.clipsToBounds = true
//        writeInThemeButton.backgroundColor = .softGreen
        // .layerMaxXMinYCorner : 오른쪽 위
        // .layerMaxXMaxYCorner : 오른쪽 아래
        // .layerMinXMaxYCorner : 왼쪽 아래
        // .layerMinXMinYCorner : 왼쪽 위
        sentencesBackgroundView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        
    }
    
    func setThemeData(){
        
        if self.hasTheme {
            ThemeService.shared.getThemeInfo(idx: self.themeIdx ?? 0) { networkResult in
                switch networkResult {
                case .success(let data):
                    if let _data = data as? ThemeInfoData {
                        self.themeData = _data.theme[0]
                        self.getMySaveTheme { [weak self] (success, indexes) in
                            if success {
                                self?.themeData?.alreadyBookmarked = indexes.contains(self?.themeIdx ?? 0)
                            }
                            else {
                                self?.themeData?.alreadyBookmarked = false
                            }
                            self?.sentences = _data.sentence
                            DispatchQueue.main.async {
                                self?.updateLayout()
                                self?.sentenceTableView.reloadData()
                            }
                        }
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
//        else {
//            ThemeService.shared.getNoThemeSentenceInfo{ networkResult in
//                switch networkResult {
//                case .success(let data):
//                    if let _data = data as? NoThemeData {
//                        self.noThemeCount = _data.num
//                        self.noThemeSentence = _data.sentences
//                        self.curatorNameLabel.text = "문장 \(_data.num)개"
//                        self.sentenceTableView.reloadData()
//                    }
//                case .requestErr(let msg):
//                    self.showToast(text: msg as? String ?? "")
//                case .pathErr:
//                    self.showToast(text: "pathErr")
//                case .serverErr:
//                    self.showToast(text: "serverErr")
//                case .networkFail:
//                    self.showToast(text: "networkFail")
//                }
//            }
//        }
    }
    
    func updateLayout(){
        self.themeNameLabel.text = self.themeData?.theme
//        self.blurImageView.image = UIImage(
//        print(blurImageView.image)
        self.themeImageView.imageFromUrl(self.themeData?.themeImg)
//        self.themeImageView.imageFromUrl(self.themeData?.themeImg, defaultImgPath: "", completion: { [weak self] in
//            print("image upload success")
//
//            DispatchQueue.main.async {
//
//                let image = self?.blurImageView.image?.makeImageBlurEffect()
//
//                self?.blurImageView.image = image
//
//            }
//        } )
        
        self.curatorNameLabel.text = self.themeData?.writer
        self.curatorProfileImageView.imageFromUrl(self.themeData?.writerImg, defaultImgPath: "themeImgCurator")
        self.sentenceCountLabel.text = "\(self.themeData?.sentenceNum ?? 0)"
        self.bookmarkCountLabel.text = "\(self.themeData?.saves ?? 0)"
        self.saveButton.isSelected = self.themeData?.alreadyBookmarked ?? false
    }
    
    func report(content: String){
        ReportService.shared.report(type: "theme", idx: themeIdx ?? 0, content: content) { (networkResult) in
            switch networkResult {
            case .success(_):
                if content == "falseAd" {
                    self.showToast(text: "허위 내용 신고가 접수되었어요!")
                }
                else {
                    self.showToast(text: "부적절한 내용 신고가 접수되었어요!")
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
    func getMySaveTheme(completion: @escaping (Bool, [Int]) -> ()) {
        MyThemeService.shared.getMy { (networkResult) in
            switch networkResult {
            case .success(let data):
                if let _data = data as? MyThemeData {
                    
                    completion(true, _data.save.compactMap{
                        return $0.themeIdx
                    })
                    
                }
            case .requestErr(let msg):
//                self.showToast(text: msg as? String ?? "requestErr")
                completion(false, [])
            case .pathErr:
                self.showToast(text: "pathErr")
                completion(false, [])
            case .serverErr:
                self.showToast(text: "serverErr")
                completion(false, [])
            case .networkFail:
                self.showToast(text: "networkFail")
                completion(false, [])
            }
        }
    }
    //MARK:- IBAction
    
    @IBAction func touchUpReportButton(_ sender: Any) {
        let token: String = UserDefaults.standard.string(forKey: UserDefaultKeys.token.rawValue) ?? "guest"
        
        if token == "guest" {
            self.presentLoginRequestPopUp()
            return
        }
        
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        [
            UIAlertAction(title: "허위 내용 신고",
                          style: .default,
                          handler: { [weak self] action in
                            
                            self?.report(content: "falseAd")
                          })
                .then { $0.titleTextColor = .black },
            UIAlertAction(title: "부적절한 내용 신고",
                          style: .default,
                          handler: { [weak self] action in
                            self?.report(content: "inappropriate")
                          })
                .then{ $0.titleTextColor = .black },
            UIAlertAction(title: "취소",
                          style: .cancel,
                          handler: nil)
                .then { $0.titleTextColor = .black}
        ]
        .forEach { actionSheet.addAction($0)}
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    @IBAction func touchUpBackButton(sender: UIButton) {
        
        if let navi = self.navigationController {
            navi.popViewController(animated: true)
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func touchUpWriteInSentenceInThemeButton(_ sender: UIButton) {
        
        let token: String = UserDefaults.standard.string(forKey: UserDefaultKeys.token.rawValue) ?? "guest"
        
        if token == "guest" {
            self.presentLoginRequestPopUp()
            return
        }
        guard let dvc = UIStoryboard(name: "WritingSentenceInTheme", bundle: nil).instantiateViewController(identifier: "WritingSentenceInThemeNavi") as? UINavigationController else {
            return
        }
        
        guard let root = dvc.topViewController as? WritingSentenceInThemeVC else {
            return
        }
        root.themeIdx = self.themeIdx
        root.themeName = self.themeData?.theme
        dvc.modalPresentationStyle = .fullScreen
        
        self.present(dvc, animated: true, completion: nil)
    }
    
    @IBAction func touchUpBookMarkButton(sender: UIButton) {
        let token: String = UserDefaults.standard.string(forKey: UserDefaultKeys.token.rawValue) ?? "guest"
        
        if token == "guest" {
            self.presentLoginRequestPopUp()
            return
        }
        
        ThemeService.shared.putBookmark(idx: self.themeIdx ?? 0) { networkResult in
            switch networkResult {
            case .success(let data):
                if let _data = data as? ThemeBookmarkData {
                    self.bookmarkCountLabel.text = "\(_data.saves)"
                    
                    if _data.isSave {
                        self.showToast(text: "테마가 저장되었어요!")
                    }
                    else {
//                        self.showToast(text: "북마크 해제")
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
        if hasTheme {
            let sentence = self.sentences[indexPath.row]
            guard let dvc = UIStoryboard(name: "SentenceInfo", bundle: nil).instantiateViewController(identifier: "SentenceInfoVC") as? SentenceInfoVC else {
                return
            }
            dvc.themeIdx = self.themeIdx ?? 0
            dvc.themeText = self.themeNameLabel.text ?? ""
            dvc.hasTheme = hasTheme
            dvc.themeImage = self.themeImageView.image
            dvc.sentenceIdx = sentence.sentenceIdx
            self.navigationController?.pushViewController(dvc, animated: true)
        }
        else {
            let sentence = self.noThemeSentence[indexPath.row]
            self.noThemeSentenceSelectedDelegate(sentence)
            dump(sentence)
            self.dismiss(animated: true, completion: nil)
        }
    }
}
// MARK: UITableViewDataSource
extension ThemeInfoVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.hasTheme {
            return self.sentences.count
        }
        else {
            return self.noThemeSentence.count
        }
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SentenceInThemeTVC.identifier,
                                                       for: indexPath) as? SentenceInThemeTVC
            else {
                return UITableViewCell()
        }
        
        if self.hasTheme {
            let sentence = sentences[indexPath.row]
            cell.setData(sentence: sentence.sentence,
                         bookName: sentence.title ?? "",
                         likeCount: sentence.likes,
                         bookMarkCount: sentence.saves)
            
        }
        else {
            print(indexPath.row)
            let sentence = self.noThemeSentence[indexPath.row]
            cell.setNoThemeData(sentence: sentence.sentence,
                                bookName: sentence.title)
        }
        
        //        cell.sentenceLabel.text = self.sentences[indexPath.row]
        return cell
    }
}
