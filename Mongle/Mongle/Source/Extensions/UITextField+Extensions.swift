//
//  UITextField+Extensions.swift
//  Mongle
//
//  Created by Yunjae Kim on 2020/07/09.
//  Copyright © 2020 이주혁. All rights reserved.
//

import Foundation
import UIKit


extension UITextField{
    func addLeftPadding(left: CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: left, height: self.frame.height))
        self.leftView = paddingView
        self.leftViewMode = ViewMode.always
    }
    
    func disableAutoFill() {
        if #available(iOS 12, *) {
            textContentType = .oneTimeCode
        } else {
            textContentType = .init(rawValue: "")
        }
    }
}
