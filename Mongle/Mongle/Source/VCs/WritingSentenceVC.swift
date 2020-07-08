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
    
    
    
    // MARK:- LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        if sentenceTextView.text == ""{
//            textViewDidEndEditing(sentenceTextView)
//
//        }

        setNextButton()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        sentenceTextView.becomeFirstResponder()
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow(_:)), name:
            UIResponder.keyboardWillShowNotification, object: nil)
        
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
    
    func setSentenceTextView(){
        self.sentenceTextView.layer.borderWidth = 1.0
        self.sentenceTextView.layer.borderColor = UIColor.black.cgColor
       
        self.sentenceTextView.placeholder = "최대 280자까지 입력 가능하며, 책의 문장을 임의로 \n변형하지 않게 주의해주세요!"
        self.sentenceTextView.textContainerInset = UIEdgeInsets(top: 16.0, left: 14.0, bottom: 0.0, right: 38.0)
        
    }
    
    func setNextButton(){
        self.nextButton.backgroundColor = .softGreen
        self.nextButton.makeRounded(cornerRadius: 25)
        
        
    }
    

    
}


extension UITextView: UITextViewDelegate {
    
    /// Resize the placeholder when the UITextView bounds change
    override open var bounds: CGRect {
        didSet {
            self.resizePlaceholder()
        }
    }
    
    /// The UITextView placeholder text
    public var placeholder: String? {
        get {
            var placeholderText: String?
            
            if let placeholderLabel = self.viewWithTag(100) as? UILabel {
                placeholderText = placeholderLabel.text
            }
            
            return placeholderText
        }
        set {
            if let placeholderLabel = self.viewWithTag(100) as! UILabel? {
                placeholderLabel.text = newValue
                placeholderLabel.sizeToFit()
            } else {
                self.addPlaceholder(newValue!)
            }
        }
    }
    
    /// When the UITextView did change, show or hide the label based on if the UITextView is empty or not
    ///
    /// - Parameter textView: The UITextView that got updated
    public func textViewDidChange(_ textView: UITextView) {
        if let placeholderLabel = self.viewWithTag(100) as? UILabel {
            placeholderLabel.isHidden = !self.text.isEmpty
        }
    }
    
    /// Resize the placeholder UILabel to make sure it's in the same position as the UITextView text
    private func resizePlaceholder() {
        if let placeholderLabel = self.viewWithTag(100) as! UILabel? {
            let labelX = self.textContainer.lineFragmentPadding + 14
            let labelY = self.textContainerInset.top + 7
            let labelWidth = self.frame.width - (labelX * 2)
            let labelHeight = placeholderLabel.frame.height*2
            placeholderLabel.numberOfLines = 0;

            placeholderLabel.frame = CGRect(x: labelX, y: labelY,
                                            width: labelWidth, height: labelHeight)
        }
    }
    
    /// Adds a placeholder UILabel to this UITextView
    private func addPlaceholder(_ placeholderText: String) {
        let placeholderLabel = UILabel()
        
        placeholderLabel.text = placeholderText
        placeholderLabel.sizeToFit()
        
        placeholderLabel.font = self.font
        placeholderLabel.textColor = .veryLightPinkFive
        placeholderLabel.tag = 100
        
        placeholderLabel.isHidden = !self.text.isEmpty
        
//        self.textContainerInset = UIEdgeInsets(top: 18.0, left: 200.0, bottom: 0.0, right: 38.0)
//        self.contentInset = UIEdgeInsets(top: 18, left: 14, bottom: 0, right: 38)
    
        self.addSubview(placeholderLabel)
        self.resizePlaceholder()
        self.delegate = self
    }
    
}
