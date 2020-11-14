//
//  SignUpAgreeVC.swift
//  Mongle
//
//  Created by Yunjae Kim on 2020/09/09.
//  Copyright © 2020 이주혁. All rights reserved.
//

import UIKit

class SignUpAgreeVC: UIViewController {
    @IBOutlet weak var mongleImageView: UIImageView!
    @IBOutlet weak var closeButton: UIButton!
    
    @IBOutlet weak var progressBar: UIProgressView!
    
    @IBOutlet weak var checkButtonOuter: UIImageView!
    @IBOutlet weak var checkButtonInner: UIImageView!
    @IBOutlet weak var checkButton: UIButton!
    
    @IBOutlet weak var textViewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var smallNextImageView: UIImageView!
    
    @IBOutlet weak var showAgreeButton: UIButton!
    @IBOutlet weak var headerImageView: UIImageView!
    @IBOutlet weak var noticeLabel: UILabel!
    @IBOutlet weak var explainTextView: UITextView!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var checkButtonInner2: UIImageView!
    
    
    
    @IBOutlet weak var checkButtonOuter2: UIImageView!
    @IBOutlet weak var checkButton2: UIButton!
    @IBOutlet weak var showServiceAgreeButton: UIButton!
    
    @IBOutlet weak var outerCircle2Constraint: NSLayoutConstraint!
    @IBOutlet weak var innerCircle2Constraint: NSLayoutConstraint!
    
    
    
    @IBOutlet weak var smallNextImageView2: UIImageView!
    @IBOutlet weak var noticeLabel2: UILabel!
    
    
    let innerCircle = UIView().then{
        $0.backgroundColor = .brownGreyThree
        
        
    }
    let outerCircle = UIView().then{
        $0.backgroundColor = .brownGreyThree
        $0.alpha = 0.34
        
    }
    
    let innerCircle2 = UIView().then{
        $0.backgroundColor = .softGreen
        
        
    }
    let outerCircle2 = UIView().then{
        $0.backgroundColor = .softGreen
        $0.alpha = 0.34
        
        
    }
    
    let smallCircle = UIView().then{
        $0.backgroundColor = .veryLightPinkSeven
        
        
    }
    
    let smallCircle2 = UIView().then{
        $0.backgroundColor = .veryLightPinkSeven
        
        
    }
    
    let smallCircle3 = UIView().then{
        $0.backgroundColor = .veryLightPinkSeven
        
        
    }
    
    let warnView = UIView()
    
    let warningImageView = UIImageView().then{
        $0.image = UIImage(named: "joinStep1ErrorIcWarning")
        
    }
    
    
    
    let warningLabel = UILabel().then{
        $0.text = "필수 항목을 동의해야 가입할 수 있어요!"
        $0.font = UIFont.systemFont(ofSize: 13)
        $0.textColor = .reddish
    }
    
    
    var checked = false
    var checked2 = false
    var showingWarning = false
    var showingWarning2 = false
    
    //MARK:: constraints
    
    @IBOutlet weak var checkButton2Constraints: NSLayoutConstraint!
    
    @IBOutlet weak var serViceButtonConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var smallNext2Constraint: NSLayoutConstraint!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setItems()
        setProgressBar()
        setSmallBalls()
        // Do any additional setup after loading the view.
    }
    
    
    func setItems(){
        mongleImageView.image = UIImage(named: "joinStep1AgreeImgMongle")
        headerImageView.image = UIImage(named: "yoonjaeFighting")
        
        checkButtonOuter.image = UIImage(named: "joinStep1ErrorBtnAgree")
        checkButtonOuter2.image = UIImage(named: "joinStep1ErrorBtnAgree")
        checkButtonInner.image = UIImage(named: "joinStep1AgreeIcAgree")
        
        checkButtonInner2.image = UIImage(named: "joinStep1AgreeIcAgree")
        checkButtonInner.makeRounded(cornerRadius: 7)
        checkButtonInner2.makeRounded(cornerRadius: 7)
        checkButtonInner.alpha = 0
        checkButtonInner2.alpha = 0
        
        
        noticeLabel.text = "[필수] 개인정보 수집이용 동의"
        noticeLabel2.text = "[필수] 서비스 이용약관 동의"
        
        smallNextImageView.image = UIImage(named: "joinStep1AgreeBtnPolicy")
        smallNextImageView2.image = UIImage(named: "joinStep1AgreeBtnPolicy")
        
        explainTextView.text = "약관에는 '개인정보 수집 목적 및 이용’에 관한 중요한\n내용이 담겨 있습니다. 약관 동의 체크는 해당 약관을\n모두 숙지하였으며, 이에 동의함을 의미합니다."
        explainTextView.textColor = .brownGreyThree
        
        nextButton.backgroundColor = .softGreen
        nextButton.makeRounded(cornerRadius: 27)
        closeButton.setImage(UIImage(named: "joinStep1AgreeBtnClose")?.withRenderingMode(.alwaysOriginal), for: .normal)
        
        
        
        
    }
    func setSmallBalls(){
        
        self.view.addSubview(smallCircle2)
        self.view.addSubview(smallCircle3)
        
        smallCircle.makeRounded(cornerRadius: 4.5)
        
        smallCircle2.snp.makeConstraints{
            $0.width.height.equalTo(9)
            $0.center.equalTo(progressBar)
        }
        smallCircle2.makeRounded(cornerRadius: 4.5)
        
        smallCircle3.snp.makeConstraints{
            $0.width.height.equalTo(9)
            $0.trailing.equalToSuperview().offset(-36)
            $0.centerY.equalTo(progressBar)
            
        }
        smallCircle3.makeRounded(cornerRadius: 4.5)
        
        
        
    }
    func setProgressBar(){
        
        self.view.addSubview(outerCircle)
        self.view.addSubview(innerCircle)
        self.view.addSubview(outerCircle2)
        self.view.addSubview(innerCircle2)
        
        
        self.innerCircle2.snp.makeConstraints{
            $0.width.height.equalTo(9)
            $0.centerX.equalTo(self.progressBar.snp_centerXWithinMargins)
            $0.centerY.equalTo(self.progressBar.snp_centerYWithinMargins)
            
            
        }
        innerCircle2.makeRounded(cornerRadius: 6)
        innerCircle2.alpha = 0
        
        
        self.outerCircle2.snp.makeConstraints{
            $0.width.height.equalTo(26)
            $0.centerX.equalTo(self.progressBar.snp_centerXWithinMargins)
            $0.centerY.equalTo(self.progressBar.snp_centerYWithinMargins)
            
        }
        outerCircle2.makeRounded(cornerRadius: 13)
        outerCircle2.alpha = 0
        
        
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
        innerCircle.alpha = 1
        outerCircle.alpha = 0.34
        progressBar.progress = 0
        
        
    }
    
    
    func ballAppearAnimation(){
        UIView.animate(withDuration: 0.5 , delay: 0.25, options: [.curveEaseIn], animations: {
            
            self.outerCircle.backgroundColor = .softGreen
            self.innerCircle.backgroundColor = .softGreen
            
            
        }, completion:nil)
        
    }
    
    func ballHideAnimation(){
        UIView.animate(withDuration: 0.5 , delay: 0.25, options: [.curveEaseIn], animations: {
            
            self.outerCircle.backgroundColor = .brownGreyThree
            self.innerCircle.backgroundColor = .brownGreyThree
            
            
        }, completion:nil)
        
    }
    
    func showWarning(){
        
        warnView.addSubview(warningLabel)
        warnView.addSubview(warningImageView)
        
        self.view.addSubview(warnView)
        
        textViewTopConstraint.constant = 76
        
        outerCircle2Constraint.constant = 28
        innerCircle2Constraint.constant = 39
        serViceButtonConstraint.constant = 18
        checkButton2Constraints.constant = 18
        smallNext2Constraint.constant = 33
        
        
        
        
        
        warnView.snp.makeConstraints{
            $0.leading.equalToSuperview().offset(58)
            $0.top.equalToSuperview().offset(349)
            $0.height.equalTo(15)
            $0.width.equalTo(200)
        }
        
        
        warningImageView.snp.makeConstraints{
            $0.leading.equalToSuperview()
            $0.width.height.equalTo(15)
        }
        
        warningLabel.snp.makeConstraints{
            $0.leading.equalToSuperview().offset(23)
            
        }
        
        
        showingWarning = true
        
        
        
    }
    func showWarning2(){
        warnView.addSubview(warningLabel)
        warnView.addSubview(warningImageView)
        
        self.view.addSubview(warnView)
        
        textViewTopConstraint.constant = 76
        warnView.snp.makeConstraints{
            $0.leading.equalToSuperview().offset(58)
            $0.top.equalToSuperview().offset(392)
            $0.height.equalTo(15)
            $0.width.equalTo(200)
        }
        
        
        warningImageView.snp.makeConstraints{
            $0.leading.equalToSuperview()
            $0.width.height.equalTo(15)
        }
        
        warningLabel.snp.makeConstraints{
            $0.leading.equalToSuperview().offset(23)
            
        }
        
        showingWarning2 = true
        
        
    }
    
    func hideWarning(){
        
        warnView.removeFromSuperview()
        textViewTopConstraint.constant = 53
        outerCircle2Constraint.constant = 10
        innerCircle2Constraint.constant = 21
        serViceButtonConstraint.constant = 0
        checkButton2Constraints.constant = 0
        smallNext2Constraint.constant = 15
        
        
    }
    
    func hideWarning2(){
        
        warnView.removeFromSuperview()
        textViewTopConstraint.constant = 53
    }
    
    
    @IBAction func checkButtonAction(_ sender: Any) {
        checked = !checked
        
        if(checked){
            checkButtonInner.alpha = 1
            if(checked && checked2){
                ballAppearAnimation()
            }
            
            if(showingWarning){
                hideWarning()
            }
        }
        else{
            checkButtonInner.alpha = 0
            ballHideAnimation()
            
            
        }
        
        
    }
    
    @IBAction func checkButton2Action(_ sender: Any) {
        checked2 = !checked2
        
        if(checked2){
            checkButtonInner2.alpha = 1
            
            if(checked && checked2){
                ballAppearAnimation()
            }
            if(showingWarning2){
                hideWarning()
            }
        }
        else{
            checkButtonInner2.alpha = 0
            ballHideAnimation()
            
            
        }
        
        
    }
    
    
    @IBAction func showAgreeButtonAction(_ sender: Any) {
        guard let vcName = UIStoryboard(name: "SignUpRule",
                                        bundle: nil).instantiateViewController(
                                            withIdentifier: "SignUpRuleVC") as? SignUpRuleVC
            else{
                
                return
        }
        
        vcName.modalPresentationStyle = .fullScreen
        
        self.present(vcName, animated: true, completion: nil)
        
        
        
    }
    
    @IBAction func showServiceButtonAction(_ sender: Any) {
        
        guard let vcName = UIStoryboard(name: "ServiceAgreeForSignUp",
                                        bundle: nil).instantiateViewController(
                                            withIdentifier: "ServiceAgreeForSignUpVC") as? ServiceAgreeForSignUpVC
            else{
                
                return
        }
        
        vcName.modalPresentationStyle = .fullScreen
        
        self.present(vcName, animated: true, completion: nil)
        
        
    }
    
    
    
    @IBAction func nextButtonAction(_ sender: Any) {
        if(!checked){
            showWarning()
            
        }
        
        else if (!checked2){
            showWarning2()
        }
        else{
            guard let vcName = UIStoryboard(name: "SignUp",
                                            bundle: nil).instantiateViewController(
                                                withIdentifier: "SignUpVC") as? SignUpVC
                else{
                    
                    return
            }
            
            vcName.modalPresentationStyle = .fullScreen
            self.navigationController?.pushViewController(vcName, animated: true)
            
            
        }
        
        
    }
    
    
    
    
    @IBAction func closeButtonAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    
}
