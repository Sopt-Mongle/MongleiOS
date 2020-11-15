//
//  DetailSentenceInfo.swift
//  Mongle
//
//  Created by 이주혁 on 2020/11/15.
//  Copyright © 2020 이주혁. All rights reserved.
//

import Foundation


struct DetailSentenceInfo: Codable {
    var sentenceIdx: Int
    var sentence: String
    var themeIdx: Int
    var theme: String
    var likes, saves: Int
    var writer: String
    var writerImg: String?
    var title, author: String
    var publisher: String
    var thumbnail: String?
    var timestamp: String
    var alreadyLiked, alreadyBookmarked: Bool
}
