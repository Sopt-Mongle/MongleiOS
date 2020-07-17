//
//  ThemeService.swift
//  Mongle
//
//  Created by 이주혁 on 2020/07/17.
//  Copyright © 2020 이주혁. All rights reserved.
//

import Foundation

import Alamofire


struct ThemeService {
    static let shared = ThemeService()
    
    func getThemeInfo(idx: Int, completion: @escaping ((NetworkResult<Any>)->Void)) {
        let token = UserDefaults.standard.string(forKey: UserDefaultKeys.token.rawValue)!
        
        let header: HTTPHeaders = [
            "Content-Type":"application/json",
            "token":token
        ]
        
        let url = APIConstants.detailThemeURL + "/\(idx)"
        
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
                                completion(self.judgeThemeData(status: statusCode, data: data))
                            case .failure(let err):
                                completion(.networkFail)
                            }
        }
    }
    
    private func judgeThemeData(status: Int, data: Data) -> NetworkResult<Any> {
        let decoder = JSONDecoder()
        guard let decodedData = try? decoder.decode(GenericResponse<ThemeInfoData>.self, from: data) else {
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
    
    func putBookmark(idx: Int, completion: @escaping ((NetworkResult<Any>)->Void)) {
        let token = UserDefaults.standard.string(forKey: UserDefaultKeys.token.rawValue)!
        
        let header: HTTPHeaders = [
            "Content-Type":"application/json",
            "token":token
        ]
        
        let url = APIConstants.detailThemeURL + "/\(idx)/bookmark"
        
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
                                completion(self.judgeBookmark(status: statusCode, data: data))
                            case .failure(let err):
                                print(err)
                                completion(.networkFail)
                            }
        }
    }
    
    func judgeBookmark(status: Int, data: Data) -> NetworkResult<Any> {
        let decoder = JSONDecoder()
        guard let decodedData = try? decoder.decode(GenericResponse<ThemeBookmarkData>.self, from: data) else {
            return .pathErr
        }
        switch status {
        case 200:
            return .success(decodedData.data)
        case 400:
            return .requestErr(decodedData.message)
        case 600:
            return .serverErr
        default:
            return .networkFail
        }
    }
}
