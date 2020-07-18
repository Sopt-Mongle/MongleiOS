//
//  MyCuratorData.swift
//  Mongle
//
//  Created by 이예슬 on 7/18/20.
//  Copyright © 2020 이주혁. All rights reserved.
//

import Foundation

struct MyCuratorData: Codable {
    var curatorIdx: Int
    var name: String
    var img: String
    var introduce: String?
    var keyword: String?
    var keywordIdx: Int?
    var subscribe: Int
    var alreadySubscribed: Bool
}
