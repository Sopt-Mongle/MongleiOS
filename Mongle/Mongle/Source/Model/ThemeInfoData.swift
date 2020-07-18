//
//  ThemeInfoData.swift
//  Mongle
//
//  Created by 이주혁 on 2020/07/17.
//  Copyright © 2020 이주혁. All rights reserved.
//

import Foundation

// MARK: - DataClass
struct ThemeInfoData: Codable {
    var theme: [Theme]
    var sentence: [Sentence]
}

// MARK: - Sentence
struct Sentence: Codable {
    var sentenceIdx: Int?
    var sentence: String
    var likes, saves: Int
    var writer, writerImg, title, author: String?
    var publisher: String
    var thumbnail: String?
    var timestamp: String
    var alreadyLiked, alreadyBookmarked: Bool
}

//// MARK: - Theme
struct Theme: Codable {
    var themeIdx: Int?
    var theme, themeImg: String?
    var saves: Int
    var writer, writerImg: String?
    var alreadyBookmarked: Bool
    var sentenceNum: Int
}
