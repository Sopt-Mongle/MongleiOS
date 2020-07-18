//
//  MySentenceData.swift
//  Mongle
//
//  Created by 이예슬 on 7/18/20.
//  Copyright © 2020 이주혁. All rights reserved.
//

import Foundation
struct MySentenceData: Codable {
    var write, save: [MySentenceSave]
}

// MARK: - Save

struct MySentenceSave: Codable {
    var sentenceIdx: Int
    var sentence, theme: String
    var likes, saves: Int
    var writer: String
    var title, author, publisher: String
    var thumbnail: String?
    var timestamp: String
}
