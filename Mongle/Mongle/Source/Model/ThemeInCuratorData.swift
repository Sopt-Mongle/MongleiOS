//
//  ThemeInCuratorData.swift
//  Mongle
//
//  Created by 이예슬 on 7/17/20.
//  Copyright © 2020 이주혁. All rights reserved.
//

import Foundation

struct ThemeInCuratorData: Codable {
    var theme: [CuratorTabTheme]
}

// MARK: - Theme
struct CuratorTabTheme: Codable {
    var themeIdx: Int
    var theme: String
    var themeImgIdx, saves, writerIdx, count: Int
    var createdAt: String?
    var themeImg: String?
    var sentenceNum, curatorNum: Int
    var curators: [CuratorInTheme]
}

// MARK: - Curator
struct CuratorInTheme: Codable {
    var curatorIdx: Int
    var name: String
    var img: String?
    var keyword: String?
    var subscribe: Int
    var alreadySubscribed: Bool
}
