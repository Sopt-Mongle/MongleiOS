//
//  NoThemeData.swift
//  Mongle
//
//  Created by 이주혁 on 2020/07/17.
//  Copyright © 2020 이주혁. All rights reserved.
//

import Foundation

// MARK: - DataClass
struct NoThemeData: Codable {
    var num: Int
    var sentences: [NoThemeSentence]
}

// MARK: - Sentence
struct NoThemeSentence: Codable {
    var sentenceIdx: Int
    var sentence, title, author, publisher: String
    var timestamp: String
}
