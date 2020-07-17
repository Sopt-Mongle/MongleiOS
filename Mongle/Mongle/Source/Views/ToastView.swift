//
//  ToastView.swift
//  Mongle
//
//  Created by 이주혁 on 2020/07/15.
//  Copyright © 2020 이주혁. All rights reserved.
//

import UIKit

class ToastView: UIView {

    lazy var toastBackground: UIImageView = UIImageView().then {
        $0.image = UIImage(named: "toast")
    }
    lazy var toastLabel: UILabel = UILabel().then {
        $0.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 15)
        $0.textColor = .white
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setLayout(){
        self.addSubview(toastBackground)
        self.addSubview(toastLabel)
        
        toastBackground.snp.makeConstraints {
            $0.top.bottom.leading.trailing.equalToSuperview()
        }
        
        toastLabel.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-16)
            $0.centerX.equalToSuperview()
        }
    }
    
    func setLabel(text: String){
        toastLabel.text = text
    }
}
