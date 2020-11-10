//
//  SignUpEmailVC.swift
//  Mongle
//
//  Created by Yunjae Kim on 2020/11/07.
//  Copyright © 2020 이주혁. All rights reserved.
//

import UIKit

class SignUpEmailVC: UIViewController, UITextFieldDelegate{
    
    //MARK: -IBOutlets
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var backButtonIMage: UIImageView!
    @IBOutlet weak var resendButton: UIButton!
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var emailMongleImage: UIImageView!
    @IBOutlet weak var noticeImage: UIImageView!
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet var wordTexts: [UITextField]!
    
    @IBOutlet var textCircles: [UIImageView]!
    
    @IBOutlet weak var askButtonImage: UIImageView!
    @IBOutlet weak var askButton: UIButton!
    @IBOutlet weak var submitButton: UIButton!
    
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
    
    var wordIndex = 0
    var isEdited : [Bool] = [false,false,false,false,false,false]
    var timer = Timer()
    var leftTime = 300
    var startTimer = false
    var ballIsGreen = false
    
    
    //MARK: - Functions
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setItems()
        setTextFields()
        
        // Do any additional setup after loading the view.
    }
    
    //MARK: - constraints
    
    @IBOutlet weak var batToMongle: NSLayoutConstraint!
    
    @IBOutlet weak var mongleToLabel: NSLayoutConstraint!
    
    @IBOutlet weak var labelToNotice: NSLayoutConstraint!
    
    @IBOutlet weak var noticeToTime: NSLayoutConstraint!
    
    @IBOutlet weak var timeToStack: NSLayoutConstraint!
    
    @IBOutlet weak var stackToButton: NSLayoutConstraint!
    
    
    @IBOutlet weak var statckToButtonImage: NSLayoutConstraint!
    @IBOutlet weak var buttonToButton: NSLayoutConstraint!
    
    
    //MARK: - LifeCycle Methods
    
    override func viewWillAppear(_ animated: Bool) {
        
        
        setProgressBar()
        registerForKeyboardNotifications()
        thirdLevelAnimation()
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        unregisterForKeyboardNotifications()
        
    }
    
    
    
    //MARK:- User Define Functions
    
    
    
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
            $0.leading.equalToSuperview().offset(35)
            $0.centerY.equalTo(progressBar.snp_centerYWithinMargins)
            
        }
        innerCircle.makeRounded(cornerRadius: 6)
        
        outerCircle.snp.makeConstraints{
            $0.width.height.equalTo(26)
            $0.leading.equalToSuperview().offset(28)
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
        //        self.progressBar.progress = 1.0
        self.innerCircle3.snp.makeConstraints{
            $0.width.height.equalTo(12)
            $0.trailing.equalToSuperview().offset(-35)
            $0.centerY.equalTo(self.progressBar.snp_centerYWithinMargins)
            
        }
        self.innerCircle3.makeRounded(cornerRadius: 6)
        
        self.outerCircle3.snp.makeConstraints{
            $0.width.height.equalTo(26)
            $0.trailing.equalToSuperview().offset(-28)
            $0.centerY.equalTo(self.progressBar.snp_centerYWithinMargins)
            
        }
        self.outerCircle3.makeRounded(cornerRadius: 13)
        outerCircle3.alpha = 0
        innerCircle3.alpha = 0
        self.outerCircle3.alpha = 0.34
        self.innerCircle3.alpha = 1
        
    }
    
    func setItems(){
        timeLabel.text = "5:00"
        backButtonIMage.image = UIImage(named: "joinStep32BtnBack")
        emailMongleImage.image = UIImage(named: "joinStep32ImgMail")
        noticeImage.image = UIImage(named: "mongleMongleCom")
        askButtonImage.image = UIImage(named: "joinStep32BtnHelp")
        
        submitButton.backgroundColor = .softGreen
        submitButton.makeRounded(cornerRadius: 25)
        timeLabel.textColor = .softGreen
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timeLimit), userInfo: nil, repeats: true)
        resendButton.backgroundColor = .veryLightPinkFive
        resendButton.makeRounded(cornerRadius: 15)
        resendButton.setTitleColor(.brownishGrey, for: .normal)
        setConstraints()
        UIView.animate(withDuration: 0.0, delay: 0.0, animations: {
            
            
        }, completion: {finished in
            UIView.animate(withDuration: 0.5, animations: {
                self.wordTexts[0].becomeFirstResponder()
                
            })
        })
        
        
    }
    
    func setConstraints(){
        
        batToMongle.constant = 103.5
        mongleToLabel.constant = 92
        labelToNotice.constant = 16
        noticeToTime.constant = 48
        
        timeToStack.constant = 14
        stackToButton.constant = 62
        statckToButtonImage.constant = 70
        buttonToButton.constant = 14
        
        
    }
    
    @objc func timeLimit(){
        if leftTime > 0 {
            leftTime -= 1
            if leftTime%60 < 10 {
                timeLabel.text = "\(leftTime/60):0\(leftTime%60)"
            }
            else{
                timeLabel.text = "\(leftTime/60):\(leftTime%60)"
            }
            
            
        }
        
        
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
    func setTextFields(){
        for tf in wordTexts {
            tf.addTarget(self, action:#selector(textFieldDidChange),
                         for: .editingChanged)
            tf.makeRounded(cornerRadius: 15)
            tf.setBorder(borderColor: UIColor(red: 1, green: 1, blue: 1, alpha: 0.0), borderWidth: 1.0)
            tf.delegate = self
            tf.textColor = .softGreen
        }
        for circle in textCircles{
            
            circle.image = UIImage(named: "joinStep3IcNumber2")
            circle.dropShadow(color: .black, offSet: CGSize(width: 0, height: 0), opacity: 0.16, radius: 5)
            
            
        }
        
        
        
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        switch textField {
        case wordTexts[0]:
            textCircles[0].image = UIImage(named: "joinStep3IcNumber1")
            textCircles[0].dropShadow(color: .lightMintGreen, offSet: CGSize(width: 0, height: 0), opacity: 1.0, radius: 6)
        case wordTexts[1]:
            textCircles[1].image = UIImage(named: "joinStep3IcNumber1")
            textCircles[1].dropShadow(color: .lightMintGreen, offSet: CGSize(width: 0, height: 0), opacity: 1.0, radius: 6)
        case wordTexts[2]:
            textCircles[2].image = UIImage(named: "joinStep3IcNumber1")
            textCircles[2].dropShadow(color: .lightMintGreen, offSet: CGSize(width: 0, height: 0), opacity: 1.0, radius: 6)
        case wordTexts[3]:
            textCircles[3].image = UIImage(named: "joinStep3IcNumber1")
            textCircles[3].dropShadow(color: .lightMintGreen, offSet: CGSize(width: 0, height: 0), opacity: 1.0, radius: 6)
        case wordTexts[4]:
            textCircles[4].image = UIImage(named: "joinStep3IcNumber1")
            textCircles[4].dropShadow(color: .lightMintGreen, offSet: CGSize(width: 0, height: 0), opacity: 1.0, radius: 6)
        case wordTexts[5]:
            textCircles[5].image = UIImage(named: "joinStep3IcNumber1")
            textCircles[5].dropShadow(color: .lightMintGreen, offSet: CGSize(width: 0, height: 0), opacity: 1.0, radius: 6)
            
        default:
            return
        }
        
        
        
    }
    func ballAppearAnimation(){
        UIView.animate(withDuration: 0.5 , delay: 0.25, options: [.curveEaseIn], animations: {
            self.outerCircle3.backgroundColor = .softGreen
            self.innerCircle3.backgroundColor = .softGreen
            
        }, completion:nil)
    }
    
    func ballHideAnimation(){
        UIView.animate(withDuration: 0.5 , delay: 0.25, options: [.curveEaseIn], animations: {
            
            self.outerCircle3.backgroundColor = .brownGreyThree
            self.innerCircle3.backgroundColor = .brownGreyThree
            
            
        }, completion:nil)
        
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        
        for i in 0...5 {
            if textField == wordTexts[i] {
                
                if textField.text == ""{
                    textCircles[i].image = UIImage(named: "joinStep3IcNumber2")
                    textCircles[i].dropShadow(color: .black, offSet: CGSize(width: 0, height: 0), opacity: 0.16, radius: 5)
                }
                
                
            }
            
        }
        
        
        
        
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        textField.text = ""
        
        for i in 0...4 {
            if textField == wordTexts[i] {
                wordIndex = i+1
            }
        }
        
        var isFinished = true
        for tf in wordTexts {
            if tf.text == ""{
                
                if ballIsGreen{
                    ballHideAnimation()
                }
                ballIsGreen = false
                isFinished = false
                
            }
            
            
        }
        
        if isFinished && !ballIsGreen{
            ballIsGreen = true
            ballAppearAnimation()
        }
        
        return true
    }
    
    func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow(_:)), name:
                                                UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name:
                                                UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func unregisterForKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name:
                                                    UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name:
                                                    UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    
    @objc func keyboardWillShow(_ notification: NSNotification) {
        
        
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey]
                                as? NSValue)?.cgRectValue {
            UIView.animate(withDuration: 0.3, animations: {
                self.batToMongle.constant = 38.5
                self.mongleToLabel.constant = 20
                self.labelToNotice.constant = 9
                self.noticeToTime.constant = 10
                
                self.timeToStack.constant = 7
                self.stackToButton.constant = 7
                self.statckToButtonImage.constant = 16
                self.buttonToButton.constant = 7
            },completion: { finished in
//                UIView.animate(withDuration: 0.12, animations: {
//                    self.emailMongleImage.transform = CGAffineTransform(rotationAngle: 360/180)
//
//
//                }, completion: { finish in
//                    UIView.animate(withDuration: 0.12, animations: {
//                        self.emailMongleImage.transform = CGAffineTransform(rotationAngle: -360/180)
//
//
//                    },completion: { finish in
//
//                        UIView.animate(withDuration: 0.34, animations: {
//                            self.emailMongleImage.transform = CGAffineTransform(rotationAngle: 0/180)
//                        })
//
//                    })
//
//
//
//                })
                
                
            })
            self.view.layoutIfNeeded()
            
            
        }
    }
    
    @objc func keyboardWillHide(_ notification: NSNotification) {
        guard let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey]
                as? Double else {return}
        guard let curve = notification.userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey]
                as? UInt else {return}
        
        UIView.animate(withDuration: duration, delay: 0.0, options: .init(rawValue: curve),
                       animations: {
                        self.batToMongle.constant = 103.5
                        self.mongleToLabel.constant = 92
                        self.labelToNotice.constant = 16
                        self.noticeToTime.constant = 48
                        
                        self.timeToStack.constant = 14
                        self.stackToButton.constant = 62
                        self.statckToButtonImage.constant = 70
                        self.buttonToButton.constant = 14
                       })
        
        self.view.layoutIfNeeded()
    }
    
    @objc func textFieldDidChange(){
        
        wordTexts[wordIndex].becomeFirstResponder()
        var isFinished = true
        for tf in wordTexts {
            if tf.text == ""{
                
                if ballIsGreen{
                    ballHideAnimation()
                }
                ballIsGreen = false
                isFinished = false
                
            }
            
            
        }
        
        if isFinished && !ballIsGreen{
            ballIsGreen = true
            ballAppearAnimation()
        }
        
    }
    
    
    
    
    @IBAction func backButtonAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
        
        
        
    }
    
}