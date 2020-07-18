//
//  MyThemeData.swift
//  Mongle
//
//  Created by 이예슬 on 7/18/20.
//  Copyright © 2020 이주혁. All rights reserved.
//

import Foundation
struct MyThemeData: Codable {
    var write, save: [MyThemeSave]
}

// MARK: - Save

struct MyThemeSave: Codable {
   var themeIdx: Int
   var theme: String
   var themeImgIdx, saves, sentenceNum: Int
}
