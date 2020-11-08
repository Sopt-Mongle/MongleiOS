//
//  MainTabDefaultHeaderView.swift
//  Mongle
//
//  Created by 이주혁 on 2020/07/07.
//  Copyright © 2020 이주혁. All rights reserved.
//

import UIKit

class MainTabDefaultHeaderView: UIView {
    

    //MARK: - UI Component
    let sectionLabel = UILabel().then {
        $0.frame = CGRect(x: 0, y: 0, width: 81, height: 22)
        $0.textColor = .black
        $0.text = ""
        $0.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 18)!
        $0.sizeToFit()
    }

    var selectedSectionIdx: Int?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear
        addView()
        setAutoLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addView(){
        self.addSubview(sectionLabel)
    }
    
    func setAutoLayout(){
        self.sectionLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().offset(16)
        }
    }
    func setLabel(text: String){
        self.sectionLabel.text = text
    }
}

