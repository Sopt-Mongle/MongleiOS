//
//  SignUpDuplicate.swift
//  Mongle
//
//  Created by Yunjae Kim on 2020/11/12.
//  Copyright © 2020 이주혁. All rights reserved.
//

import Foundation


// MARK: - Welcome
struct SignUpDuplicateData: Codable {
    let status: Int
    let success: Bool
    let message: String
    let data: DataClass
}

// MARK: - DataClass
struct DataClass: Codable {
    let duplicate: String
}
