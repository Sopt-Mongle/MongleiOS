//
//  WritingSentenceSecondVC.swift
//  Mongle
//
//  Created by Yunjae Kim on 2020/07/08.
//  Copyright © 2020 이주혁. All rights reserved.
//

import UIKit

class WritingSentenceSecondVC: UIViewController {

    
    //    MARK:- IBOutlets
    
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var authorTextField: UITextField!
    @IBOutlet weak var publisherTextField: UITextField!
    @IBOutlet weak var noticeLabel: UILabel!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var searchTextButton: UIButton!
    
    //    MARK:- User Define Variables
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
    static var isVisited : Bool = false
    
//    MARK:- LifeCycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        partialGreenColor()
        
        publisherTextField.isEnabled = false
        authorTextField.isEnabled = false
        backButton.setImage(UIImage(named: "searchBtnBack"), for: .normal)
        backButton.tintColor = .veryLightPink
        setNextButton()
  
        setProgressBar()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setProgressBar()
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
        dismiss(animated: true, completion: nil)
    }
    
    

    
    func setProgressBar(){
    
        self.view.addSubview(outerCircle)
        self.view.addSubview(innerCircle)
        self.view.addSubview(outerCircle2)
        self.view.addSubview(innerCircle2)
        progressBar.progressTintColor = .softGreen
        
        innerCircle.snp.makeConstraints{
            $0.width.height.equalTo(12)
            $0.centerX.equalTo(progressBar.snp_leadingMargin)
            $0.centerY.equalTo(progressBar.snp_centerYWithinMargins)
            
        }
        innerCircle.makeRounded(cornerRadius: 6)
        
        outerCircle.snp.makeConstraints{
            $0.width.height.equalTo(26)
            $0.centerX.equalTo(progressBar.snp_leadingMargin)
            $0.centerY.equalTo(progressBar.snp_centerYWithinMargins)
            
        }
        outerCircle.makeRounded(cornerRadius: 13)

        secondLevelAnimation()
        
        
    }
    
    func secondLevelAnimation() {
        progressBar.progress = 0
        //        progressBar.setProgress(0.5, animated: true)
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
        outerCircle2.alpha = 0
        innerCircle2.alpha = 0
        
        
        
        UIView.animate(withDuration: 0.5, delay: 0.0, animations: {
            self.progressBar.layoutIfNeeded()
            
        }, completion: { finished in
            self.progressBar.progress = 0.5
            UIView.animate(withDuration: 0.75 , delay: 0.5, options: [.curveEaseIn], animations: {
                self.outerCircle2.alpha = 0.34
                self.innerCircle2.alpha = 1
                self.outerCircle2.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                self.innerCircle2.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)

                
            }, completion:nil)
            
            
            
            UIView.animate(withDuration: 0.75 , delay: 0.0, options: [.curveEaseIn], animations: {
                self.progressBar.layoutIfNeeded()
            }, completion:nil)
        })
        
        
        
    }
    @IBAction func searchTextButtonAction(_ sender: Any) {
        
        
        guard let vcName = UIStoryboard(name: "SearchBookForWriting",
                                        bundle: nil).instantiateViewController(
                                            withIdentifier: "SearchBookForWritingVC")
            as? SearchBookForWritingVC
            else{
                return
        }
        
        vcName.modalPresentationStyle = .fullScreen
        self.present(vcName, animated: true, completion: nil)
        
        
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
    
    
    
    
}
