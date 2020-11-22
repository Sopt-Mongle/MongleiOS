//
//  MyTabVC.swift
//  Mongle
//
//  Created by 이예슬 on 7/15/20.
//  Copyright © 2020 이주혁. All rights reserved.
//

import UIKit

class MyTabVC: UIViewController {
    
    var pageInstance : MyTabPageVC?
    var observingList: [NSKeyValueObservation] = []
    var item = -1
    var myProfileData: MyProfileData?
    var themeNum = 0
    var sentenceNum = 0
    var curatorNum = 0
    var profileImg : String = ""
    var profileName: String = ""
    var profileMsg : String = ""
    var profileKeyword : String?
    var profileKeywordIdx : Int?
    var profileIntroduce = ""
    var sentenceIdx = 0
    var sentenceFlag = false
    
    let heightRatio: CGFloat = UIScreen.main.bounds.height/812
    let widthRatio: CGFloat = UIScreen.main.bounds.width/375
    let token = UserDefaults.standard.string(forKey: "token")
    //팝업뷰
    let blurImageView = UIImageView().then{
        $0.image = UIImage(named: "logoutPopupBg")
    }
    let popupView = UIView().then{
        $0.backgroundColor = .clear
    }
    var popupImageView = UIImageView().then{
        $0.image = UIImage(named: "sentenceDeleteCheckBox")
    }
    var popupTitleLabel = UILabel().then{
        $0.text = "문장을 삭제하시겠어요?"
        $0.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 15)
        $0.textColor = .black
        $0.adjustsFontSizeToFitWidth = true
    }
    var yesButton = UIButton().then{
        $0.setTitle("네", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.backgroundColor = .softGreen
        $0.makeRounded(cornerRadius: 19)
        $0.addTarget(self, action: #selector(yesButtonAction), for: .touchUpInside)
        $0.titleLabel?.font = $0.titleLabel?.font.withSize(13)
    }
    var noButton = UIButton().then{
        $0.setTitle("아니요", for: .normal)
        $0.setTitleColor(.softGreen, for: .normal)
        $0.backgroundColor = .white
        $0.makeRounded(cornerRadius: 19)
        $0.setBorder(borderColor: .softGreen, borderWidth: 1)
        $0.addTarget(self, action: #selector(noButtonAction), for: .touchUpInside)
        $0.titleLabel?.font = $0.titleLabel?.font.withSize(13)
    }
    //MARK:- IBOutlet
    @IBOutlet weak var myProfileImage: UIImageView!
    @IBOutlet weak var myNameLabel: UILabel!
    @IBOutlet weak var myKeywordLabel: UILabel!
    @IBOutlet weak var myProfileMsgLabel: UILabel!
    @IBOutlet weak var themeMenuLabel: UILabel!
    @IBOutlet weak var sentenceMenuLabel: UILabel!
    @IBOutlet weak var curatorMenuLabel: UILabel!
    @IBOutlet weak var themeMenuBTN: UIButton!
    @IBOutlet weak var sentenceMenuBTN: UIButton!
    @IBOutlet weak var curatorMenuBTN: UIButton!
    
    //MARK:- IBAction
    @IBAction func touchUpSetting(_ sender: Any) {
        guard let settingVC = UIStoryboard(name:"MySetting",bundle:nil).instantiateViewController(identifier: "MySettingVC") as? MySettingVC else{
            return
        }

       self.navigationController?.pushViewController(settingVC, animated: true)

        
    }
    @IBAction func touchUpTheme(_ sender: Any) {
        item = 0
        if item - (pageInstance?.keyValue.curPresentViewIndex)! > 0{
            pageInstance?.setViewControllers([(pageInstance?.vcArr![item])!], direction: .forward, animated: true, completion: nil)
        }
        else{
            pageInstance?.setViewControllers([(pageInstance?.vcArr![item])!], direction: .reverse, animated: true, completion: nil)
            
        }
        
        pageInstance?.keyValue.curPresentViewIndex = item
        themeMenuBTN.setTitleColor(.softGreen, for: .normal)
        themeMenuLabel.textColor = .softGreen
        sentenceMenuBTN.setTitleColor(.veryLightPink, for: .normal)
        sentenceMenuLabel.textColor = .veryLightPink
        curatorMenuBTN.setTitleColor(.veryLightPink, for: .normal)
        curatorMenuLabel.textColor = .veryLightPink
    }
    @IBAction func touchUpSentence(_ sender: Any) {
        item = 1
        if item - (pageInstance?.keyValue.curPresentViewIndex)! > 0{
            pageInstance?.setViewControllers([(pageInstance?.vcArr![item])!], direction: .forward, animated: true, completion: nil)
        }
        else{
            pageInstance?.setViewControllers([(pageInstance?.vcArr![item])!], direction: .reverse, animated: true, completion: nil)
        }
        pageInstance?.keyValue.curPresentViewIndex = item
        themeMenuBTN.setTitleColor(.veryLightPink, for: .normal)
        themeMenuLabel.textColor = .veryLightPink
        sentenceMenuBTN.setTitleColor(.softGreen, for: .normal)
        sentenceMenuLabel.textColor = .softGreen
        curatorMenuBTN.setTitleColor(.veryLightPink, for: .normal)
        curatorMenuLabel.textColor = .veryLightPink
    }
    @IBAction func touchUpCurator(_ sender: Any) {
        item = 2
        if item - (pageInstance?.keyValue.curPresentViewIndex)! > 0{
            pageInstance?.setViewControllers([(pageInstance?.vcArr![item])!], direction: .forward, animated: true, completion: nil)
            
        }
        else{
            pageInstance?.setViewControllers([(pageInstance?.vcArr![item])!], direction: .reverse, animated: true, completion: nil)
            
        }
        pageInstance?.keyValue.curPresentViewIndex = item
        themeMenuBTN.setTitleColor(.veryLightPink, for: .normal)
        themeMenuLabel.textColor = .veryLightPink
        sentenceMenuBTN.setTitleColor(.veryLightPink, for: .normal)
        sentenceMenuLabel.textColor = .veryLightPink
        curatorMenuBTN.setTitleColor(.softGreen, for: .normal)
        curatorMenuLabel.textColor = .softGreen
    }
    
    
    //MARK:- LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setMenu()
    }
    override func viewWillDisappear(_ animated: Bool) {
        observingList.forEach { $0.invalidate() }
    }
    override func viewWillAppear(_ animated: Bool) {
        if sentenceFlag{
            sentenceFlag = false
            setMySentence()
            
            DispatchQueue.main.async{
                let vc = (self.pageInstance?.vcArr?[1])! as? MyTabSentenceVC
                vc?.sentenceTableView.reloadData()
                self.pageInstance?.viewWillAppear(true)
                
            self.pageInstance?.setViewControllers([(self.pageInstance?.vcArr![1])!], direction: .forward, animated: true, completion: nil)
            self.pageInstance?.keyValue.curPresentViewIndex = 1
            }
            self.view.layoutIfNeeded()
        }
        else{
            setMyProfile()
            setMyTheme()
            setMySentence()
            setMyCurator()
            self.pageInstance?.setViewControllers([(self.pageInstance?.vcArr![0])!], direction: .forward, animated: false, completion: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "pageSegue2" {
            print("#####왜안돼1")
            pageInstance = segue.destination as? MyTabPageVC
            pageInstance?.mainVC = self
            print("#####?")
            let ob = pageInstance?.keyValue.observe(\.curPresentViewIndex,
                                                    options: [.new, .old]) {
                [weak self] (changeObject, value) in
                print("CurrentIndex\(changeObject.curPresentViewIndex))")
                if (changeObject.curPresentViewIndex == 0){
                    UIView.animate(withDuration: 0.3){
                        self!.themeMenuBTN.setTitleColor(.softGreen, for: .normal)
                        self!.themeMenuLabel.textColor = .softGreen
                        self!.sentenceMenuBTN.setTitleColor(.veryLightPink, for: .normal)
                        self!.sentenceMenuLabel.textColor = .veryLightPink
                        self!.curatorMenuBTN.setTitleColor(.veryLightPink, for: .normal)
                        self!.curatorMenuLabel.textColor = .veryLightPink
                        
                    }
                }
                else if (changeObject.curPresentViewIndex == 1){
                    UIView.animate(withDuration: 0.3){
                        self!.themeMenuBTN.setTitleColor(.veryLightPink, for: .normal)
                        self!.themeMenuLabel.textColor = .veryLightPink
                        self!.sentenceMenuBTN.setTitleColor(.softGreen, for: .normal)
                        self!.sentenceMenuLabel.textColor = .softGreen
                        self!.curatorMenuBTN.setTitleColor(.veryLightPink, for: .normal)
                        self!.curatorMenuLabel.textColor = .veryLightPink
                    }
                }
                else{
                    UIView.animate(withDuration: 0.3){
                        self!.themeMenuBTN.setTitleColor(.veryLightPink, for: .normal)
                        self!.themeMenuLabel.textColor = .veryLightPink
                        self!.sentenceMenuBTN.setTitleColor(.veryLightPink, for: .normal)
                        self!.sentenceMenuLabel.textColor = .veryLightPink
                        self!.curatorMenuBTN.setTitleColor(.softGreen, for: .normal)
                        self!.curatorMenuLabel.textColor = .softGreen
                    }
                }
                
                
                print("kvo test")
                
            }
            
            observingList.append(ob!)
            //pageInstance?.pageControlDelegate = self
        }
    }
    //MARK: - Custom Methods
    func setMyProfile(){
        MyProfileService.shared.getMy(){ networkResult in
            
            switch networkResult {
                case .success(let theme):
                    guard let data = theme as? [MyProfileData] else {
                        return
                    }
                    
                    self.myProfileData = data[0]
                    self.profileImg = self.myProfileData!.img ?? ""
                    self.profileName = self.myProfileData!.name
                    self.profileKeywordIdx = self.myProfileData!.keywordIdx ?? 1
                    self.profileIntroduce = self.myProfileData!.introduce ?? ""
                    print("##########Introduce,\(self.profileIntroduce)")
                    UserDefaults.standard.setValue(self.profileName, forKey: "UserProfileName")
                    UserDefaults.standard.setValue(self.profileImg, forKey: "UserProfileImgLink")
                    UserDefaults.standard.setValue(self.profileKeywordIdx, forKey: "UserProfileKeyIdx")
                    UserDefaults.standard.setValue(self.profileIntroduce, forKey: "UserProfileIntroduce")
                    
                    switch self.myProfileData!.keywordIdx{
                        
                        case 1:
                            self.profileKeyword = "감성자극"
                        case 2:
                            self.profileKeyword = "동기부여"
                        case 3:
                            self.profileKeyword = "자기계발"
                        case 4:
                            self.profileKeyword = "깊은생각"
                        case 5:
                            self.profileKeyword = "독서기록"
                        case 6:
                            self.profileKeyword = "일상문장"
                        default:
                            self.profileKeyword = ""
                            
                            
                    }
                    
                    DispatchQueue.main.async {
                        self.setMenu()
                        self.setProfile()
                        
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
    
    func setMenu(){
        myKeywordLabel.textColor = .brownGreyThree
        myProfileMsgLabel.textColor = .veryLightPink
        themeMenuLabel.textColor = .softGreen
        sentenceMenuLabel.textColor = .veryLightPink
        curatorMenuLabel.textColor = .veryLightPink
        themeMenuLabel.text = "\(self.themeNum)"
        sentenceMenuLabel.text = "\(self.sentenceNum)"
        curatorMenuLabel.text = "\(self.curatorNum)"
        themeMenuBTN.setTitleColor(.softGreen, for: .normal)
        sentenceMenuBTN.setTitleColor(.veryLightPink, for: .normal)
        curatorMenuBTN.setTitleColor(.veryLightPink, for: .normal)
        
    }
    func setProfile(){
        myProfileImage.makeRounded(cornerRadius: myProfileImage.frame.width/2)
        myProfileImage.contentMode = .scaleAspectFill
        myProfileImage.imageFromUrl(self.profileImg, defaultImgPath: "sentenceThemeOImgCurator1010")
        myNameLabel.text = self.profileName
        myKeywordLabel.text = self.profileKeyword
        myProfileMsgLabel.text = self.profileIntroduce
    }
    
    func setMyTheme(){
        MyThemeService.shared.getMy(){ networkResult in
            
            switch networkResult {
                case .success(let theme):
                    guard let data = theme as? MyThemeData else {
                        return
                    }
                    self.themeNum = data.save.count + data.write.count
                    DispatchQueue.main.async {
                        self.themeMenuLabel.text = "\(self.themeNum)"
                        self.pageInstance?.setViewControllers([(self.pageInstance?.vcArr![0])!], direction: .forward, animated: false, completion: nil)
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
    func setMySentence(){
        MySentenceService.shared.getMy(){ networkResult in
            
            switch networkResult {
                case .success(let theme):
                    guard let data = theme as? MySentenceData else {
                        return
                    }
                    self.sentenceNum = data.save.count + data.write.count
                    DispatchQueue.main.async {
                        self.sentenceMenuLabel.text = "\(self.sentenceNum)"
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
    func setMyCurator(){
        MyCuratorService.shared.getMy(){ networkResult in
            
            switch networkResult {
                case .success(let theme):
                    guard let data = theme as? [MyCuratorData] else {
                        return
                    }
                    
                    self.curatorNum = data.count
                    
                    DispatchQueue.main.async {
                        self.curatorMenuLabel.text = "\(self.curatorNum)"
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
    func callDeleteSentence(sentenceIdx: Int){
        SentenceEditService.shared.deleteSentece(idx: sentenceIdx){networkResult in
            switch networkResult{
            case .success(let idx):
                print("문장 인덱스 \(idx) 삭제완료")
                self.blurImageView.removeFromSuperview()
                self.popupView.removeFromSuperview()
//                self.sentenceFlag = true
                self.pageInstance!.sentenceFlag = true
                self.pageInstance?.viewDidLoad()
                
//                self.viewWillAppear(true)
//                self.setMySentence()
                //self.touchUpSentence(self.sentenceMenuBTN)
//                guard let sentenceVC = self.pageInstance?.viewControllers?[0] as? MyTabSentenceVC else{return}
//                sentenceVC.sentenceTableView.reloadData()
                
               
            case .requestErr(let message):
                print(message)
            case .pathErr:
                print("pathErr")
            case .networkFail:
                print("네트워크 오류")
            case .serverErr:
                print("서버 오류")
                
            }
        }
    }
    func showPopupView(_ popupTitle: String, _ sentenceIdx: Int){
        self.sentenceIdx = sentenceIdx
        self.view.addSubview(blurImageView)
        self.view.addSubview(popupView)
        self.popupView.addSubview(popupImageView)
        self.popupView.addSubview(popupTitleLabel)
        self.popupView.addSubview(yesButton)
        self.popupView.addSubview(noButton)
        //constraints
        self.popupTitleLabel.text = popupTitle
        self.blurImageView.snp.makeConstraints{
            $0.top.bottom.leading.trailing.equalToSuperview()
        }
        self.popupView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(310*heightRatio)
            $0.leading.equalToSuperview().offset(35*widthRatio)
            $0.bottom.equalToSuperview().offset(-309*heightRatio)
            $0.trailing.equalToSuperview().offset(-35*widthRatio)
        }
        self.popupImageView.snp.makeConstraints{
            $0.top.bottom.leading.trailing.equalToSuperview()
        }
        self.popupTitleLabel.snp.makeConstraints{
            $0.top.equalToSuperview().offset(81*heightRatio)
            $0.bottom.equalToSuperview().offset(-94*heightRatio)
            $0.centerX.equalToSuperview()
        }

        self.yesButton.snp.makeConstraints{
            $0.top.equalToSuperview().offset(131*heightRatio)
            $0.bottom.equalToSuperview().offset(-25*heightRatio)
            $0.leading.equalToSuperview().offset(20*widthRatio)
            $0.trailing.equalToSuperview().offset(-157*widthRatio)
        }
        self.noButton.snp.makeConstraints{
            $0.top.equalToSuperview().offset(131*heightRatio)
            $0.bottom.equalToSuperview().offset(-25*heightRatio)
            $0.leading.equalToSuperview().offset(161*widthRatio)
            $0.trailing.equalToSuperview().offset(-16*widthRatio)
        }
        
    }
    
    @objc func yesButtonAction(){
        callDeleteSentence(sentenceIdx: self.sentenceIdx)
    }
    @objc func noButtonAction(){
        blurImageView.removeFromSuperview()
        popupView.removeFromSuperview()
    }

    
}

struct MyProfileStruct{
    var curatorIdx: Int = 0
    var name: String = ""
    var image: UIImage?
    var introduce: String?
    var keywordIdx: Int?
    var subscribe: Int = 0
}

