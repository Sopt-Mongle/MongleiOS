//
//  WritingSentenceSecondVC.swift
//  Mongle
//
//  Created by Yunjae Kim on 2020/07/08.
//  Copyright © 2020 이주혁. All rights reserved.
//

import UIKit

class WritingSentenceSecondVC: UIViewController, BookSearchDataDelegate  {

    
    //    MARK:- IBOutlets
    
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var authorTextField: UITextField!
    @IBOutlet weak var publisherTextField: UITextField!
    @IBOutlet weak var noticeLabel: UILabel!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var searchTextButton: UIButton!
    @IBOutlet weak var labelConstraint: NSLayoutConstraint!
    @IBOutlet weak var warningImageView: UIImageView!
    @IBOutlet weak var warningLabel: UILabel!
    @IBOutlet weak var bookTitleLabel: UILabel!
    
    
    
    //    MARK:- User Define Variables
    let innerCircle = UIView().then{
        $0.backgroundColor = .softGreen
        
        
    }
    let outerCircle = UIView().then{
        $0.backgroundColor = .softGreen
        $0.alpha = 0.34
        
    }
    let innerCircle2 = UIView().then{
        $0.backgroundColor = .brownGreyThree
        
        
    }
    let outerCircle2 = UIView().then{
        $0.backgroundColor = .brownGreyThree
        $0.alpha = 0.34
    
    }
    let smallCircle = UIView().then{
        $0.backgroundColor = .veryLightPinkSeven
        
        
    }
    
    let smallCircle2 = UIView().then{
        $0.backgroundColor = .veryLightPinkSeven
        
        
    }
    
    
    var noAnimation : Bool = false
    static var isVisited : Bool = false
    var thumbNail = ""
    var sentenceForPost : String = ""
    var isSearched : Bool = false
    var book : Book?
//    MARK:- LifeCycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        partialGreenColor()
        
        publisherTextField.isEnabled = false
        authorTextField.isEnabled = false
        authorTextField.addLeftPadding(left: 7.5)
        publisherTextField.addLeftPadding(left: 7.5)
        backButton.setImage(UIImage(named: "searchBtnBack"), for: .normal)
        backButton.tintColor = .veryLightPink
        setNextButton()
        searchTextButton.setImage(UIImage(named: "themeWritingSentenceBookBtnBookSearch")?.withRenderingMode(.alwaysOriginal), for: .normal)
        searchTextButton.imageView?.contentMode = .scaleToFill
        searchTextButton.setBorder(borderColor: .veryLightPinkFive, borderWidth: 1.0)
        bookTitleLabel.text = ""
        setWarning()
        searchTextButton.makeRounded(cornerRadius: 10)
        
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setSmallBalls()
        setProgressBar()
        if isSearched == true{
            hideWarning()
            ballAppearAnimation()
            
        }
        else if self.noAnimation == true{
         
            
        }
        else{
            secondLevelAnimation()
        }
        
        
    }
    
 
    
    
//    MARK:- User Define Functions
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
    
    func setNextButton(){
          self.nextButton.backgroundColor = .softGreen
          self.nextButton.makeRounded(cornerRadius: 25)
          
          
      }
    @IBAction func backButton(_ sender: Any) {
        
        WritingSentenceSecondVC.isVisited = true
//        WritingSentenceVC.secondToFirstLevelAnimation()
        self.navigationController?.popViewController(animated: true)
    }
    
    
    func setInformationsAfterSelect(book : Book){
        self.bookTitleLabel.text = book.bookTitle
        
        self.authorTextField.text = ""
        for author in book.bookAuthors{
            self.authorTextField.text! += author + " "
        }
        
        
        self.publisherTextField.text = book.bookPublisher
        
        
    }
    
    
    
    func setProgressBar(){
        
        self.view.addSubview(outerCircle)
        self.view.addSubview(innerCircle)
        self.view.addSubview(outerCircle2)
        self.view.addSubview(innerCircle2)
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
        self.innerCircle2.snp.makeConstraints{
            $0.width.height.equalTo(12)
            $0.centerX.equalTo(self.progressBar.snp_centerXWithinMargins)
            $0.centerY.equalTo(self.progressBar.snp_centerYWithinMargins)
            
        }
        self.innerCircle2.makeRounded(cornerRadius: 6)
        
        self.outerCircle2.snp.makeConstraints{
            $0.width.height.equalTo(26)
            $0.centerX.equalTo(self.progressBar.snp_centerXWithinMargins)
            $0.centerY.equalTo(self.progressBar.snp_centerYWithinMargins)
            
        }
        self.outerCircle2.makeRounded(cornerRadius: 13)
        self.outerCircle2.alpha = 0.34
        self.innerCircle2.alpha = 1
        
        
    }
    
    func setSmallBalls(){
        self.view.addSubview(smallCircle)
        self.view.addSubview(smallCircle2)
        smallCircle.snp.makeConstraints{
            $0.width.height.equalTo(9)
            $0.center.equalTo(progressBar)
            
        }
        smallCircle.makeRounded(cornerRadius: 4.5)
        
        smallCircle2.snp.makeConstraints{
            $0.width.height.equalTo(9)
            $0.trailing.equalToSuperview().offset(-24)
            $0.centerY.equalTo(progressBar)
            
        }
        smallCircle2.makeRounded(cornerRadius: 4.5)
        
    }
    
    func secondLevelAnimation() {
        progressBar.progress = 0
        //        progressBar.setProgress(0.5, animated: true)
       
        
        UIView.animate(withDuration: 0.5, delay: 0.0, animations: {
            self.progressBar.layoutIfNeeded()
            
        }, completion: { finished in
            self.progressBar.progress = 0.5
           
            
            
            
            UIView.animate(withDuration: 0.75 , delay: 0.0, options: [.curveEaseIn], animations: {
                self.progressBar.layoutIfNeeded()
            }, completion:nil)
        })
        
        
        
    }
    
    func ballAppearAnimation(){
        UIView.animate(withDuration: 0.5 , delay: 0.25, options: [.curveEaseIn], animations: {
            self.innerCircle2.backgroundColor = .softGreen
            self.outerCircle2.backgroundColor = .softGreen
            
        }, completion:nil)
        
    }
    @IBAction func searchTextButtonAction(_ sender: Any) {
        
        
        guard let vcName = UIStoryboard(name: "SearchBookForWriting",
                                        bundle: nil).instantiateViewController(
                                            withIdentifier: "SearchBookForWritingVC")
            as? SearchBookForWritingVC
            else{
                return
        }
        vcName.bookSendDelegate = self
        vcName.modalPresentationStyle = .fullScreen
        self.present(vcName, animated: true, completion: nil)
        
        
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
        labelConstraint.constant = 68
        searchTextButton.setBorder(borderColor: .reddish, borderWidth: 1.0)
        
        
    }
    func hideWarning(){
        warningLabel.alpha = 0
        warningImageView.alpha = 0
        labelConstraint.constant = 43
        searchTextButton.setBorder(borderColor: .veryLightPinkFive, borderWidth: 1.0)
    }
    
    
    func secondToFirstLevelAnimation(){
        
        self.innerCircle2.snp.makeConstraints{
            $0.width.height.equalTo(15)
            $0.centerX.equalTo(self.progressBar.snp_centerXWithinMargins)
            $0.centerY.equalTo(self.progressBar.snp_centerYWithinMargins)
            
        }
        self.innerCircle2.makeRounded(cornerRadius: 7)
        
        self.outerCircle2.snp.makeConstraints{
            $0.width.height.equalTo(30)
            $0.centerX.equalTo(self.progressBar.snp_centerXWithinMargins)
            $0.centerY.equalTo(self.progressBar.snp_centerYWithinMargins)
            
        }
        self.outerCircle2.makeRounded(cornerRadius: 15)
        outerCircle2.alpha = 0.34
        innerCircle2.alpha = 1
        progressBar.progress = 0.5
        
        
        UIView.animate(withDuration: 0.5, delay: 0.0, animations: {
            self.progressBar.layoutIfNeeded()
            
        }, completion: { finished in
            self.progressBar.progress = 0.0
            UIView.animate(withDuration: 0.75 , delay: 0.5, options: [.curveEaseIn], animations: {
                self.outerCircle2.alpha = 0
                self.innerCircle2.alpha = 0
                self.outerCircle2.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                self.innerCircle2.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                
                
            }, completion:nil)
            
            
            
            UIView.animate(withDuration: 0.75 , delay: 0.0, options: [.curveEaseIn], animations: {
                self.progressBar.layoutIfNeeded()
            }, completion:nil)
        })
        
        
    }
    
    
    @IBAction func nextButtonAction(_ sender: Any) {
        guard let vcName = UIStoryboard(name: "WritingSentenceThird",
                                        bundle: nil).instantiateViewController(
                                            withIdentifier: "WritingSentenceThirdVC")
            as? ThirdViewOfWritingSentenceVC
            else{
                return
        }
        if bookTitleLabel.text == ""{
            showWarning()
        }
        else{
            vcName.modalPresentationStyle = .currentContext
            
            self.navigationController?.pushViewController(vcName, animated: true)
            vcName.bookForPost = bookTitleLabel.text!
            vcName.authorForPost = authorTextField.text!
            vcName.publisherForPost = publisherTextField.text!
            vcName.sentenceForPost = self.sentenceForPost
            vcName.thumNailForPost = self.thumbNail
            
            
            
        }
    }
    
    
    //MARK:- Data Transfer Protocol
    func sendBookData(Data: Book,isSelected : Bool, noAnimation : Bool) {
        self.isSearched = isSelected
        self.noAnimation = noAnimation
        self.thumbNail = Data.bookImgName
        
        setInformationsAfterSelect(book: Data)
        
    }
    
    
}


protocol BookSearchDataDelegate {
    func sendBookData(Data : Book, isSelected : Bool,noAnimation : Bool)
    
    
}
