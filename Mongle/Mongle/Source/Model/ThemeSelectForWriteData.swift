//
//  ThemeSelectForWriteData.swift
//  Mongle
//
//  Created by Yunjae Kim on 2020/07/16.
//  Copyright © 2020 이주혁. All rights reserved.
//

import Foundation

struct ThemeSelectForWriteData : Codable {
    
//    let themeIdx: Int
//    let theme, themeImg: String
//    let themeImgIdx, saves: Int
//    let writer, writerImg: String
//    let alreadyBookmarked: Bool
    let themeIdx: Int
    let theme: String
    let themeImg: String
    let themeImgIdx, saves: Int
    let writer : String
    let writerImg: String?
    let alreadyBookmarked: Bool
    
    init(themeIdx : Int, theme : String, themeImg : String, themeImgIdx : Int, saves : Int, writer : String, writerImg : String?,
         alreadyBookmarked : Bool) {
        self.themeIdx = themeIdx
        self.theme = theme
        self.themeImg = themeImg
        self.themeImgIdx = themeImgIdx
        self.saves = saves
        self.writer = writer
        self.writerImg = writerImg
        self.alreadyBookmarked = alreadyBookmarked
           
    }
}
