//
//  WritingSentenceVC.swift
//  Mongle
//
//  Created by Yunjae Kim on 2020/07/07.
//  Copyright © 2020 이주혁. All rights reserved.
//

import UIKit
import SnapKit
import Then

class WritingSentenceVC: UIViewController,UITextViewDelegate {

    //MARK:- IBOutlets
    
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var sentenceTextView: UITextView!
    @IBOutlet weak var xButton: UIButton!
    @IBOutlet weak var noticeLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var placeholderLabel: UILabel!
    @IBOutlet weak var textQuantityLabel: UILabel!
    @IBOutlet weak var warningImageView: UIImageView!
    @IBOutlet weak var warningLabel: UILabel!
    
    //MARK:- User Define items
    
    let innerCircle = UIView().then{
        $0.backgroundColor = .brownGreyThree
        
        
    }
    let outerCircle = UIView().then{
        $0.backgroundColor = .brownGreyThree
        $0.alpha = 0.34
        
    }
    
    let innerCircle2 = UIView().then{
         $0.backgroundColor = .softGreen
         
         
     }
     let outerCircle2 = UIView().then{
         $0.backgroundColor = .softGreen
         $0.alpha = 0.34
         
         
     }
    
    let smallCircle = UIView().then{
        $0.backgroundColor = .veryLightPinkSeven
        
        
    }
    
    let smallCircle2 = UIView().then{
        $0.backgroundColor = .veryLightPinkSeven
        
        
    }
    
    let smallCircle3 = UIView().then{
        $0.backgroundColor = .veryLightPinkSeven
        
        
    }
    
 
  
    
    
    // MARK:- LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setSmallBalls()
        xButton.setImage(UIImage(named: "writingThemeBtnClose")?.withRenderingMode(.alwaysOriginal),
                         for: .normal)
        setSentenceTextView()
        setNextButton()
        setProgressBar()
        sentenceTextView.delegate = self
        textQuantityLabel.text = "0/280"
        textQuantityLabel.textColor = .veryLightPink
        warningLabel.textColor = .reddish
        warningImageView.image = UIImage(named: "warning")
        warningLabel.alpha = 0
        warningImageView.alpha = 0
        
    
        partialGreenColor()
        
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
    
        sentenceTextView.becomeFirstResponder()
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow(_:)), name:
            UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)),
                                               name:
        UIResponder.keyboardWillHideNotification, object: nil)
       
        
//        if WritingSentenceSecondVC.isVisited == true{
//            UIView.animate(withDuration: 0.0, animations: {
//                self.progressBar.progress = 0.0
//            })
//            
//            self.outerCircle2.alpha = 0.34
//            self.innerCircle2.alpha = 1
//            
////            self.secondToFirstLevelAnimation()
//            
//          
//        
//        }
    }
    override func viewDidDisappear(_ animated: Bool) {
//        self.progressBar.progress = 0
//        progressBar.layoutIfNeeded()
    }
    
    
    // MARK:- User Define Functions
    
    @objc func keyboardWillShow(_ notification: NSNotification) {
        
        
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey]
            as? NSValue)?.cgRectValue {
            UIView.animate(withDuration: 0.0, animations: {
                self.nextButton.transform =
                    CGAffineTransform(translationX: 0, y: -keyboardSize.height)
            })
            setSentenceTextView()
            self.view.layoutIfNeeded()
            
            
        }
    }
    
    @objc func keyboardWillHide(_ notification: NSNotification) {
          guard let duration =
            notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey]
              as? Double else {return}
          guard let curve = notification.userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey]
              as? UInt else {return}
          
          UIView.animate(withDuration: duration, delay: 0.0, options: .init(rawValue: curve),
                         animations: {
              self.nextButton.transform = .identity
          })
          
          self.view.layoutIfNeeded()
      }
    func textViewDidChange(_ textView: UITextView) {
        if sentenceTextView.text.count == 1 {
            placeholderLabel.alpha = 0
            textQuantityLabel.text = String(sentenceTextView.text.count) + "/280"
            warningLabel.alpha = 0
            warningImageView.alpha = 0
            sentenceTextView.setBorder(borderColor: .veryLightPinkFive, borderWidth: 1.0)
            ballAppearAnimation()
           
            
            
        }
        else if sentenceTextView.text.count == 0{
            placeholderLabel.alpha = 1
            textQuantityLabel.text = "0/280"
            textQuantityLabel.textColor = .veryLightPink
            
            ballHideAnimation()
        }
        else{
            
            textQuantityLabel.text = String(sentenceTextView.text.count) + "/280"
            
        }
        partialGreenColor2()
        
    }
    
    func setSentenceTextView(){
        self.sentenceTextView.layer.borderWidth = 1.0
        self.sentenceTextView.layer.borderColor = UIColor.veryLightPinkFive.cgColor
        self.sentenceTextView.makeRounded(cornerRadius: 10)
       
        self.placeholderLabel.text =
        "최대 280자까지 입력 가능하며, 책의 문장을 임의로 \n변형하지 않게 주의해주세요!"
        self.sentenceTextView.textContainerInset = UIEdgeInsets(top: 16.0,
                                                                left: 14.0,
                                                                bottom: 0.0, right: 15.0)
        placeholderLabel.textColor = .veryLightPink
        
    }
    
    func partialGreenColor2(){
        
        
        guard let text = self.textQuantityLabel.text else {
            return
        }
        textQuantityLabel.textColor = .softGreen
        let attributedString = NSMutableAttributedString(string: textQuantityLabel.text!)
        attributedString.addAttribute(NSAttributedString.Key.foregroundColor,
                                      value: UIColor.veryLightPink,
                                      range: (text as NSString).range(of: "/280"))
        if sentenceTextView.text == "" {
            textQuantityLabel.textColor = .veryLightPink
        }
        
        
        textQuantityLabel.attributedText = attributedString
    }
   
    
    
   
    
    func setNextButton(){
        self.nextButton.backgroundColor = .softGreen
        self.nextButton.makeRounded(cornerRadius: 25)
        
        
    }
    
    
    
    
    @IBAction func nextButtonAction(_ sender: Any) {
        guard let vcName = UIStoryboard(name: "WritingSentenceSecond",
                                               bundle: nil).instantiateViewController(
                                                withIdentifier: "WritingSentenceSecondVC")
            as? WritingSentenceSecondVC
            else{
                return
        }
        vcName.modalPresentationStyle = .currentContext
        
        
        
        if sentenceTextView.text == ""{
            warningLabel.alpha = 1
            warningImageView.alpha = 1
            sentenceTextView.setBorder(borderColor: .reddish, borderWidth: 1.0)
        }
        
        else {
            
            vcName.setProgressBar()
            self.present(vcName, animated: true, completion: nil)
        }
//        self.progressBar.progress = 0.5
        
        
        
    }
    func partialGreenColor(){
           
           guard let text = self.noticeLabel.text else {
               return
           }
           noticeLabel.textColor = .black
           let attributedString = NSMutableAttributedString(string: noticeLabel.text!)
           attributedString.addAttribute(NSAttributedString.Key.foregroundColor,
                                         value: UIColor.softGreen,
                                         range: (text as NSString).range(of: "한 문장"))
           noticeLabel.attributedText = attributedString
       }
    
    func setSmallBalls(){
        self.view.addSubview(smallCircle)
        self.view.addSubview(smallCircle2)
        self.view.addSubview(smallCircle3)
        smallCircle.snp.makeConstraints{
            $0.width.height.equalTo(9)
            $0.leading.equalToSuperview().offset(24)
            $0.centerY.equalTo(progressBar)
            
        }
        smallCircle.makeRounded(cornerRadius: 4.5)
        
        smallCircle2.snp.makeConstraints{
            $0.width.height.equalTo(9)
            $0.center.equalTo(progressBar)
        }
        smallCircle2.makeRounded(cornerRadius: 4.5)
        
        smallCircle3.snp.makeConstraints{
            $0.width.height.equalTo(9)
            $0.trailing.equalToSuperview().offset(-24)
            $0.centerY.equalTo(progressBar)
            
        }
        smallCircle3.makeRounded(cornerRadius: 4.5)
        
        
        
    }
    
    
    
    func ballAppearAnimation(){
        UIView.animate(withDuration: 0.5 , delay: 0.25, options: [.curveEaseIn], animations: {

            self.outerCircle.backgroundColor = .softGreen
            self.innerCircle.backgroundColor = .softGreen
            
            
        }, completion:nil)
        
    }
    
    func ballHideAnimation(){
        UIView.animate(withDuration: 0.5 , delay: 0.25, options: [.curveEaseIn], animations: {

            self.outerCircle.backgroundColor = .brownGreyThree
            self.innerCircle.backgroundColor = .brownGreyThree
            
            
        }, completion:nil)
        
    }
    
   
    
    
    func setProgressBar(){
        
        self.view.addSubview(outerCircle)
        self.view.addSubview(innerCircle)
        self.view.addSubview(outerCircle2)
        self.view.addSubview(innerCircle2)
        
       
        self.innerCircle2.snp.makeConstraints{
            $0.width.height.equalTo(9)
            $0.centerX.equalTo(self.progressBar.snp_centerXWithinMargins)
            $0.centerY.equalTo(self.progressBar.snp_centerYWithinMargins)
            
            
        }
        innerCircle2.makeRounded(cornerRadius: 6)
        innerCircle2.alpha = 0
        
        
        self.outerCircle2.snp.makeConstraints{
            $0.width.height.equalTo(26)
            $0.centerX.equalTo(self.progressBar.snp_centerXWithinMargins)
            $0.centerY.equalTo(self.progressBar.snp_centerYWithinMargins)
            
        }
        outerCircle2.makeRounded(cornerRadius: 13)
        outerCircle2.alpha = 0
        
     
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
        innerCircle.alpha = 1
        outerCircle.alpha = 0.34
        progressBar.progress = 0
        
        
        
        
        
    }
    
    
    
    
    func secondToFirstLevelAnimation(){
        
        self.outerCircle2.alpha = 0
        self.innerCircle2.alpha = 0
        self.progressBar.setProgress(0, animated: true)
        UIView.animate(withDuration: 3, animations: {
            self.progressBar.layoutIfNeeded()
        })

    }
    
    
    @IBAction func xButtonAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    
}

//MARK:- Extensions
