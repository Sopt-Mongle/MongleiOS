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
        $0.textColor = .black
        $0.font = UIFont.systemFont(ofSize: 18)
    }
    
    let selectButton = UIButton().then {
        $0.frame = CGRect(x: 0, y: 0, width: 48, height: 48)
//        $0.setImage(UIImage(named: ), for: <#T##UIControl.State#>)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setLabel(text: String){
        self.sectionLabel.text = text
    }
//    set
}

protocol SectionSelectDelegate {
    func touchUpSection(sender: UIView)
}
