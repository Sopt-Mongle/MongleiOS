//
//  ThemeMakeService.swift
//  Mongle
//
//  Created by Yunjae Kim on 2020/07/15.
//  Copyright © 2020 이주혁. All rights reserved.
//

import Foundation

import Alamofire


struct ThemeMakeService {
    static let shared = ThemeMakeService()
    
    private func makeParameter(_ theme : String,_ themeImgIdx : Int)-> Parameters{
        return ["theme" : theme, "themeImgIdx" : themeImgIdx]
    }
    
    func themeMake(theme : String, themeImgIdx : Int, completion : @escaping (NetworkResult<Any>) -> Void){
        let header : HTTPHeaders = ["Content-Type" : "application/json" , "token": UserDefaults.standard.string(forKey: UserDefaultKeys.token.rawValue)!]
        
        
        
        let dataRequest = Alamofire.request(APIConstants.makeThemeURL,
                                            method: .post,
                                            parameters: makeParameter(theme, themeImgIdx),
                                            encoding: JSONEncoding.default,
                                            headers: header)
        
        
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
            return isMakingTheme(by: data)
        case 400 :
            return hasReqError(by: data)
        case 600 :
            return .serverErr
        default :
            return .networkFail
            
        }
        
    }
    
    private func isMakingTheme(by data : Data) -> NetworkResult<Any> {
        let decoder = JSONDecoder()
        guard let decodedData = try? decoder.decode(GenericResponse<Int>.self, from: data)
            else { return .serverErr }

        
        return .success(decodedData.data)
        
        
    }
    
    private func hasReqError(by data : Data) -> NetworkResult<Any> {
        let decoder = JSONDecoder()
        guard let decodedData = try? decoder.decode(GenericResponse<ThemeMakeData>.self, from: data)
            else { return .serverErr }

        
        return .requestErr(decodedData.message)
        
        
    }
    
    

    
    
    
    
}
 
