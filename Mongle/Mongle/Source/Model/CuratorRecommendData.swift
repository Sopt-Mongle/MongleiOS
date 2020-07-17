//
//  CuratorRecommendData.swift
//  Mongle
//
//  Created by 이예슬 on 7/17/20.
//  Copyright © 2020 이주혁. All rights reserved.
//

import Foundation

struct CuratorRecommendData: Codable {
    var curatorIdx: Int
    var name: String
    var img: String?
    var keyword: String?
    var subscribe: Int
}
