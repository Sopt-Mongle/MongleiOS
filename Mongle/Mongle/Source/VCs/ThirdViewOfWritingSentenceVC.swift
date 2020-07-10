//
//  ThirdViewOfWritingSentenceVC.swift
//  Mongle
//
//  Created by Yunjae Kim on 2020/07/10.
//  Copyright © 2020 이주혁. All rights reserved.
//

import UIKit

class ThirdViewOfWritingSentenceVC: UIViewController {
    
    //MARK:- IBOutlets
    
    @IBOutlet weak var backButton: UIButton!
    
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var themeTextView: UITextView!
    @IBOutlet weak var selectButton: UIButton!
    @IBOutlet weak var registButton: UIButton!
    
    
    
    //MARK:- User Define Variables
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
        $0.backgroundColor = .softGreen
    }
    let outerCircle3 = UIView().then{
        $0.backgroundColor = .softGreen
        $0.alpha = 0.34
    }
    
    let smallCircle = UIView().then{
        $0.backgroundColor = .veryLightPinkSeven
        
        
    }
    
    
    
    
    //MARK:- LifeCycle Methods


    override func viewDidLoad() {
       
        super.viewDidLoad()
        
        setItems()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        setSmallBalls()
        setProgressBar()
        
       
    }
    
    
    

    //MARK:- User Define Functions
    
    func setItems(){
        backButton.setImage(UIImage(named: "searchBtnBack")?.withRenderingMode(.alwaysOriginal),
                            for: .normal)
        themeTextView.setBorder(borderColor: .veryLightPinkFive, borderWidth: 1.0)
        themeTextView.makeRounded(cornerRadius: 10)
        selectButton.setBorder(borderColor: .softGreen, borderWidth: 1.0)
        selectButton.makeRounded(cornerRadius: 10)
        selectButton.setTitleColor(.softGreen, for: .normal)
        registButton.backgroundColor = .softGreen
        registButton.setTitleColor(.white, for: .normal)
        registButton.makeRounded(cornerRadius: 25)
        
        themeTextView.isEditable = false
        
    }
    
    func setSmallBalls(){
        self.view.addSubview(smallCircle)
       
        
        smallCircle.snp.makeConstraints{
            $0.width.height.equalTo(9)
            $0.trailing.equalToSuperview().offset(-24)
            $0.centerY.equalTo(progressBar)
            
        }
        smallCircle.makeRounded(cornerRadius: 4.5)
        
    }
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
        thirdLevelAnimation()
        
        
    }
    
    func thirdLevelAnimation() {
        
         //        progressBar.setProgress(0.5, animated: true)
        self.innerCircle3.snp.makeConstraints{
            $0.width.height.equalTo(12)
            $0.trailing.equalToSuperview().offset(-23)
            $0.centerY.equalTo(self.progressBar.snp_centerYWithinMargins)
            
        }
         self.innerCircle3.makeRounded(cornerRadius: 6)
         
         self.outerCircle3.snp.makeConstraints{
             $0.width.height.equalTo(26)
            $0.trailing.equalToSuperview().offset(-16)
             $0.centerY.equalTo(self.progressBar.snp_centerYWithinMargins)
             
         }
         self.outerCircle3.makeRounded(cornerRadius: 13)
         outerCircle3.alpha = 0
         innerCircle3.alpha = 0
         
         UIView.animate(withDuration: 0.5, delay: 0.0, animations: {
             self.progressBar.layoutIfNeeded()
             
         }, completion: { finished in
            self.progressBar.progress = 1.0
             UIView.animate(withDuration: 0.75 , delay: 0.5, options: [.curveEaseIn], animations: {
                 self.outerCircle3.alpha = 0.34
                 self.innerCircle3.alpha = 1
                 self.outerCircle3.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                 self.innerCircle3.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                 
                 
             }, completion:nil)
             
             
             
             UIView.animate(withDuration: 0.75 , delay: 0.0, options: [.curveEaseIn], animations: {
                 self.progressBar.layoutIfNeeded()
             }, completion:nil)
         })
         
         
         
     }

    @IBAction func backButtonAction(_ sender: Any) {
        WritingSentenceSecondVC.noAnimation = true
        dismiss(animated: true, completion: nil)
        
    }
}
