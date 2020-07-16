//
//  ThemeSelectForWriteData.swift
//  Mongle
//
//  Created by Yunjae Kim on 2020/07/16.
//  Copyright © 2020 이주혁. All rights reserved.
//

import Foundation

struct ThemeSelectForWriteData : Codable {
    
    let themeIdx: Int
    let theme, themeImg: String
    let themeImgIdx, saves: Int
    let writer, writerImg: String
    let alreadyBookmarked: Bool
    
    
    
}
