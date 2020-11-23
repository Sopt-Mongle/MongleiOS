//
//  SentenceService.swift
//  Mongle
//
//  Created by 이주혁 on 2020/07/17.
//  Copyright © 2020 이주혁. All rights reserved.
//

import Foundation

import Alamofire

struct SentenceService {
    static let shared = SentenceService()
    
    func getSentence(idx: Int, completion: @escaping ((NetworkResult<Any>) -> Void)) {
        let token: String = UserDefaults.standard.string(forKey: UserDefaultKeys.token.rawValue) ?? "guest"
        
        let header: HTTPHeaders = [
            "Content-Type":"application/json",
            "token":token
        ]
        
        let url = APIConstants.detailSentenceURL + "/\(idx)"
        Alamofire.request(url,
                          method: .get,
                          parameters: nil,
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
                                completion(self.judgeSentenceData(status: statusCode, data: data))
                            case .failure(let err):
                                print(err)
                                completion(.networkFail)
                            }
        }
    }
    
    private func judgeSentenceData(status: Int, data: Data) -> NetworkResult<Any> {
        let decoder = JSONDecoder()
        guard let decodedData = try? decoder.decode(GenericResponse<[DetailSentenceInfo]>.self, from: data) else {
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
    
    func getOtherSentenceInTheme(idx: Int, completion: @escaping((NetworkResult<Any>) -> Void)) {
        let token = UserDefaults.standard.string(forKey: UserDefaultKeys.token.rawValue)!
         
         let header: HTTPHeaders = [
             "Content-Type":"application/json",
             "token":token
         ]
        
        let url = APIConstants.detailSentenceURL + "/\(idx)/other"
        
        Alamofire.request(url,
                          method: .get,
                          parameters: nil,
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
                                completion(self.judgeOtherSentenceData(status: statusCode, data: data))
                            case .failure(let err):
                                print(err)
                                completion(.networkFail)
                            }
        }
         
    }
    
    private func judgeOtherSentenceData(status: Int, data: Data) -> NetworkResult<Any> {
        let decoder = JSONDecoder()
        guard let decodedData = try? decoder.decode(GenericResponse<[OtherSentence]>.self, from: data) else {
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
    
    func putSentenceLike(idx: Int, completion: @escaping ((NetworkResult<Any>) -> Void)) {
        let token = UserDefaults.standard.string(forKey: UserDefaultKeys.token.rawValue)!
        
        let header: HTTPHeaders = [
            "Content-Type":"application/json",
            "token":token
        ]
        
        let url = APIConstants.detailSentenceURL + "/\(idx)/like"
        
        Alamofire.request(url,
                          method: .put,
                          parameters: nil,
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
                                completion(self.judgePutLike(status: statusCode, data: data))
                            case .failure(let err):
                                print(err)
                                completion(.networkFail)
                            }
        }
    }
    
    func judgePutLike(status: Int, data: Data) -> NetworkResult<Any> {
        let decoder = JSONDecoder()
        guard let decodedData = try? decoder.decode(GenericResponse<SentenceLikeData>.self, from: data) else {
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
    
    func putBookmark(idx: Int, completion: @escaping ((NetworkResult<Any>) -> Void)) {
        let token = UserDefaults.standard.string(forKey: UserDefaultKeys.token.rawValue)!
        
        let header: HTTPHeaders = [
            "Content-Type":"application/json",
            "token":token
        ]
        
        let url = APIConstants.detailSentenceURL + "/\(idx)/bookmark"
        
        Alamofire.request(url,
                          method: .put,
                          parameters: nil,
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
                                completion(self.judgePutBookmark(status: statusCode, data: data))
                            case .failure(let err):
                                print(err)
                                completion(.networkFail)
                            }
        }
    }
    
    private func judgePutBookmark(status: Int, data: Data) -> NetworkResult<Any> {
        let decoder = JSONDecoder()
        guard let decodedData = try? decoder.decode(GenericResponse<SentenceBookmarkData>.self, from: data) else {
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
