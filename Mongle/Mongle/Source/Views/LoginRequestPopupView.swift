//
//  LoginRequestPopupView.swift
//  Mongle
//
//  Created by 이주혁 on 2020/11/09.
//  Copyright © 2020 이주혁. All rights reserved.
//

import UIKit

class LoginRequestPopupView: UIView {
    
    let backgroundImageView: UIImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.image = UIImage(named: "loginPopup2Box")
    }
    
    let messageLabel: UILabel = UILabel().then {
        $0.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 15)
        $0.textColor = .black
        $0.text = "로그인이 필요한 기능이에요!"
        $0.sizeToFit()
    }
    
    let subMessageLabel: UILabel = UILabel().then {
        $0.textColor = .brownGreyThree
        $0.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 13)
        $0.numberOfLines = 0
        $0.text = """
                    해당 기능을 이용하려면
                    몽글에 로그인을 해주세요!
                """
        $0.sizeToFit()
    }
    let signInButton: UIButton = UIButton().then {
        $0.setTitle("로그인", for: .normal)
        $0.backgroundColor = .softGreen
        $0.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 13)!
        $0.setTitleColor(.white, for: .normal)
        $0.makeRounded(cornerRadius: 19)
        $0.addTarget(self, action: #selector(touchUpSignInButton), for: .touchUpInside)
    }
    let signUpButton: UIButton = UIButton().then {
        $0.setTitle("회원가입", for: .normal)
        $0.backgroundColor = .white
        $0.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 13)!
        $0.setTitleColor(.softGreen, for: .normal)
        $0.makeRounded(cornerRadius: 19)
        $0.setBorder(borderColor: .softGreen, borderWidth: 1)
        $0.addTarget(self, action: #selector(touchUpSignUpButton), for: .touchUpInside)
    }
    
    let buttonStackView: UIStackView = UIStackView().then {
        $0.spacing = 14
        $0.distribution = .fillEqually
        $0.axis = .horizontal
    }
    
    var signInButtonClicked: (()->())?
    var signUpButtonCliecked: (()->())?
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addViews()
        addConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addViews() {
        self.addSubview(backgroundImageView)
        self.addSubview(messageLabel)
        self.addSubview(subMessageLabel)
        self.addSubview(buttonStackView)
        buttonStackView.addArrangedSubview(signInButton)
        buttonStackView.addArrangedSubview(signUpButton)
    }
    
    func addConstraint() {
        // BackgroundImage
        backgroundImageView.snp.makeConstraints {
            $0.leading.trailing.top.bottom.equalToSuperview()
        }
        // MessageLabel
        messageLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(84)
            $0.centerX.equalToSuperview()
        }
        // SubMessageLabel
        subMessageLabel.snp.makeConstraints {
            $0.top.equalTo(messageLabel.snp.bottom).offset(10)
            $0.centerX.equalToSuperview()
        }
        
        // Buttons
        buttonStackView.snp.makeConstraints {
            $0.top.equalTo(subMessageLabel.snp.bottom).offset(26)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
            $0.height.equalTo(37)
        }
    }
    
    @objc func touchUpSignInButton() {
        if let handler = signInButtonClicked {
            handler()
        }
    }
    
    @objc func touchUpSignUpButton() {
        if let handler = signUpButtonCliecked {
            handler()
        }
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
