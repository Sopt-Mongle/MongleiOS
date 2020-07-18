//
//  MainMongleHeaderView.swift
//  Mongle
//
//  Created by 이주혁 on 2020/07/07.
//  Copyright © 2020 이주혁. All rights reserved.
//

import UIKit

import SnapKit
import Then

class MainMongleHeaderView: UIView {

    // MARK:- UI Component
    let mongleLogoImageview = UIImageView().then {
        $0.frame = CGRect(x: 0, y: 0, width: 89, height: 26)
        $0.image = UIImage(named: "mongleLogo")
    }
    
    let searchButton = UIButton().then {
        $0.frame = CGRect(x: 0, y: 0, width: 48, height: 48)
        $0.setImage(UIImage(named: "mainBtnSearch"), for: .normal)
        $0.addTarget(self, action: #selector(touchUpSearchButton), for: .touchUpInside)
    }
    
    var searchButtomDelegate: (()->()) = { }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addView()
        setUpAutolayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addView(){
        self.addSubview(mongleLogoImageview)
        self.addSubview(searchButton)
    }
    func setUpAutolayout(){
        // mongle logo
        mongleLogoImageview.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide).offset(4)
            $0.leading.equalToSuperview().offset(16)
            $0.width.equalTo(89)
            $0.height.equalTo(26)
        }
        
        // searchButton
        searchButton.snp.makeConstraints {
            $0.width.height.equalTo(48)
            $0.trailing.equalToSuperview().offset(2)
            $0.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(-5)
        }
    }
    
    @objc func touchUpSearchButton(){
        self.searchButtomDelegate()
    }
}
