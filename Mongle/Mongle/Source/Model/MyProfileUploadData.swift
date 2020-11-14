//
//  MyProfileUploadData.swift
//  Mongle
//
//  Created by 이예슬 on 11/11/20.
//  Copyright © 2020 이주혁. All rights reserved.
//

import Foundation

struct MyProfileUploadData: Codable {
    var name: String
    var img: String?
    var introduce: String?
    var keyword: String?
    var keywordIdx: Int?
}
