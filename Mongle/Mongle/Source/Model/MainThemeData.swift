//
//  MainThemeData.swift
//  Mongle
//
//  Created by 이주혁 on 2020/07/16.
//  Copyright © 2020 이주혁. All rights reserved.
//

import Foundation


struct MainThemeData: Codable {
    var themeIdx: Int
    var theme, themeImg: String
    var saves: Int
    var alreadyBookmarked: Bool
    var sentenceNum: Int
}
