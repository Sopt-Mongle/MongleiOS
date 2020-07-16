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
    
    
    //Editor's Pick
    static let mainEditorPick = baseURL + "/main/editorsPick"
    // 오늘의 문장 목록 조회
    static let mainSentencesURL = baseURL + "/main/sentences"
    // 지금 인기있는 큐레이터 목록 조회
    static let mainCuratorURL = baseURL + "/main/curators"
    // 오늘 하루 저장이 가장 많이 된 테마목록 조회
    static let mainThemesURL = baseURL + "/main/themes"
}
