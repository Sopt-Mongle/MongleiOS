//
//  SearchSentenceData.swift
//  Mongle
//
//  Created by 이예슬 on 7/17/20.
//  Copyright © 2020 이주혁. All rights reserved.
//

import Foundation

struct SearchSentenceData: Codable {
    var sentenceIdx: Int
    var sentence: String
    var themeIdx: Int
    var theme: String
    var likes, saves: Int
    var writer: String
    var writerImg: String?
    var title, author: String
    var publisher, timestamp: String
}
