//
//  Curator.swift
//  Mongle
//
//  Created by 이주혁 on 2020/07/16.
//  Copyright © 2020 이주혁. All rights reserved.
//

import Foundation

struct MainCuratorData: Codable {
    var curatorIdx: Int
    var name: String
    var img: String?
    var introduce: String?
    var keyword: String?
    var keywordIdx: Int?
    var subscribe: Int
}

