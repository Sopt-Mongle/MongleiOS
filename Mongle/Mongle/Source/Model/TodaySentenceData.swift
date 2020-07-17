//
//  TodaySentenceData.swift
//  Mongle
//
//  Created by 이주혁 on 2020/07/16.
//  Copyright © 2020 이주혁. All rights reserved.
//

import Foundation
 
struct TodaySentenceData: Codable {
    var sentenceIdx: Int
    var sentence, title: String
    var alreadyBookmarked: Bool
}
