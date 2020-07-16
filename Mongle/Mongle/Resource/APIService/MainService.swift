//
//  MainService.swift
//  Mongle
//
//  Created by 이주혁 on 2020/07/16.
//  Copyright © 2020 이주혁. All rights reserved.
//

import Foundation
import Alamofire

struct MainService {
    static let shared = MainService()
    
    func getEditorsPick(completion: @escaping ((NetworkResult<Any>)->Void)) {
        let header: HTTPHeaders = [
            "Content-Type":"application/json"
        ]
        
        Alamofire.request(APIConstants.mainEditorPick,
                          method: .get,
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
                                let networkResult = self.judge(by: statusCode, data)
                                completion(networkResult)
                            case .failure(let err):
                                print(err)
                            }
        }
    }
    
    func getTodaySentence(completion: @escaping ((NetworkResult<Any>)->Void)) {
        let token = UserDefaults.standard.string(forKey: UserDefaultKeys.token.rawValue)!
        
        let header: HTTPHeaders = [
            "Content-Type":"application/json",
            "token":token
        ]
        
        Alamofire.request(APIConstants.mainSentencesURL,
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
                                completion(self.searchTodaySentence(status: statusCode, data: data))
                            case .failure(let err):
                                print(err)
                                completion(.networkFail)
                            }
                            
        }
    }
    
    func getPopularCurator(completion: @escaping ((NetworkResult<Any>)->Void)) {
        
        let header: HTTPHeaders = [
            "Content-Type" : "application/json"
        ]
        
        Alamofire.request(APIConstants.mainCuratorURL,
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
                                completion(self.judgePopularCurator(status: statusCode, data: data))
                            case .failure(let err):
                                print(err)
                                completion(.networkFail)
                            }
        }
    }
    
    func getThemeList(completion: @escaping ((NetworkResult<Any>)->Void)){
        let token = UserDefaults.standard.string(forKey: UserDefaultKeys.token.rawValue)!
        
        let header: HTTPHeaders = [
            "Content-Type" : "application/json",
            "token":token
        ]
        
        Alamofire.request(APIConstants.mainThemesURL,
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
//                                completion(self.judgeThemeList(status: statusCode, data: data))
                            case .failure(let err):
                                print(err)
                                completion(.networkFail)
                            }
        }
    }
    
//    private func judgeThemeList(status: Int, data: Data) -> NetworkResult<Any> {
//        let decoder = JSONDecoder()
//
//        switch status {
//        case 200:
//            break
//        case 400..<500:
//            break
//        case 600:
//            break
//        default:
//            break
//        }
//    }
    
    private func judgePopularCurator(status: Int, data: Data) -> NetworkResult<Any> {
        let decoder = JSONDecoder()
        
        switch status {
        case 200:
            guard let decodedData = try? decoder.decode(GenericResponse<[MainCuratorData]>.self, from: data) else {
                return .pathErr
            }
            
            return .success(decodedData.data)
            
        case 400:
            guard let decodedData = try? decoder.decode(GenericResponse<[MainCuratorData]>.self, from: data)
                else {
                    return .pathErr
            }
            return .requestErr(decodedData.message)
        case 600:
            return .serverErr
        default:
            return .networkFail
        }
        
    }
    
    private func searchTodaySentence(status: Int, data: Data) -> NetworkResult<Any> {
        let decoder = JSONDecoder()
        
        switch status {
        case 200:
            guard let decodedData = try? decoder.decode(GenericResponse<[TodaySentenceData]>.self, from: data)
                else {
                    return .pathErr
            }
            return .success(decodedData.data)
        case 400, 401:
            guard let decodedData = try? decoder.decode(GenericResponse<[TodaySentenceData]>.self, from: data)
                else {
                    return .pathErr
            }
            return .requestErr(decodedData.message)
        case 600:
            return .serverErr
        default:
            return .networkFail
        }
    }
    
    private func judge(by statusCode : Int , _ data : Data) -> NetworkResult<Any> {
        let decoder = JSONDecoder()
        
        switch statusCode{
        case 200 :
            
            guard let decodedData = try? decoder.decode(GenericResponse<[EditorPickData]>.self, from: data)
                else {
                    return .pathErr
            }
            return .success(decodedData.data)
        case 400 :
            guard let decodedData = try? decoder.decode(GenericResponse<[EditorPickData]>.self, from: data)
                else {
                    return .pathErr
            }
            return .requestErr(decodedData.message)
        case 600 :
            return .serverErr
        default :
            return .networkFail
            
        }
        
    }
}
