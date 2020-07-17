//
//  CuratorInfoData.swift
//  Mongle
//
//  Created by 이예슬 on 7/17/20.
//  Copyright © 2020 이주혁. All rights reserved.
//

import Foundation

struct CuratorInfoData: Codable {
    var profile: [CuratorProfile]
    var theme: [CuratorTheme]
    var sentence: [CuratorSentence]
}

// MARK: - Profile
struct CuratorProfile: Codable {
    var curatorIdx,keywordIdx: Int
    var name, img, keyword,introduce: String?
    var subscribe: Int
    var alreadySubscribed: Bool
}

// MARK: - Sentence
struct CuratorSentence: Codable {
    var sentenceIdx: Int
    var sentence: String
    var likes, saves: Int
    var writer, writerImg, title, author: String?
    var publisher, timestamp: String
    var alreadyLiked, alreadyBookmarked: Bool
    var thumbnail:String?
}

// MARK: - Theme
struct CuratorTheme: Codable {
    var themeIdx,themeImgIdx: Int
    var theme, themeImg: String?
    var saves: Int
    var writer, writerImg: String?
    var alreadyBookmarked: Bool
    var sentenceNum: Int
}
