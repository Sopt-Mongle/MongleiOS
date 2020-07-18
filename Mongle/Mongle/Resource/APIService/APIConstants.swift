//
//  APIConstants.swift
//  Mongle
//
//  Created by 이주혁 on 2020/07/02.
//  Copyright © 2020 이주혁. All rights reserved.
//

import Foundation

struct APIConstants {
//    static let baseURL = "http://3.34.20.225:3000"
    static let baseURL = "http://18.189.125.26:3000"
    
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
    // 문장을 기다리고 있는 테마 목록 조회
    static let mainWaitThemesURL = baseURL + "/main/waitThemes"
    // 최근 3일 조회수 많은 테마 목록 조회
    static let mainNowThemesURL = baseURL + "/main/nowThemes"
    // 테마 상세조회 (/detail/theme/:themeIdx)
    static let detailThemeURL = baseURL + "/detail/theme"
    //  문장 상세조회 (/detail/sentence/:sentenceIdx)
    static let detailSentenceURL = baseURL + "/detail/sentence"
    //테마 없는 문장 목록 조회 (/post/emptySentence)
    static let postEmptySentenceURL = baseURL + "/post/emptySentence"
//    테마 없는 문장 테마 지정하기 (/post/setTheme)
    static let postSetThemeURL = baseURL + "/post/setTheme"
    
    static let bookSearchForWritingURL = baseURL + "/post/bookSearch"
    static let recentSearchURL = baseURL + "/search/recent"
    static let recommendSearchURL = baseURL + "/search/recommend"
    
    static let postSentenceURL = baseURL + "/post/sentence"
    static let ThemeSelectForWriteURL = baseURL + "/post/theme"
    static let searchThemeURL = baseURL + "/search/theme"

    static let searchSentenceURL = baseURL + "/search/sentence"
    static let searchCuratorURL = baseURL + "/search/curator"
    static let curatorURL = baseURL + "/curator"
    static let curatorRecommendURL =  curatorURL + "/recommend"
    static let themeInCuratorURL = curatorURL + "/themeInCurator"
    static let myProfileURL = baseURL + "/my/profile"
    static let myThemeURL = baseURL + "/my/theme"
    static let mySentenceURL = baseURL + "/my/sentence"
    static let myCuratorURL = baseURL + "/my/subscribe"
}
