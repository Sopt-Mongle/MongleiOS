//
//  String+Extensions.swift
//  Mongle
//
//  Created by 이예슬 on 11/8/20.
//  Copyright © 2020 이주혁. All rights reserved.
//

import Foundation

extension String{
    func isValidPassword() -> Bool {

        let regEx = "[A-Za-z0-9!_@$%^&+=*]{8,20}"
        let pred = NSPredicate(format:"SELF MATCHES %@", regEx)
        
        return pred.evaluate(with: self)
    }
}
