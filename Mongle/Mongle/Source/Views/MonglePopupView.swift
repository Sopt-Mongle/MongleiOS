//
//  MonglePopupView.swift
//  Mongle
//
//  Created by 이주혁 on 2020/07/15.
//  Copyright © 2020 이주혁. All rights reserved.
//

import UIKit

class MonglePopupView: UIView {
    
    var messages: [String] = ["문장이 수정되었어요!", "문장을 삭제하시겠어요?"]
    var images: [String] = ["sentenceEditFinishBox", "sentenceDeleteCheckBox"]
    
    var yesButtonClicked: (()->())?
    var noButtonCliecked: (()->())?
    var confirmButtonClicked: (()->())?
    
    // MARK:- UI Component
    lazy var backgroundImageView: UIImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
    }
    
    lazy var messageLabel: UILabel = UILabel().then {
        $0.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 15)
        $0.textColor = .black
        $0.sizeToFit()
    }
    
    lazy var confirmButton: UIButton = UIButton().then {
        $0.setTitle("확인", for: .normal)
        $0.backgroundColor = .softGreen
        $0.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 13)!
        $0.setTitleColor(.white, for: .normal)
        $0.makeRounded(cornerRadius: 19)
        $0.addTarget(self, action: #selector(touchUpConfirmButton), for: .touchUpInside)
    }
    lazy var yesButton: UIButton = UIButton().then {
        $0.setTitle("네", for: .normal)
        $0.backgroundColor = .softGreen
        $0.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 13)!
        $0.setTitleColor(.white, for: .normal)
        $0.makeRounded(cornerRadius: 14)
        $0.addTarget(self, action: #selector(touchUpYesButton), for: .touchUpInside)
    }
    lazy var noButton: UIButton = UIButton().then {
        $0.setTitle("아니요", for: .normal)
        $0.backgroundColor = .white
        $0.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 13)!
        $0.setTitleColor(.softGreen, for: .normal)
        $0.makeRounded(cornerRadius: 14)
        $0.setBorder(borderColor: .softGreen, borderWidth: 1)
        $0.addTarget(self, action: #selector(touchUpNoButton), for: .touchUpInside)
    }

    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(backgroundImageView)
        self.addSubview(messageLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setPopUp(state: PopupState,
                  yesHandler: (()->())?,
                  noHandler:(()->())?,
                  confirmHandler: (()->())?){
        
        backgroundImageView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
        messageLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(81)
            $0.centerX.equalToSuperview()
        }
        
        switch state {
        case .edit:
            messageLabel.text = messages[0]
            backgroundImageView.image = UIImage(named: images[0])
            self.confirmButtonClicked = confirmHandler
            self.addSubview(confirmButton)
            self.confirmButton.snp.makeConstraints {
                $0.width.equalTo(127)
                $0.height.equalTo(37)
                $0.top.equalTo(messageLabel.snp.bottom).offset(32)
                $0.centerX.equalToSuperview()
            }
            
        case .delete:
            messageLabel.text = messages[1]
            backgroundImageView.image = UIImage(named: images[1])
            
            self.yesButtonClicked = yesHandler
            self.noButtonCliecked = noHandler
            
            let deleteStackView: UIStackView = UIStackView().then {
                $0.addArrangedSubview(yesButton)
                $0.addArrangedSubview(noButton)
                $0.spacing = 14
                $0.alignment = .center
                $0.distribution = .fillEqually
                $0.axis = .horizontal
            }
            
            self.addSubview(deleteStackView)
            
            deleteStackView.snp.makeConstraints {
                $0.top.equalTo(messageLabel.snp.bottom).offset(32)
                $0.leading.equalToSuperview().offset(18)
                $0.trailing.equalToSuperview().offset(-18)
                $0.height.equalTo(37)
            }
            
            yesButton.snp.makeConstraints {
                $0.top.bottom.equalToSuperview()
            }
            noButton.snp.makeConstraints {
                $0.top.bottom.equalToSuperview()
            }
        }
    }

    @objc func touchUpConfirmButton(){
        if let handler = self.confirmButtonClicked {
            handler()
        }
    }
    @objc func touchUpYesButton(){
        if let handler = self.yesButtonClicked {
            handler()
        }
    }
    @objc func touchUpNoButton(){
        if let handler = self.noButtonCliecked {
            handler()
        }
    }
}

enum PopupState {
    case edit, delete
}
