//
//  BookSearchForWritingData.swift
//  Mongle
//
//  Created by Yunjae Kim on 2020/07/16.
//  Copyright © 2020 이주혁. All rights reserved.
//

import Foundation


struct BookSearchForWritingData : Codable {
    
    
    let authors: [String]
    let contents, datetime, isbn, publisher: String
    let thumbnail: String
    let title: String
    
    
}
