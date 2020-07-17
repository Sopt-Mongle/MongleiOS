//
//  SentenceData.swift
//  Mongle
//
//  Created by 이주혁 on 2020/07/17.
//  Copyright © 2020 이주혁. All rights reserved.
//

import Foundation


struct SentenceData: Codable {
    var sentenceIdx: Int
    var sentence: String
    var themeIdx: Int
    var theme: String
    var likes, saves: Int
    var writer, writerImg, title, author: String
    var publisher, timestamp: String
    var alreadyLiked, alreadyBookmarked: Bool
}

