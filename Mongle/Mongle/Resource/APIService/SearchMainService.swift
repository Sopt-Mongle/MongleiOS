//
//  RecentSearchService.swift
//  Mongle
//
//  Created by 이예슬 on 7/16/20.
//  Copyright © 2020 이주혁. All rights reserved.
//

import Foundation
import Alamofire

struct SearchMainService{
    static let shared = SearchMainService()
    func getRecentSearch(completion: @escaping (NetworkResult<Any>)-> Void){
        
        let token = UserDefaults.standard.string(forKey: UserDefaultKeys.token.rawValue) ?? ""
        let header: HTTPHeaders = ["Content-Type":"application/json","token":token]
        let dataRequest = Alamofire.request(APIConstants.recentSearchURL, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: header).responseData{
            response in
            switch response.result {
            case .success:
                guard let statusCode = response.response?.statusCode else {return}
                guard let value = response.result.value else {return}
                let networkResult = self.judgeSearchKeys(by: statusCode, value)
                
                completion(networkResult)
            case .failure: completion(.networkFail)
            }
        }
    }
    func deleteRecentSearch(completion: @escaping (NetworkResult<Any>)-> Void){
        
        let token = UserDefaults.standard.string(forKey: UserDefaultKeys.token.rawValue) ?? ""
        let header: HTTPHeaders = ["Content-Type":"application/json","token":token]
        let dataRequest = Alamofire.request(APIConstants.recentSearchURL, method: .delete, parameters: nil, encoding: JSONEncoding.default, headers: header).responseData{
            response in
            switch response.result {
            case .success:
                guard let statusCode = response.response?.statusCode else {return}
                guard let value = response.result.value else {return}
                let networkResult = self.judgeDeleteRecentSearch(by: statusCode, value)
                
                completion(networkResult)
            case .failure: completion(.networkFail)
            }
        }
    }
    func getRecommendSearch(completion: @escaping (NetworkResult<Any>)-> Void){
        
        let token = UserDefaults.standard.string(forKey: UserDefaultKeys.token.rawValue) ?? ""
        let header: HTTPHeaders = ["Content-Type":"application/json","token":token]
        let dataRequest = Alamofire.request(APIConstants.recommendSearchURL, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: header).responseData{
            response in
            switch response.result {
            case .success:
                guard let statusCode = response.response?.statusCode else {return}
                guard let value = response.result.value else {return}
                let networkResult = self.judgeSearchKeys(by: statusCode, value)
                
                completion(networkResult)
            case .failure: completion(.networkFail)
            }
        }
    }
    
    private func judgeSearchKeys(by statusCode:Int, _ data:Data) -> NetworkResult<Any> {
        let decoder = JSONDecoder()
            guard let decodedData = try? decoder.decode(GenericResponse<[String]>.self, from: data) else
            {return .pathErr}
        
        switch statusCode {
        case 200:
            return .success(decodedData.data)
        case 400,401:
            return .requestErr(decodedData.message)
        case 600:
            return .serverErr
        default: return .networkFail
        }
    }
    private func judgeDeleteRecentSearch(by statusCode:Int, _ data:Data) -> NetworkResult<Any> {
        let decoder = JSONDecoder()
            guard let decodedData = try? decoder.decode(GenericResponse<String>.self, from: data) else
            {return .pathErr}
        
        switch statusCode {
        case 200:
            return .success(decodedData.message)
        case 400,401:
            return .requestErr(decodedData.message)
        case 600:
            return .serverErr
        default: return .networkFail
        }
    }
    
        
}
