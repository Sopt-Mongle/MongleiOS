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
        // Do any additional setup after loading the view.
    }
    override func viewWillDisappear(_ animated: Bool) {
        observingList.forEach { $0.invalidate() }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "pageSegue" {
            pageInstance = segue.destination as? MyTabPageVC
            let ob = pageInstance?.keyValue.observe(\.curPresentViewIndex,
                         options: [.new, .old]) {
                            [weak self] (changeObject, value) in
                            print(changeObject.curPresentViewIndex)
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

    func setMenu(){
        myKeywordLabel.textColor = .brownGreyThree
        myProfileMsgLabel.textColor = .veryLightPink
        themeMenuLabel.textColor = .softGreen
        sentenceMenuLabel.textColor = .veryLightPink
        curatorMenuLabel.textColor = .veryLightPink
        themeMenuLabel.text = "47"
        sentenceMenuLabel.text = "36"
        curatorMenuLabel.text = "23"
        themeMenuBTN.setTitleColor(.softGreen, for: .normal)
        sentenceMenuBTN.setTitleColor(.veryLightPink, for: .normal)
        curatorMenuBTN.setTitleColor(.veryLightPink, for: .normal)
        
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
