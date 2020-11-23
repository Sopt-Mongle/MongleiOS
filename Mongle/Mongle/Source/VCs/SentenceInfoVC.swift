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
    
    @IBOutlet var themeImageView: UIImageView!
    @IBOutlet var themeNameLabel: UILabel!
    
    //MARK:- UI Component
    lazy var popup = MonglePopupView(frame: CGRect(x: 0, y: 0, width: 304, height: 193))
    lazy var blur = UIView().then {
        $0.backgroundColor = .black
        $0.alpha = 0.5
    }
    //MARK:- Property
    var themeText: String = " "
    var sentenceText: String = " "
    var sentence: DetailSentenceInfo?
    var themeImage: UIImage? = UIImage(named: "curatorImgTheme1")
    var otherSentences: [OtherSentence] = []
    var hasTheme: Bool = true
    var isMySentence: Bool = true
    var canDisplayOtherSentece: Bool = true
    var myNickName: String = ""
    var sentenceIdx: Int?
    var themeIdx: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addGesture()
//        bindThemeInfo()
        makeRoundTableView()
//        swipeToPop()
        navigationController?.interactivePopGestureRecognizer?.delegate = nil
        layoutTableView.delegate = self
        layoutTableView.dataSource = self
    }
    override func viewWillAppear(_ animated: Bool) {
        getSentenceInfo()
        getOtherSentece()
    }
    
    func swipeToPop() {
//        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
    }
    
    func getMyNickName(completion: @escaping (Bool, String)->()) {
        MyProfileService.shared.getMy(){ networkResult in
            
            switch networkResult {
            case .success(let theme):
                guard let data = theme as? [MyProfileData] else {
                    return
                }
                
                completion(true, data[0].name)
                
            case .requestErr(let message):
                completion(false, "")
            case .pathErr:
                
                completion(false, "")
            case .serverErr:
                completion(false, "")
            case .networkFail:
                completion(false, "")
            }
        }
    }
    
    func makeRoundTableView() {
        layoutTableView.layer.cornerRadius = 25
        layoutTableView.clipsToBounds = true
        layoutTableView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    
    func getSentenceInfo(){
        SentenceService.shared.getSentence(idx: self.sentenceIdx ?? 0) { networkResult in

            switch networkResult {
            case .success(let data):
                if let _data = data as? [DetailSentenceInfo] {
                    self.sentence = _data[0]
                    self.getThemeInfo(themeIdx: self.sentence?.themeIdx ?? 0) {
                        [weak self] (themeImage, themeName) in
                        DispatchQueue.main.async {
                            self?.themeImageView.imageFromUrl(themeImage, defaultImgPath: "themeWritingThemeXSentenceBg")
                            self?.themeNameLabel.text = themeName
                        }
                    }
                    self.getMyNickName { [weak self] (success, nickName) in
                        if success {
                            if nickName == self?.sentence?.writer {
                                self?.isMySentence = true
                    
                            }
                            else {
                                self?.isMySentence = false
                            }
                        }
                        self?.getMySaveSentence { [weak self] (success, sentenceIdxes) in
                            if success {
                                self?.sentence?.alreadyBookmarked = sentenceIdxes.contains(self?.sentenceIdx ?? 0)
                            }
                            else {
                                self?.sentence?.alreadyBookmarked = false
                            }
                            DispatchQueue.main.async {
                                self?.layoutTableView.reloadSections(IndexSet(arrayLiteral: 0), with: .automatic)
                                self?.updateStateLayout()
                            }
                        }
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
    
    func getThemeInfo(themeIdx: Int, completion: @escaping (String, String) -> Void) {
        ThemeService.shared.getThemeInfo(idx: themeIdx) { (networkResult) in
            switch networkResult {
            case .success(let themeData):
                if let _data = themeData as? ThemeInfoData {
                    completion(_data.theme[0].themeImg ?? "", _data.theme[0].theme ?? "")
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
    
    func getMySaveSentence(completion: @escaping (Bool, [Int]) -> ()) {
        MySentenceService.shared.getMy { (networkResult) in
            switch networkResult {
            case .success(let data):
                if let _data = data as? MySentenceData {
                    completion(true, _data.save.compactMap{ return $0.sentenceIdx })
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
    
//    func bindThemeInfo() {
//        themeImageView.image = themeImage
//        themeNameLabel.text = themeText
//        themeNameLabel.sizeToFit()
//    }
    
    func getOtherSentece(){
        SentenceService.shared.getOtherSentenceInTheme(idx: self.sentenceIdx ?? 0) { networkResult in
            switch networkResult {
            case .success(let data):
                if let _data = data as? [OtherSentence] {
                    
                    self.otherSentences = _data
                    self.layoutTableView.reloadSections(IndexSet(arrayLiteral: 1), with: .automatic)
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
        
//        if _sentence.alreadyLiked {
//            self.likeCountLabel.textColor = .softGreen
//
//        }
//        else {
//            self.likeCountLabel.textColor = .veryLightPink
//        }
        self.likeImageview.isHighlighted = _sentence.alreadyLiked
        self.bookmarkImageView.isHighlighted = _sentence.alreadyBookmarked
//
//        if _sentence.alreadyBookmarked {
//            self.bookCountLabel.textColor = .softGreen
//        }
//        else {
//            self.bookCountLabel.textColor = .veryLightPink
//        }
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
        let token: String = UserDefaults.standard.string(forKey: UserDefaultKeys.token.rawValue) ?? "guest"
        
        if token == "guest" {
            self.presentLoginRequestPopUp()
            return
        }
        
        SentenceService.shared.putSentenceLike(idx: self.sentenceIdx ?? 0) { networkResult in
            switch networkResult {
            case .success(let data):
                if let _data = data as? SentenceLikeData {
                    self.sentence?.alreadyLiked = _data.isLike
                    self.sentence?.likes = _data.likes
                    
                    self.updateStateLayout()
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
        let token: String = UserDefaults.standard.string(forKey: UserDefaultKeys.token.rawValue) ?? "guest"
        
        if token == "guest" {
            self.presentLoginRequestPopUp()
            return
        }
        
        SentenceService.shared.putBookmark(idx: self.sentenceIdx ?? 0) { networkResult in
            switch networkResult {
                
            case .success(let data):
                if let _data = data as? SentenceBookmarkData {
                    self.sentence?.alreadyBookmarked = _data.isSave
                    self.sentence?.saves = _data.saves
                    DispatchQueue.main.async {
                        self.updateStateLayout()
                        if _data.isSave {
                            self.showToast(text: "문장이 저장되었어요!")
                        }
                        else {
//                            self.showToast(text: "저장 해제")
                        }
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
    
    func requestDelete() {
        SentenceEditService.shared.deleteSentece(idx: sentenceIdx ?? 0) { (networkResult) in
            switch networkResult {
            case .success(_):
                if let navi = self.navigationController {
                    let prevIndex = navi.viewControllers.count
                    navi.viewControllers[prevIndex - 2].showToast(text: "문장이 삭제되었어요!")
                    navi.popViewController(animated: true)
                }
                else {
                    self.showToast(text: "문장이 삭제되었어요!", completion: {
                        self.dismiss(animated: true, completion: nil)
                    })
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
        
        popup.setPopUp(state: .delete, yesHandler: { [weak self] in
            self?.requestDelete()
            
        }, noHandler: {[weak self] in
            self?.blur.removeFromSuperview()
            self?.popup.removeFromSuperview()
            
        },confirmHandler: nil)
    
        
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
    
    func report(content: String){
        ReportService.shared.report(type: "sentence", idx: sentenceIdx ?? 0, content: content) { (networkResult) in
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
    
    @IBAction func touchUpBackButton(){
        if let navi = self.navigationController {
            navi.popViewController(animated: true)
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func touchUpOtherThemeButton(){
        
        guard let dvc = UIStoryboard(name: "ThemeInfo", bundle: nil).instantiateViewController(identifier: "ThemeInfoVC") as? ThemeInfoVC else {
            return
        }
        dvc.themeIdx = self.themeIdx
        
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
            let otherSentence = self.otherSentences[indexPath.row]
            dvc.sentenceIdx = otherSentence.sentenceIdx
            dvc.themeText = self.themeText
            dvc.themeImage = self.themeImage
            
            self.navigationController?.pushViewController(dvc, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 1 {
            return 95
        }
        return 43
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
            return UIView()
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
                $0.contentMode = .scaleAspectFit
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
                $0.top.equalToSuperview()
                $0.bottom.equalToSuperview()
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
            cell.setSentenceData(sentence: self.sentence?.sentence ?? self.sentenceText,
                                 profileImg: self.sentence?.writerImg ?? "",
                                 curatorName: self.sentence?.writer ?? "",
                                 isLiked: true,
                                 isBookmarked: true)
            cell.setBookData(bookName: self.sentence?.title ?? "",
                             writerName: self.sentence?.author ?? "",
                             publisherName: self.sentence?.publisher ?? "",
                             bookImageUrl: self.sentence?.thumbnail ?? "")
            
            cell.editButtonDelegate = { [weak self] sheet in
                
                guard let self = self else{
                    return
                }
                
                let token: String = UserDefaults.standard.string(forKey: UserDefaultKeys.token.rawValue) ?? "guest"
                
                if token == "guest" {
                    self.presentLoginRequestPopUp()
                    return
                }
                
                if self.isMySentence {
                    [
                        UIAlertAction(title: "수정",
                                      style: .default,
                                      handler:
                                        { [weak self] (action) in
                                            let sb = UIStoryboard.init(name: "SentenceEdit", bundle: nil)
                                            guard let dvc = sb.instantiateViewController(identifier: "SentenceEditVC") as? SentenceEditVC else {
                                                return
                                            }
                                            dvc.sentenceIdx = self?.sentenceIdx
                                            dvc.text = self?.sentence?.sentence
                                            self?.navigationController?.pushViewController(dvc, animated: true)
                                        })
                            .then { $0.titleTextColor = .black },
                        
                        UIAlertAction(title: "삭제",
                                      style: .default) {[weak self] action in
                            self?.showPopUp()
                        }
                        .then { $0.titleTextColor = .black },
                        UIAlertAction(title: "취소", style: .cancel) { action in
                        }
                        .then { $0.titleTextColor = .black }
                    ]
                    .forEach { sheet.addAction($0)}
                    
                    self.present(sheet, animated: true, completion: nil)
                }
                else {
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
                    .forEach { sheet.addAction($0)}
                    self.present(sheet, animated: true, completion: nil)
                }

            }
        
//            cell.editButton.isHidden = !isMySentence
            
            return cell
        }
        else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SentenceInThemeTVC.identifier, for: indexPath) as? SentenceInThemeTVC else {
                return UITableViewCell()
            }

            let otherSentnece = self.otherSentences[indexPath.row]

            cell.setData(sentence: otherSentnece.sentence,
                         bookName: otherSentnece.title ?? "",
                         likeCount: otherSentnece.likes,
                         bookMarkCount: otherSentnece.saves)
            return cell
            
        }
    }
}


//extension SentenceInfoVC: UIGestureRecognizerDelegate {
//    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRequireFailureOf otherGestureRecognizer: UIGestureRecognizer) -> Bool {
//        return true
//    }
//}
