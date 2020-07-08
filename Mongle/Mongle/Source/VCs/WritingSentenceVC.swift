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
    
    //MARK:- User Define items
    
    let innerCircle = UIView().then{
        $0.backgroundColor = .softGreen
        
        
    }
    let outerCircle = UIView().then{
        $0.backgroundColor = .softGreen
        $0.alpha = 0.34
        
    }
  
    
    
    // MARK:- LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        xButton.setImage(UIImage(named: "warning"), for: .normal)
        
        setNextButton()
        setProgressBar()
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
    
    func setSentenceTextView(){
        self.sentenceTextView.layer.borderWidth = 1.0
        self.sentenceTextView.layer.borderColor = UIColor.black.cgColor
       
        self.sentenceTextView.placeholder =
        "최대 280자까지 입력 가능하며, 책의 문장을 임의로 \n변형하지 않게 주의해주세요!"
        self.sentenceTextView.textContainerInset = UIEdgeInsets(top: 16.0,
                                                                left: 14.0,
                                                                bottom: 0.0, right: 15.0)
        
    }
    
    func setNextButton(){
        self.nextButton.backgroundColor = .softGreen
        self.nextButton.makeRounded(cornerRadius: 25)
        
        
    }
    
    
    func partialGreenColor(){
           
           guard let text = self.noticeLabel.text else {
               return
           }
           noticeLabel.textColor = .black
           let attributedString = NSMutableAttributedString(string: noticeLabel.text!)
           attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.softGreen,
                                         range: (text as NSString).range(of: "한 문장"))
           noticeLabel.attributedText = attributedString
       }
    func setProgressBar(){
        
        self.view.addSubview(outerCircle)
        self.view.addSubview(innerCircle)
        progressBar.progressTintColor = .softGreen
        
        innerCircle.snp.makeConstraints{
            $0.width.height.equalTo(20)
            $0.centerX.equalTo(progressBar.snp_leadingMargin)
            $0.centerY.equalTo(progressBar.snp_centerYWithinMargins)
            
        }
        innerCircle.makeRounded(cornerRadius: 10)
        
        outerCircle.snp.makeConstraints{
            $0.width.height.equalTo(40)
            $0.centerX.equalTo(progressBar.snp_leadingMargin)
            $0.centerY.equalTo(progressBar.snp_centerYWithinMargins)
            
        }
        outerCircle.makeRounded(cornerRadius: 20)
        progressBar.progress = 0
        
        
        
    }
    
    

    
}

    //MARK:- Extensions


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
