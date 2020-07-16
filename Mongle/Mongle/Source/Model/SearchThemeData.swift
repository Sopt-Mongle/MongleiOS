//
//  SearchThemeData.swift
//  Mongle
//
//  Created by 이예슬 on 7/16/20.
//  Copyright © 2020 이주혁. All rights reserved.
//

import Foundation

struct searchThemeData: Codable {
    var themeIdx: Int
    var theme: String
    var themeImg: String
    var themeImgIdx, saves, sentenceNum: Int
}

