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
        setMyProfile()
        setMyTheme()
        setMySentence()
        setMyCurator()
        self.pageInstance?.setViewControllers([(self.pageInstance?.vcArr![0])!], direction: .forward, animated: false, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "pageSegue2" {
            print("#####왜안돼1")
            pageInstance = segue.destination as? MyTabPageVC
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
                    self.profileKeywordIdx = self.myProfileData!.keywordIdx
                    self.profileIntroduce = self.myProfileData?.introduce ?? ""
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
        myProfileMsgLabel.text = self.profileMsg
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
    
    
}

struct MyProfileStruct{
    var curatorIdx: Int = 0
    var name: String = ""
    var image: UIImage?
    var introduce: String?
    var keywordIdx: Int?
    var subscribe: Int = 0
}

