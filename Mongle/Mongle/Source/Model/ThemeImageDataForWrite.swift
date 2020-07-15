//
//  ThemeImageDataForWrite.swift
//  Mongle
//
//  Created by Yunjae Kim on 2020/07/15.
//  Copyright © 2020 이주혁. All rights reserved.
//

import Foundation



struct ThemeImageforWriteInformation : Codable {
    var img : String
    var themeImgIdx : Int
    
    
    init(from decoder: Decoder) throws {
       
        let values = try decoder.container(keyedBy: CodingKeys.self)
        img = (try? values.decode(String.self, forKey: .img)) ?? ""
        themeImgIdx = (try? values.decode(Int.self, forKey: .themeImgIdx)) ?? -1
    }
    
    
    
}


