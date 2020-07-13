//
//  WritingSentenceInThemeVC.swift
//  Mongle
//
//  Created by 이주혁 on 2020/07/13.
//  Copyright © 2020 이주혁. All rights reserved.
//

import UIKit

class WritingSentenceInThemeVC: UIViewController {

    //MARK:- IBOutlet
    @IBOutlet var themeBackgroundView: UIView!
    @IBOutlet var themeLabel: UILabel!
    
    @IBOutlet var sentenceTextView: UITextView!
    @IBOutlet var textCountLabel: UILabel!
    
    @IBOutlet var nextButton: UIButton!
    
    //MARK:- Property
    var isInitial: Bool = true
    
    //MARK:- LifeCycle Method
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setInitLayout()
        sentenceTextView.delegate = self
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        registerForKeyboardNotifications()
        sentenceTextView.becomeFirstResponder()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        unregisterForKeyboardNotifications()
    }
    
    
    func setInitLayout(){
        themeBackgroundView.makeRounded(cornerRadius: 10)
        themeBackgroundView.backgroundColor = UIColor(red: 188 / 255,
                                                      green: 188 / 255,
                                                      blue: 188 / 255,
                                                      alpha: 0.19)
        
        sentenceTextView.makeRounded(cornerRadius: 10)
        sentenceTextView.setBorder(borderColor: .veryLightPinkFive, borderWidth: 1.0)
        
        sentenceTextView.contentInset = UIEdgeInsets(top: 16,
                                                     left: 14,
                                                     bottom: 16,
                                                     right: 14)
        
        textCountLabel.textColor = .softGreen
        setAttributeCountLabel(count: 0)
        
        nextButton.backgroundColor = .softGreen
        nextButton.makeRounded(cornerRadius: 28)
        nextButton.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        nextButton.setTitleColor(.white, for: .normal)
        

    }
    
    func setAttributeCountLabel(count: Int){
        
        let text = "\(count)/280"
        let attributedString = NSMutableAttributedString(string: text)
        attributedString.addAttribute(NSAttributedString.Key.foregroundColor,
                                      value:UIColor.black,
                                      range: (text as NSString).range(of: "/280"))
        textCountLabel.attributedText = attributedString
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
    
    // MARK:- @objc Method
    @objc func keyboardWillShow(_ notification: NSNotification) {
        
        
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey]
            as? NSValue)?.cgRectValue {
            UIView.animate(withDuration: 0.3, animations: {
                self.nextButton.transform =
                    CGAffineTransform(translationX: 0, y: -keyboardSize.height + 16)
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
                        self.nextButton.transform = .identity
        })
        
        self.view.layoutIfNeeded()
    }
    
    @IBAction func touchUpNextButton(_ sender: UIButton) {
        
    }
    
    
}

extension WritingSentenceInThemeVC: UITextViewDelegate {
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        if isInitial {
            textView.text = ""
            textView.textColor = .black
            setAttributeCountLabel(count: 0)
        }
        
        return true
    }
    
    func textViewDidChange(_ textView: UITextView) {
        if textView.text.count == 0 {
            self.isInitial = true
        }
        
        setAttributeCountLabel(count: textView.text.count)
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if self.isInitial {
            textView.text = """
            최대 280자까지 입력 가능하며, 책의 문장을 임의로
            변형하지 않게 주의해주세요!
            """
            textView.textColor = .veryLightPink
        }
    }
}


