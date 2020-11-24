//
//  SentenceEditVC.swift
//  Mongle
//
//  Created by 이주혁 on 2020/07/12.
//  Copyright © 2020 이주혁. All rights reserved.
//

import UIKit

class SentenceEditVC: UIViewController {

    // MARK:- IBOutlet
    @IBOutlet var sentenceTextView: UITextView!
    @IBOutlet var textCountLabel: UILabel!
    @IBOutlet var editButton: UIButton!
    
    // MARK:- Property
    var text: String?
    var sentenceIdx: Int?
    
    // MARK:- Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initLayout()
        sentenceTextView.autocorrectionType = .no
    }
    
    override func viewWillAppear(_ animated: Bool) {
        registerForKeyboardNotifications()
        sentenceTextView.becomeFirstResponder()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        unregisterForKeyboardNotifications()
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
    
    // MARK:- @objc
    @objc func keyboardWillShow(_ notification: NSNotification) {
        
        
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey]
            as? NSValue)?.cgRectValue {
            UIView.animate(withDuration: 0.0, animations: {
                self.editButton.transform =
                    CGAffineTransform(translationX: 0, y: -keyboardSize.height + 40)
            })
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
              self.editButton.transform = .identity
          })
          
          self.view.layoutIfNeeded()
      }
    
    func initLayout(){
        // textview
        sentenceTextView.text = text ?? ""
        sentenceTextView.contentInset = UIEdgeInsets(top: 16, left: 14, bottom: 16, right: 14)
        sentenceTextView.makeRounded(cornerRadius: 10)
        sentenceTextView.setBorder(borderColor: .veryLightPinkFive, borderWidth: 1.0)
        
        sentenceTextView.delegate = self
        
        //count label
        let count = sentenceTextView.text.count
        textCountLabel.textColor = .softGreen
        
        let countText = "\(count)/280"
        let attributedString = NSMutableAttributedString(string: countText)
        attributedString.addAttribute(NSAttributedString.Key.foregroundColor,
                                      value: UIColor.black,
                                      range: (countText as NSString).range(of: "/280"))
        textCountLabel.attributedText = attributedString
        
        // button
        editButton.backgroundColor = .softGreen
        editButton.setTitle("수정하기", for: .normal)
        editButton.setTitleColor(.white, for: .normal)
        editButton.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        editButton.makeRounded(cornerRadius: 28)
        
    }
    
    func requestEdit() {
        SentenceEditService.shared.editSentence(idx: sentenceIdx ?? 0, sentence: sentenceTextView.text) { (networkResult) in
            switch networkResult {
            case .success(_):
                let prevIndex = self.navigationController?.viewControllers.count
                self.navigationController?.viewControllers[prevIndex! - 2].showToast(text: "문장이 수정되었어요!")
                self.navigationController?.popViewController(animated: true)
                
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
    
    //MARK:- IBAction
    @IBAction func touchUpBackButton(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func touchEditButton(_ sender: UIButton) {
        
        self.requestEdit()
    }
    
}

extension SentenceEditVC: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        
        guard let countText = sentenceTextView.text else {
            return
        }
        
        if sentenceTextView.text.count >= 280 {
            sentenceTextView.text = text
        }
        else {
            text = sentenceTextView.text
        }
        
        let newText = "\(countText.count)/280"
        
         let attributedString = NSMutableAttributedString(string: newText)
        
         attributedString.addAttribute(NSAttributedString.Key.foregroundColor,
                                       value: UIColor.black,
                                       range: (newText as NSString).range(of: "/280"))
        
         textCountLabel.attributedText = attributedString
        

    }
    
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        textView.setBorder(borderColor: .softGreen, borderWidth: 1.0)
        if textView.text.count > 280 {
            return false
        }
        return true
    }
}
