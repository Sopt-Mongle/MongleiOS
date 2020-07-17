//
//  CuratorInfoData.swift
//  Mongle
//
//  Created by 이예슬 on 7/17/20.
//  Copyright © 2020 이주혁. All rights reserved.
//

import Foundation

struct CuratorInfoData: Codable {
    var profile: [Profile]
    var theme: [Theme]
    var sentence: [Sentence]
}

// MARK: - Profile
struct Profile: Codable {
    var curatorIdx: Int
    var name, img, keyword: String?
    var subscribe: Int
    var alreadySubscribed: Bool
}

// MARK: - Sentence
struct Sentence: Codable {
    var sentenceIdx: Int
    var sentence: String
    var likes, saves: Int
    var writer, writerImg, title, author: String?
    var publisher, timestamp: String
    var alreadyLiked, alreadyBookmarked: Bool
}

// MARK: - Theme
struct Theme: Codable {
    var themeIdx: Int
    var theme, themeImg: String?
    var saves: Int
    var writer, writerImg: String?
    var alreadyBookmarked: Bool
    var sentenceNum: Int
}
