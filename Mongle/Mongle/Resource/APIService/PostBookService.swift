//
//  PostBookService.swift
//  Mongle
//
//  Created by Yunjae Kim on 2020/07/16.
//  Copyright © 2020 이주혁. All rights reserved.
//

import Foundation
import Alamofire

struct PostBookService {
    
    static let shared = PostBookService()
    
    
    private func makeParameter(sentence : String , title : String, author : String ,
                               publisher : String, themeIdx : Int)-> Parameters{
        return ["sentence" : sentence, "title" : title,"author" : author,
                "publisher" : publisher,"themeIdx" : themeIdx]
    }
    
    func postBook(sentence : String , title : String, author : String ,
                publisher : String, themeIdx : Int, completion : @escaping (NetworkResult<Any>) -> Void){
        let header : HTTPHeaders = ["Content-Type" : "application/json","token": UserDefaults.standard.string(forKey: UserDefaultKeys.token.rawValue)!]
        
        let dataRequest = Alamofire.request(APIConstants.postSentenceURL,
                                            method: .post,
                                            parameters: makeParameter(sentence: sentence, title: title, author: author, publisher: publisher, themeIdx: themeIdx),
                                            encoding: JSONEncoding.default,
                                            headers: header)
        
        print(["sentence" : sentence, "title" : title,"author" : author,
        "publisher" : publisher,"themeIdx" : themeIdx])
        dataRequest.responseData { dataResponse in
            switch dataResponse.result {
            case .success :
                guard let statusCode = dataResponse.response?.statusCode else {return}
                guard let data = dataResponse.value else {return}
                let networkResult = self.judge(by: statusCode, data)
                completion(networkResult)
                
            case .failure :
                completion(.networkFail)
                
                
            }
            
            
        }
    }
    
    private func judge(by statusCode : Int , _ data : Data) -> NetworkResult<Any> {
        switch statusCode{
        case 200 :
            return send(by: data)
        case 400 :
            return showErrorMessage(by: data)
        case 600 :
            return .serverErr
        default :
            return .networkFail
            
        }
        
    }
    
    private func send(by data : Data) -> NetworkResult<Any> {
        let decoder = JSONDecoder()
        guard let decodedData = try? decoder.decode(GenericResponse<PostBookData>.self, from: data)
            else { return .serverErr }
        
        return .success(decodedData)
        
        
    }
    
    private func showErrorMessage(by data : Data) -> NetworkResult<Any> {
        let decoder = JSONDecoder()
        guard let decodedData = try? decoder.decode(GenericResponse<[SearchThemeData]>.self, from: data)
            else { return .pathErr }
        
        print(decodedData.message)
        return .requestErr(decodedData.message)
    }
    
    
    
    
}
