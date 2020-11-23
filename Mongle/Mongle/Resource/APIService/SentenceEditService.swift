//
//  SentenceEditService.swift
//  Mongle
//
//  Created by 이주혁 on 2020/11/15.
//  Copyright © 2020 이주혁. All rights reserved.
//

import Foundation
import Alamofire

struct SentenceEditService {
    static let shared = SentenceEditService()
    
    func editSentence(idx: Int, sentence: String, completion: @escaping (NetworkResult<Any>) -> ()) {
        let token: String = UserDefaults.standard.string(forKey: UserDefaultKeys.token.rawValue) ?? "guest"
        
        let header: HTTPHeaders = [
            "Content-Type":"application/json",
            "token":token
        ]
        
        let body: Parameters = [
            "sentence" : sentence
        ]
        
        let url = APIConstants.myURL + "/\(idx)"
        
        Alamofire.request(url,
                          method: .put,
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
                                completion(self.judgeSenteceEdit(status: statusCode, data: data))
                            case .failure(let err):
                                print(err)
                                completion(.networkFail)
                            }
        }
    }
    
    private func judgeSenteceEdit(status: Int, data: Data) -> NetworkResult<Any> {
        
        struct EditSentence: Codable {
            var sentence: String
        }
        
        let decoder = JSONDecoder()
        guard let decodedData = try? decoder.decode(GenericResponse<EditSentence>.self, from: data) else {
            return .pathErr
        }
        switch status {
        case 200:
            return .success(decodedData.data?.sentence)
        case 400..<500:
            return .requestErr(decodedData.message)
        case 600:
            return .serverErr
        default:
            return .networkFail
        }
    }
    
    func deleteSentece(idx: Int, completion: @escaping (NetworkResult<Any>) ->()) {
        let token: String = UserDefaults.standard.string(forKey: UserDefaultKeys.token.rawValue) ?? "guest"
        
        let header: HTTPHeaders = [
            "Content-Type":"application/json",
            "token":token
        ]
        
        let url = APIConstants.myURL + "/\(idx)"
        
        Alamofire.request(url,
                          method: .delete,
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
                                completion(self.judgeSenteceDelete(status: statusCode, data: data))
                            case .failure(let err):
                                print(err)
                                completion(.networkFail)
                            }
        }
    }
    
    private func judgeSenteceDelete(status: Int, data: Data) -> NetworkResult<Any> {
        
        struct DeleteSentence: Codable {
            var deleteSentenceIdx: String
        }
        
        let decoder = JSONDecoder()
        guard let decodedData = try? decoder.decode(GenericResponse<DeleteSentence>.self, from: data) else {
            return .pathErr
        }
        switch status {
        case 200:
            return .success(decodedData.data?.deleteSentenceIdx)
        case 400..<500:
            return .requestErr(decodedData.message)
        case 600:
            return .serverErr
        default:
            return .networkFail
        }
    }
}
