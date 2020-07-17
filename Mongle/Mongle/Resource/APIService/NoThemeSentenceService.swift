//
//  NoThemeSentenceService.swift
//  Mongle
//
//  Created by 이주혁 on 2020/07/17.
//  Copyright © 2020 이주혁. All rights reserved.
//

import Foundation

import Alamofire

struct NoThemeSentenceService {
    static let shared = NoThemeSentenceService()
    
    func registThemeSentence(themeIdx: Int,
                             sentenceIdx: Int,
                             sentence: String,
                             title: String,
                             author: String,
                             publisher: String,
                             completion: @escaping ((NetworkResult<Any>)->Void)){
        
        let token = UserDefaults.standard.string(forKey: UserDefaultKeys.token.rawValue)!
        
        let header: HTTPHeaders = [
            "Content-Type":"application/json",
            "token":token
        ]
        
        let body: Parameters = [
            "themeIdx": themeIdx,
            "sentenceIdx": sentenceIdx,
            "sentence" : sentence,
            "title" : title,
            "author" : author,
            "publisher" : publisher
        ]
        
        Alamofire.request(APIConstants.postSetThemeURL,
                          method: .post,
                          parameters: body,
                          encoding: JSONEncoding.default,
                          headers: header).responseData { response in
                            switch response.result {
                            case .success:
                                
                                guard let statusCode = response.response?.statusCode else {
                                    return
                                }
                                guard let data = response.value else {
                                    return
                                }
                                completion(self.judgeNoThemeSentence(status: statusCode, data: data))
                            case .failure(let err):
                                print(err)
                                completion(.networkFail)
                            }
        }
    }
    private func judgeNoThemeSentence(status: Int, data: Data) -> NetworkResult<Any> {
        let decoder = JSONDecoder()
        guard let decodedData = try? decoder.decode(GenericResponse<String>.self, from: data) else {
            return .pathErr
        }
        
        switch status {
        case 200:
            return .success(decodedData.data)
        case 400..<500:
            return .requestErr(decodedData.message)
        case 600:
            return .serverErr
        default:
            return .networkFail
        }
    }
}
