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
        let token: String = UserDefaults.standard.string(forKey: UserDefaultKeys.token.rawValue) ?? "guest"
        
        let header: HTTPHeaders = [
            "Content-Type":"application/json",
            "token":token
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
        let token: String = UserDefaults.standard.string(forKey: UserDefaultKeys.token.rawValue) ?? "guest"
        
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
        let token: String = UserDefaults.standard.string(forKey: UserDefaultKeys.token.rawValue) ?? "guest"
        
        let header: HTTPHeaders = [
            "Content-Type":"application/json",
            "token":token
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
//                                print("Error#######################################")
                                print(err)
                                completion(.networkFail)
                            }
        }
    }
    
    func getThemeList(flag: Int, completion: @escaping ((NetworkResult<Any>)->Void)){
        
        let token: String = UserDefaults.standard.string(forKey: UserDefaultKeys.token.rawValue) ?? "guest"
        
        let header: HTTPHeaders = [
            "Content-Type":"application/json",
            "token":token
        ]
        
        var url = ""
        switch flag {
        case 0:
            url = APIConstants.mainThemesURL
        case 1:
            url = APIConstants.mainWaitThemesURL
        case 2:
            url = APIConstants.mainNowThemesURL
        default:
            break
        }
        
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
                                completion(self.judgeThemeList(status: statusCode, data: data))
                            case .failure(let err):
                                print(err)
                                completion(.networkFail)
                            }
        }
    }
    
    private func judgeThemeList(status: Int, data: Data) -> NetworkResult<Any> {
        let decoder = JSONDecoder()
        guard let decodedData = try? decoder.decode(GenericResponse<[MainThemeData]>.self, from: data) else {
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
    
    private func judgePopularCurator(status: Int, data: Data) -> NetworkResult<Any> {
        let decoder = JSONDecoder()
        guard let decodedData = try? decoder.decode(GenericResponse<[MainCuratorData]>.self, from: data) else {
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
    
    private func searchTodaySentence(status: Int, data: Data) -> NetworkResult<Any> {
        let decoder = JSONDecoder()
        guard let decodedData = try? decoder.decode(GenericResponse<[TodaySentenceData]>.self, from: data)
            else {
                return .pathErr
        }
        
        switch status {
        case 200:
            return .success(decodedData.data)
        case 400, 401:
            return .requestErr(decodedData.message)
        case 600:
            return .serverErr
        default:
            return .networkFail
        }
    }
    
    private func judge(by statusCode : Int , _ data : Data) -> NetworkResult<Any> {
        let decoder = JSONDecoder()
        guard let decodedData = try? decoder.decode(GenericResponse<[EditorPickData]>.self, from: data)
            else {
                return .pathErr
        }
        switch statusCode{
        case 200 :
            return .success(decodedData.data)
        case 400 :
            return .requestErr(decodedData.message)
        case 600 :
            return .serverErr
        default :
            return .networkFail
        }
    }
}
