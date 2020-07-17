//
//  SearchThemeData.swift
//  Mongle
//
//  Created by Yunjae Kim on 2020/07/16.
//  Copyright © 2020 이주혁. All rights reserved.
//

import Foundation

struct SearchThemeData : Codable {
    
    let themeIdx: Int
    let theme: String
    let themeImg: String
    let themeImgIdx, saves, sentenceNum: Int
    
    
}
