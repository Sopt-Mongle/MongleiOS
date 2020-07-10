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
        $0.font = UIFont.systemFont(ofSize: 18)
        $0.sizeToFit()
    }
    
    let selectButton = UIButton().then {
        $0.frame = CGRect(x: 0, y: 0, width: 48, height: 48)
        $0.setImage(UIImage(named: "mainBtnMore"), for: .normal)
        $0.addTarget(self, action: #selector(touchUpButton), for: .touchUpInside)
    }
    
    var delegate: SectionSelectedDelegate?
    var selectedSectionIdx: Int?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addView()
        setAutoLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addView(){
        self.addSubview(sectionLabel)
        self.addSubview(selectButton)
    }
    
    func setAutoLayout(){
        self.sectionLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(16)
        }
        self.selectButton.snp.makeConstraints {
            $0.top.trailing.bottom.equalToSuperview()
            $0.height.width.equalTo(48)
        }
    }
    func setLabel(text: String){
        self.sectionLabel.text = text
    }
    
    @objc func touchUpButton(){
        self.delegate?.touchUpSection(sectionIdx: self.selectedSectionIdx ?? 0)
    }

}

protocol SectionSelectedDelegate {
    func touchUpSection(sectionIdx: Int)
}
