//
//  APIConstants.swift
//  Mongle
//
//  Created by 이주혁 on 2020/07/02.
//  Copyright © 2020 이주혁. All rights reserved.
//

import Foundation

struct APIConstants {
    static let baseURL = "http://3.34.20.225:3000"
    
    static let signupURL = baseURL + "/users/signup"
    static let signinURL = baseURL + "/users/signin"
    static let getThemeImageForWritingURL = baseURL + "/post/themeImg"
    static let makeThemeURL = baseURL + "/post/theme"
    static let bookSearchForWritingURL = baseURL + "/post/bookSearch"
    static let postSentenceURL = baseURL + "/post/sentence"
    static let ThemeSelectForWriteURL = baseURL + "/post/theme"
    static let searchThemeURL = baseURL + "/search/theme"
    
    
}
