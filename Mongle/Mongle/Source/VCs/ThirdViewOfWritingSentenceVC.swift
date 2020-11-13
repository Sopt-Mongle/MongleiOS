//
//  ThirdViewOfWritingSentenceVC.swift
//  Mongle
//
//  Created by Yunjae Kim on 2020/07/10.
//  Copyright © 2020 이주혁. All rights reserved.
//

import UIKit

class ThirdViewOfWritingSentenceVC: UIViewController {
    
    //MARK:- IBOutlets
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var themeTextView: UITextView!
    @IBOutlet weak var selectButton: UIButton!
    @IBOutlet weak var registButton: UIButton!
    @IBOutlet weak var warningImageView: UIImageView!
    @IBOutlet weak var warningLabel: UILabel!
    
    
    //MARK:- User Define Variables
    let innerCircle = UIView().then{
        $0.backgroundColor = .softGreen
    }
    let outerCircle = UIView().then{
        $0.backgroundColor = .softGreen
        $0.alpha = 0.34
        
    }
    let innerCircle2 = UIView().then{
        $0.backgroundColor = .softGreen
    }
    let outerCircle2 = UIView().then{
        $0.backgroundColor = .softGreen
        $0.alpha = 0.34
    }
    
    let innerCircle3 = UIView().then{
        $0.backgroundColor = .brownGreyThree
    }
    let outerCircle3 = UIView().then{
        $0.backgroundColor = .brownGreyThree
        $0.alpha = 0.34
    }
    
    let smallCircle = UIView().then{
        $0.backgroundColor = .veryLightPinkSeven
        
        
    }
    
    var textViewInput : String?
    var fromAfterView : Bool =  false
    var isSelected : Bool = false
    var sentenceForPost : String = ""
    var bookForPost : String = ""
    var authorForPost : String = ""
    var publisherForPost : String = ""
    var themeNameForPost : String = ""
    
    var themeIdxForPost : Int = 0
    
    //MARK:- LifeCycle Methods

    

    override func viewDidLoad() {
        
//        self.progressBar.setProgress(0.5, animated: false)
        self.progressBar.progress = 0.5
        super.viewDidLoad()
        themeTextView.isEditable = false
        themeTextView.backgroundColor = .whiteThree
        setWarning()
        setItems()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
     
        setSmallBalls()
        setProgressBar()
        
        if self.isSelected == true {
            self.themeTextView.text = self.textViewInput
            ballAppearAnimation()
            hideWarning()
            
        }
       
        
        
       
    }
    
    
    

    //MARK:- User Define Functions
    
    func setItems(){
        backButton.setImage(UIImage(named: "searchBtnBack")?.withRenderingMode(.alwaysOriginal),
                            for: .normal)
        themeTextView.setBorder(borderColor: .veryLightPinkFive, borderWidth: 1.0)
        themeTextView.makeRounded(cornerRadius: 10)
        selectButton.setBorder(borderColor: .softGreen, borderWidth: 1.0)
        selectButton.makeRounded(cornerRadius: 10)
        selectButton.setTitleColor(.softGreen, for: .normal)
        registButton.backgroundColor = .softGreen
        registButton.setTitleColor(.white, for: .normal)
        registButton.makeRounded(cornerRadius: 25)
        
        themeTextView.isEditable = false
        themeTextView.backgroundColor = .whiteThree
        themeTextView.textContainerInset = UIEdgeInsets(top: 16.0,
                                                                       left: 14.0,
                                                                       bottom: 0.0, right: 14.0)
        
    }
    
    func setSmallBalls(){
        self.view.addSubview(smallCircle)
       
        
        smallCircle.snp.makeConstraints{
            $0.width.height.equalTo(9)
            $0.trailing.equalToSuperview().offset(-24)
            $0.centerY.equalTo(progressBar)
            
        }
        smallCircle.makeRounded(cornerRadius: 4.5)
        
    }
    func setProgressBar(){
    
        self.view.addSubview(outerCircle)
        self.view.addSubview(innerCircle)
        self.view.addSubview(outerCircle2)
        self.view.addSubview(innerCircle2)
        self.view.addSubview(outerCircle3)
        self.view.addSubview(innerCircle3)
        
        progressBar.progressTintColor = .softGreen
        
        innerCircle.snp.makeConstraints{
            $0.width.height.equalTo(12)
            $0.leading.equalToSuperview().offset(23)
            $0.centerY.equalTo(progressBar.snp_centerYWithinMargins)
            
        }
        innerCircle.makeRounded(cornerRadius: 6)
        
        outerCircle.snp.makeConstraints{
            $0.width.height.equalTo(26)
            $0.leading.equalToSuperview().offset(16)
            $0.centerY.equalTo(progressBar.snp_centerYWithinMargins)
            
        }
        outerCircle.makeRounded(cornerRadius: 13)
        innerCircle2.snp.makeConstraints{
            $0.width.height.equalTo(12)
            $0.centerX.equalTo(self.progressBar.snp_centerXWithinMargins)
            $0.centerY.equalTo(self.progressBar.snp_centerYWithinMargins)
            
        }
        innerCircle2.makeRounded(cornerRadius: 6)
        
        outerCircle2.snp.makeConstraints{
            $0.width.height.equalTo(26)
            $0.centerX.equalTo(self.progressBar.snp_centerXWithinMargins)
            $0.centerY.equalTo(self.progressBar.snp_centerYWithinMargins)
            
        }
        outerCircle2.makeRounded(cornerRadius: 13)
        thirdLevelAnimation()
//        self.progressBar.progress = 1.0
        self.innerCircle3.snp.makeConstraints{
            $0.width.height.equalTo(12)
            $0.trailing.equalToSuperview().offset(-23)
            $0.centerY.equalTo(self.progressBar.snp_centerYWithinMargins)
            
        }
         self.innerCircle3.makeRounded(cornerRadius: 6)
         
         self.outerCircle3.snp.makeConstraints{
             $0.width.height.equalTo(26)
            $0.trailing.equalToSuperview().offset(-16)
             $0.centerY.equalTo(self.progressBar.snp_centerYWithinMargins)
             
        }
        self.outerCircle3.makeRounded(cornerRadius: 13)
        outerCircle3.alpha = 0
        innerCircle3.alpha = 0
        self.outerCircle3.alpha = 0.34
        self.innerCircle3.alpha = 1
        
    }
    
    func setWarning(){
        warningImageView.image = UIImage(named: "warning")
        warningLabel.textColor = .reddish
        warningImageView.alpha = 0
        warningLabel.alpha = 0
        
        
        
    }
    
    func showWarning(){
        warningLabel.alpha = 1
        warningImageView.alpha = 1
        selectButton.setBorder(borderColor: .reddish, borderWidth: 1.0)
        
        
    }
    func hideWarning(){
        warningLabel.alpha = 0
        warningImageView.alpha = 0
        selectButton.setBorder(borderColor: .veryLightPinkFive, borderWidth: 1.0)
    }
    
    
    func thirdLevelAnimation() {
        
//                 progressBar.setProgress(0.55, animated: false)
        
         
         UIView.animate(withDuration: 0.5, delay: 0.0, animations: {
            
//             self.progressBar.layoutIfNeeded()
             
         }, completion: { finished in
            self.progressBar.progress = 1.0
           
             
             
             
             UIView.animate(withDuration: 0.75 , delay: 0.0, options: [.curveEaseIn], animations: {
                 self.progressBar.layoutIfNeeded()
             }, completion:nil)
         })
         
         
         
     }
    
    func ballAppearAnimation(){
        UIView.animate(withDuration: 0.5 , delay: 0.25, options: [.curveEaseIn], animations: {
            self.outerCircle3.backgroundColor = .softGreen
            self.innerCircle3.backgroundColor = .softGreen
            
        }, completion:nil)
    }

    @IBAction func backButtonAction(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
        
    }
    
    
    @IBAction func selectButtonAction(_ sender: Any) {
        guard let vcName = UIStoryboard(name: "ThemeSelectForWriteSentence",
                                        bundle: nil).instantiateViewController(
                                            withIdentifier: "ThemeSelectForWritingSentenceVC")
            as? ThemeSelectForWritingSentenceVC
            else{
                return
        }
        
        vcName.themeDelegate = self
        vcName.modalPresentationStyle = .fullScreen
        self.present(vcName, animated: true, completion: nil)
        
        
        
    }
    
    
    func postSentence(){
        PostBookService.shared.postBook(sentence: sentenceForPost  , title: bookForPost, author: authorForPost, publisher: publisherForPost, themeIdx: themeIdxForPost) { networkResult in
            switch networkResult{
            case .success(_) :
                
                
                guard let vcName = UIStoryboard(name: "EndOfWritingSentence",
                                                bundle: nil).instantiateViewController(
                                                    withIdentifier: "EndOfWritingSentenceVC")
                        
                    as? EndOfWritingSentenceVC
                    else{
                        return
                }
                vcName.modalPresentationStyle = .currentContext
                self.navigationController?.pushViewController(vcName, animated: true)
            case .requestErr(let message):
                guard let message = message as? String else {return}
                print(message)
            case .pathErr: print("path")
            case .serverErr: print("sever")
            case .networkFail: print("net")
                
                
            }
            
            
            
            
        }
    }
    
    
    @IBAction func registerButtonAction(_ sender: Any) {
        if themeTextView.text == "" {
            showWarning()
            
        }
        
        else {
            
            postSentence()
            
//            guard let vcName = UIStoryboard(name: "EndOfWritingSentence",
//                                            bundle: nil).instantiateViewController(
//                                                withIdentifier: "EndOfWritingSentenceVC")
//                as? EndOfWritingSentenceVC
//                else{
//                    return
//            }
//            vcName.modalPresentationStyle = .currentContext
//            self.navigationController?.pushViewController(vcName, animated: true)
        }
        
    }
    
    
    
}

extension ThirdViewOfWritingSentenceVC : ThemeSendDelegate {
    func sendTheme(themeText: String, isSelected: Bool, fromAfter: Bool, themeIdx : Int) {
        self.textViewInput = themeText
        self.isSelected = isSelected
        self.fromAfterView = fromAfter
        self.themeIdxForPost = themeIdx

    }
}



protocol ThemeSendDelegate {
    func sendTheme(themeText : String, isSelected : Bool, fromAfter : Bool,themeIdx : Int)
}
