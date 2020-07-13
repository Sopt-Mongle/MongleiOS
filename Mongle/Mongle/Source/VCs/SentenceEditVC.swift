//
//  SentenceEditVC.swift
//  Mongle
//
//  Created by 이주혁 on 2020/07/12.
//  Copyright © 2020 이주혁. All rights reserved.
//

import UIKit

class SentenceEditVC: UIViewController {

    @IBOutlet var sentenceTextView: UITextView!
    @IBOutlet var textCountLabel: UILabel!
    
    @IBOutlet var editButton: UIButton!
    
    var text: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initLayout()
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
        editButton.makeRounded(cornerRadius: 33)
        
    }
    
    
    @IBAction func touchUpBackButton(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
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
        if textView.text.count > 280 {
            return false
        }
        return true
    }
    
    
}
