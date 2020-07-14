//
//  CuratorTabInfo.swift
//  Mongle
//
//  Created by 이예슬 on 7/13/20.
//  Copyright © 2020 이주혁. All rights reserved.
//

import UIKit

class CuratorTabInfoVC: UIViewController {
    
    let menuItem = ["테마","문장","큐레이터"]
    var pageInstance : CuratorTabInfoPageVC?
    var observingList: [NSKeyValueObservation] = []
    var searchKeyword:String = ""
    
    
    //MARK: - IBOutlet
    @IBOutlet weak var curatorImageView: UIImageView!
    @IBOutlet weak var curatorNameLabel: UILabel!
    @IBOutlet weak var curatorKeywordLabel: UILabel!
    @IBOutlet weak var curatorMsgLabel: UILabel!
    @IBOutlet weak var subscribeBTN: UIButton!
    @IBOutlet weak var themeMenuLabel: UILabel!
    @IBOutlet weak var sentenceMenuLabel: UILabel!
    @IBOutlet weak var themeMenuBTN: UIButton!
    @IBOutlet weak var sentenceMenuBTN: UIButton!
    
    @IBAction func touchUpSubscribe(_ sender: Any) {
        subscribeBTN.isSelected.toggle()
        //print(subscribeBTN.isSelected)
        if subscribeBTN.isSelected {
            subscribeBTN.setTitle("구독중",for: .normal)
            subscribeBTN.backgroundColor = .veryLightPinkSeven
            subscribeBTN.setTitleColor(UIColor(red:181/255,green:181/255,blue:181/255, alpha:1.0), for: .normal)
        }
        else{
            subscribeBTN.setTitle("구독",for: .normal)
            subscribeBTN.backgroundColor = .softGreen
            subscribeBTN.setTitleColor(.white, for: .normal)
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
        sentenceMenuBTN.setTitleColor(.veryLightPink, for: .normal)
        sentenceMenuLabel.textColor = .veryLightPink
    }
    
    @IBAction func touchUpSentence(_ sender: Any) {
        pageInstance?.setViewControllers([(pageInstance?.vcArr![1])!], direction: .forward, animated: true, completion: nil)
        pageInstance?.keyValue.curPresentViewIndex = 1
        themeMenuBTN.setTitleColor(.veryLightPink, for: .normal)
        themeMenuLabel.textColor = .veryLightPink
        sentenceMenuBTN.setTitleColor(.softGreen, for: .normal)
        sentenceMenuLabel.textColor = .softGreen
    }
    //MARK:- LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setSubscribeBTN()
        setMenu()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        observingList.forEach { $0.invalidate() }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "pageSegue" {
            pageInstance = segue.destination as? CuratorTabInfoPageVC
            pageInstance?.searchKey = self.searchKeyword
            let ob = pageInstance?
                .keyValue
                .observe(\.curPresentViewIndex,
                         options: [.new, .old]) {
                            [weak self] (changeObject, value) in

                            if (changeObject.curPresentViewIndex == 0){
                                UIView.animate(withDuration: 0.3){
                                    self!.themeMenuBTN.setTitleColor(.softGreen, for: .normal)
                                    self!.themeMenuLabel.textColor = .softGreen
                                    self!.sentenceMenuBTN.setTitleColor(.veryLightPink, for: .normal)
                                    self!.sentenceMenuLabel.textColor = .veryLightPink
                                    
                                }
                            }
                            else{
                                UIView.animate(withDuration: 0.3){
                                    self!.themeMenuBTN.setTitleColor(.veryLightPink, for: .normal)
                                    self!.themeMenuLabel.textColor = .veryLightPink
                                    self!.sentenceMenuBTN.setTitleColor(.softGreen, for: .normal)
                                    self!.sentenceMenuLabel.textColor = .softGreen
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
        subscribeBTN.backgroundColor = .softGreen
    }
    func setMenu(){
        curatorKeywordLabel.textColor = .brownGreyThree
        curatorMsgLabel.textColor = .veryLightPink
        themeMenuLabel.textColor = .softGreen
        sentenceMenuLabel.textColor = .veryLightPink
        themeMenuLabel.text = "47"
        sentenceMenuLabel.text = "36"
        themeMenuBTN.setTitleColor(.softGreen, for: .normal)
        sentenceMenuBTN.setTitleColor(.veryLightPink, for: .normal)
        
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
