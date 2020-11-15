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
    @IBOutlet var callInNoThemeSentenceButton: UIButton!
    
    //MARK:- Property
    var themeIdx: Int?
    var themeName: String?
    var selectedSentence: NoThemeSentence?
    var isSentenceSelected: Bool = false
    
    
    //MARK:- UI Component
    lazy var warningImageView: UIImageView = UIImageView().then {
        $0.frame = CGRect(x: 0, y: 0, width: 15, height: 15)
        $0.image = UIImage(named: "warning")
        
    }
    lazy var warningLabel: UILabel = UILabel().then {
        $0.frame = CGRect(x: 0, y: 0, width: 109, height: 16)
        $0.textColor = .reddish
        $0.text = "한 문장을 적어주세요!"
        $0.sizeToFit()
        $0.font = UIFont.systemFont(ofSize: 13)
    }
    
    lazy var warningStackView: UIStackView = UIStackView().then {
        $0.frame = CGRect(x: 100, y: 100, width: 0, height: 0)
        $0.axis = .horizontal
        $0.alignment = .center
        $0.spacing = 8
    }
    
    //MARK:- Property
    var isInitial: Bool = true
    var text: String = ""
    
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
        print(#function)
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
        sentenceTextView.setBorder(borderColor: .softGreen, borderWidth: 1)
        sentenceTextView.contentInset = UIEdgeInsets(top: 16,
                                                     left: 14,
                                                     bottom: 16,
                                                     right: 14)
        sentenceTextView.autocorrectionType = .no
        
        
        textCountLabel.textColor = .softGreen
        setAttributeCountLabel(count: 0)
        
        // next button
        nextButton.backgroundColor = .softGreen
        nextButton.makeRounded(cornerRadius: 28)
        nextButton.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        nextButton.setTitleColor(.white, for: .normal)
        setNonWarningState()
        
        self.themeLabel.text = self.themeName

    }
    
    func setAttributeCountLabel(count: Int){
        
        let text = "\(count)/280"
        let attributedString = NSMutableAttributedString(string: text)
        attributedString.addAttribute(NSAttributedString.Key.foregroundColor,
                                      value:UIColor.veryLightPink,
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
    
    func setWarningState(){
        // stackview
        warningStackView.addArrangedSubview(warningImageView)
        warningStackView.addArrangedSubview(warningLabel)
        warningStackView.sizeToFit()
        
        self.view.addSubview(warningStackView)
        warningStackView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(16)
            $0.top.equalTo(sentenceTextView.snp.bottom).offset(9)
        }
        callInNoThemeSentenceButton.snp.remakeConstraints {
            $0.top.equalTo(warningStackView.snp.bottom)
            $0.leading.equalToSuperview().offset(16)
            $0.width.equalTo(129)
            $0.height.equalTo(42)
        }
        sentenceTextView.setBorder(borderColor: .reddish, borderWidth: 1.0)
    }
    
    func setNonWarningState(){
        warningStackView.removeFromSuperview()
        callInNoThemeSentenceButton.snp.remakeConstraints {
            $0.top.equalTo(sentenceTextView.snp.bottom)
            $0.leading.equalToSuperview().offset(16)
            $0.width.equalTo(129)
            $0.height.equalTo(42)
        }
        sentenceTextView.setBorder(borderColor: .softGreen, borderWidth: 1.0)
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
    
    func isValidInputTextView() -> Bool {
        if sentenceTextView.text.count == 0 || isInitial {
            return false
        }
        else {
            return true
        }
    }
    
    // MARK:- IBAction
    @IBAction func touchUpNextButton(_ sender: UIButton) {
        if isValidInputTextView() {
            setNonWarningState()
            if isSentenceSelected {
                NoThemeSentenceService
                    .shared
                    .registThemeSentence(themeIdx: self.themeIdx ?? 0,
                                         sentenceIdx: self.selectedSentence?.sentenceIdx ?? 0,
                                         sentence: self.selectedSentence?.sentence ?? "",
                                         title: self.selectedSentence?.title ?? "",
                                         author: self.selectedSentence?.author ?? "",
                                         publisher: self.selectedSentence?.publisher ?? "") { networkResult in
                                            switch networkResult {
                                            case .success(_):
                                                self.showToast(text: "등록성공")
                                                
                                                let dvc = UIStoryboard(name: "EndOfWritingSentence", bundle: nil).instantiateViewController(identifier: "EndOfWritingSentenceVC") as! EndOfWritingSentenceVC
                                                self.present(dvc, animated: true, completion: {
                                                    self.navigationController?.popViewController(animated: false)
                                                })
                                            case .requestErr(let msg):
                                                self.showToast(text: msg as? String ?? "request err")
                                            case .pathErr:
                                                self.showToast(text: "path err")
                                            case .serverErr:
                                                self.showToast(text: "Server ERr")
                                            case .networkFail:
                                                self.showToast(text: "network fail")
                                            }
                }
            }
            else {
                guard let dvc = UIStoryboard(name: "AddBookToSentence", bundle: nil).instantiateViewController(identifier: "AddBookToSentenceVC") as? AddBookToSentenceVC else {
                    return
                }
                dvc.sentence = self.sentenceTextView.text
                dvc.themeIdx = self.themeIdx
                self.navigationController?.pushViewController(dvc, animated: true)
            }
            
        }
        else {
            setWarningState()
        }
    }
    
    @IBAction func touchUpBackButton(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func touchUpCallInNoThemeSentenceButton(_ sender: UIButton) {
        guard let dvc = UIStoryboard(name: "ThemeInfo", bundle: nil).instantiateViewController(identifier: "ThemeInfoVC") as? ThemeInfoVC else {
            return
        }
        dvc.hasTheme = false
        dvc.modalPresentationStyle = .fullScreen
        dvc.noThemeSentenceSelectedDelegate = { [weak self] sentence in
            self?.selectedSentence = sentence
            self?.isSentenceSelected = true
            self?.sentenceTextView.isEditable = false
            self?.sentenceTextView.text = sentence.sentence
            self?.setAttributeCountLabel(count: sentence.sentence.count)
            self?.isInitial = false
            self?.sentenceTextView.textColor = .black
        }
        
        self.present(dvc, animated: true, completion: nil)
    }
}

extension WritingSentenceInThemeVC: UITextViewDelegate {
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
//
//        textView.text = """
//        최대 280자까지 입력 가능하며, 책의 문장을 임의로
//        변형하지 않게 주의해주세요!
//        """
        let position = textView.beginningOfDocument
        textView.selectedTextRange = textView.textRange(from:position, to:position)
        return true
    }
    
    func textViewDidChange(_ textView: UITextView) {
        
        if isInitial {
            let char = textView.text[textView.text.startIndex]
            textView.text = "\(char)"
            textView.textColor = .black
        }
        
        if textView.text.count > 280 {
            textView.text = text
        }
        text = textView.text
        self.isInitial = false
        setAttributeCountLabel(count: textView.text.count)
        
        if isValidInputTextView() {
            setNonWarningState()
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if self.isInitial {
            textView.text = """
            최대 280자까지 입력 가능하며, 책의 문장을 임의로
            변형하지 않게 주의해주세요!
            """
            let position = textView.beginningOfDocument
            textView.selectedTextRange = textView.textRange(from:position, to:position)

            textView.beginFloatingCursor(at: CGPoint(x: 0, y: 0))
            textView.textColor = .veryLightPink
        }
    }
}

struct BookForRregistModel {
    var sentence: String
    var title: String
    var author: String
    var publisher: String
}
