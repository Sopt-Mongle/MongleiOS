//
//  CuratorInfoService.swift
//  Mongle
//
//  Created by 이예슬 on 7/17/20.
//  Copyright © 2020 이주혁. All rights reserved.
//

import Foundation
import Alamofire

struct CuratorInfoService {
    static let shared = CuratorInfoService()
    
    func getCuratorInfo(curatorIdx : Int, completion : @escaping (NetworkResult<Any>) -> Void) {
        let header : HTTPHeaders = ["Content-Type" : "application/json","token" : UserDefaults.standard.string(forKey: UserDefaultKeys.token.rawValue)!]
        let dataRequest = Alamofire.request(APIConstants.curatorURL+"/\(curatorIdx)",
                                            method: .get,
                                            parameters: nil,
                                            encoding: URLEncoding.default,
                                            headers: header)
        
        
        dataRequest.responseData { dataResponse in
            switch dataResponse.result {
            case .success :
                guard let statusCode = dataResponse.response?.statusCode else {return}
                guard let data = dataResponse.result.value else {return}
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
            return getCuratorData(by: data)
        case 400:
            return showErrorMessage(by : data)
        case 600 :
            return .serverErr
        default :
            return .networkFail
            
        }
        
    }
    
    private func getCuratorData(by data : Data) -> NetworkResult<Any> {
      
        let decoder = JSONDecoder()
        guard let decodedData = try? decoder.decode(GenericResponse<CuratorInfoData>.self, from: data)
            else { return .pathErr }
        
        
        guard let data = decodedData.data else{
            return .requestErr(decodedData.message)
        }
        
        return .success(data)
        
    }
    
    private func showErrorMessage(by data : Data) -> NetworkResult<Any> {
        let decoder = JSONDecoder()
        guard let decodedData = try? decoder.decode(GenericResponse<CuratorInfoData>.self, from: data)
            else { return .pathErr }
        
        print(decodedData.message)
        return .requestErr(decodedData.message)
    }
    
    
    
    
    
    
    
}

