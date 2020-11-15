//
//  CuratorTabInfo.swift
//  Mongle
//
//  Created by 이예슬 on 7/13/20.
//  Copyright © 2020 이주혁. All rights reserved.
//

import UIKit

class CuratorTabInfoVC: UIViewController {
    
    let token = UserDefaults.standard.string(forKey: "token")
    
    var pageInstance : CuratorTabInfoPageVC?
    var observingList: [NSKeyValueObservation] = []
    var curatorIdx = -1
    var curatorProfileData: [CuratorProfile] = []
    var curatorData:CuratorInfoData?
    var themeNum = 0
    var sentenceNum = 0
    
    
    //MARK: - IBOutlet
    @IBOutlet weak var curatorImageView: UIImageView!
    @IBOutlet weak var curatorNameLabel: UILabel!
    @IBOutlet weak var curatorKeywordLabel: UILabel!
    @IBOutlet weak var curatorMsgLabel: UILabel!
    @IBOutlet weak var subscribeBTN: UIButton!
    @IBOutlet weak var themeMenuLabel: UILabel!
    @IBOutlet weak var themeMenuText: UILabel!
    @IBOutlet weak var sentenceMenuText: UILabel!
    @IBOutlet weak var sentenceMenuLabel: UILabel!
    @IBOutlet weak var themeMenuBTN: UIButton!
    @IBOutlet weak var sentenceMenuBTN: UIButton!
    
    @IBAction func touchUpSubscribe(_ sender: Any) {
        if token == "guest"{
            self.presentLoginRequestPopUp()
        }
        else{
            follow(idx: curatorIdx)
        }
      
    }
    @IBAction func touchUpBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func touchUpTheme(_ sender: Any) {
        pageInstance?.setViewControllers([(pageInstance?.vcArr![0])!], direction: .reverse, animated: true, completion: nil)
        pageInstance?.keyValue.curPresentViewIndex = 0
        themeMenuBTN.setTitleColor(.softGreen, for: .normal)
        themeMenuLabel.textColor = .softGreen
        themeMenuText.textColor = .softGreen
        sentenceMenuBTN.setTitleColor(.veryLightPink, for: .normal)
        sentenceMenuLabel.textColor = .veryLightPink
        sentenceMenuText.textColor = .veryLightPink
    }
    
    @IBAction func touchUpSentence(_ sender: Any) {
        pageInstance?.setViewControllers([(pageInstance?.vcArr![1])!], direction: .forward, animated: true, completion: nil)
        pageInstance?.keyValue.curPresentViewIndex = 1
        themeMenuBTN.setTitleColor(.veryLightPink, for: .normal)
        themeMenuLabel.textColor = .veryLightPink
        themeMenuText.textColor = .veryLightPink
        sentenceMenuBTN.setTitleColor(.softGreen, for: .normal)
        sentenceMenuLabel.textColor = .softGreen
        sentenceMenuText.textColor = .softGreen
    }
    
    //MARK:- LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        subscribeBTN.setTitle("구독중",for: .selected)
        subscribeBTN.setTitleColor(UIColor(red:181/255,green:181/255,blue:181/255, alpha:1.0), for: .selected)
        subscribeBTN.setTitle("구독",for: .normal)
        subscribeBTN.setTitleColor(.white, for: .normal)
        curatorImageView.contentMode = .scaleAspectFill
        setMenu()
        themeMenuBTN.isSelected = true
        themeMenuText.textColor = .softGreen
        sentenceMenuText.textColor = .veryLightPink
    }
    override func viewWillAppear(_ animated: Bool){
        getCuratorData()
        
        self.curatorImageView.makeRounded(cornerRadius: self.curatorImageView.frame.width/2)
    }
    override func viewWillDisappear(_ animated: Bool) {
        observingList.forEach { $0.invalidate() }
    }
    //MARK: - Custom Methods
    func getCuratorData(){
        CuratorInfoService.shared.getCuratorInfo(curatorIdx: self.curatorIdx){ networkResult in
            switch networkResult {
            case .success(let curatorInfo):
                guard let data = curatorInfo as? CuratorInfoData else {
                    return
                }
                self.curatorData = data
                self.themeNum = data.theme.count
                self.sentenceNum = data.sentence.count
                self.curatorProfileData = data.profile
                self.curatorNameLabel.text = self.curatorProfileData[0].name
                self.curatorImageView.imageFromUrl(self.curatorProfileData[0].img, defaultImgPath: "sentenceThemeOImgCurator1010")
                self.curatorKeywordLabel.text = self.curatorProfileData[0].keyword
                self.curatorMsgLabel.text = self.curatorProfileData[0].introduce
                self.subscribeBTN.isSelected = self.curatorProfileData[0].alreadySubscribed
                if self.curatorProfileData[0].alreadySubscribed{
                    self.subscribeBTN.backgroundColor = .veryLightPinkSeven
                }
                else{
                    self.subscribeBTN.backgroundColor = .softGreen
                }
                DispatchQueue.main.async{
                    self.setMenu()
                    self.setSubscribeBTN()
                }
                print("큐레이터 정보: \(data)개")
                //self.pageInstance?.curatorIdx = self.curatorIdx
                
                
                
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

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "pageSegue" {
            pageInstance = segue.destination as? CuratorTabInfoPageVC
            pageInstance?.curatorIdx = self.curatorIdx
            let ob = pageInstance?
                .keyValue
                .observe(\.curPresentViewIndex,
                         options: [.new, .old]) {
                            [weak self] (changeObject, value) in
                            
                            if (changeObject.curPresentViewIndex == 0){
                                UIView.animate(withDuration: 0.3){
                                    self!.themeMenuBTN.isSelected = true
                                    self!.themeMenuLabel.textColor = .softGreen
                                    self!.sentenceMenuBTN.isSelected = false
                                    self!.sentenceMenuLabel.textColor = .veryLightPink
                                    self!.themeMenuText.textColor = .softGreen
                                    self!.sentenceMenuText.textColor = .veryLightPink
                                    
                                }
                            }
                            else{
                                UIView.animate(withDuration: 0.3){
                                    self!.sentenceMenuBTN.isSelected = true
                                    self!.sentenceMenuLabel.textColor = .softGreen
                                    self!.themeMenuBTN.isSelected = false
                                    self!.themeMenuLabel.textColor = .veryLightPink
                                    self!.themeMenuText.textColor = .veryLightPink
                                    self!.sentenceMenuText.textColor = .softGreen
                                }
                            }
                            
                            
                            print("kvo test")
                            
            }
            
            observingList.append(ob!)
            //pageInstance?.pageControlDelegate = self
        }
    }
    func setSubscribeBTN(){
        
        subscribeBTN.layer.cornerRadius = subscribeBTN.frame.width/4
        
        if subscribeBTN.isSelected {
            subscribeBTN.backgroundColor = .veryLightPinkSeven
        }
        else{
            subscribeBTN.backgroundColor = .softGreen
        }
    }
    func setMenu(){
        curatorNameLabel.textColor = .greyishBrown
        curatorKeywordLabel.textColor = .brownGreyThree
        curatorMsgLabel.textColor = .veryLightPink
        themeMenuLabel.textColor = .softGreen
        sentenceMenuLabel.textColor = .veryLightPink
        themeMenuLabel.text = "\(self.themeNum)"
        sentenceMenuLabel.text = "\(self.sentenceNum)"
        themeMenuBTN.setTitleColor(.softGreen, for: .selected)
        themeMenuBTN.setTitleColor(.veryLightPink, for: .normal)
        sentenceMenuBTN.setTitleColor(.veryLightPink, for: .normal)
        sentenceMenuBTN.setTitleColor(.softGreen, for: .selected)
        
    }
    
    func follow(idx: Int){
        CuratorFollowService.shared.follow(followedIdx: idx){ networkResult in
            switch networkResult {
            case .success(let searchResult):
                guard let data = searchResult as? Bool else {
                    return
                }
                print(data)
                if data{
                    self.subscribeBTN.isSelected = data
                    self.subscribeBTN.backgroundColor = .veryLightPinkSeven
                }
                else{
                    self.subscribeBTN.isSelected = data
                    self.subscribeBTN.backgroundColor = .softGreen
                }
                
            case .requestErr(let message):
                
                guard let message = message as? String else { return }
                
                
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
