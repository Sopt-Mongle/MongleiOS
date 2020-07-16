//
//  ThemeImageForWriteService.swift
//  Mongle
//
//  Created by Yunjae Kim on 2020/07/15.
//  Copyright © 2020 이주혁. All rights reserved.
//

import Foundation
import Alamofire


struct ThemeImageForWriteService {
    
    static let shared = ThemeImageForWriteService()
    func themeSetService(completion : @escaping (NetworkResult<Any>) -> Void) {
        let header : HTTPHeaders = ["Content-Type" : "application/json"]
        let dataRequest = Alamofire.request(APIConstants.getThemeImageForWritingURL,
                                            method: .get,
                                            encoding: JSONEncoding.default,
                                            headers: header)
        
        
        
        dataRequest.responseData { dataResponse in
            switch dataResponse.result {
            case .success :
                print("======================1=======================")
                guard let statusCode = dataResponse.response?.statusCode else {return}
                guard let data = dataResponse.result.value else {return}
                let networkResult = self.judge(by: statusCode, data)
                completion(networkResult)
                
            case .failure :
                print("======================2=======================")
                completion(.networkFail)
                
                
            }
            
            
        }
        
        
        
        
    }
    
    private func judge(by statusCode : Int , _ data : Data) -> NetworkResult<Any> {
        switch statusCode{
        case 200 :
            
            return getImages(by: data)
        case 600 :
            return .serverErr
        default :
            return .networkFail
            
        }
        
    }
    
    private func getImages(by data : Data) -> NetworkResult<Any> {
        let decoder = JSONDecoder()
        guard let decodedData = try? decoder.decode(GenericResponse<[ThemeImageforWriteInformation]>.self, from: data)
            else { return .pathErr }
        
        guard let datas = decodedData.data else{
            return .requestErr(decodedData.message)
        }
            
        
        
        
        return .success(datas)
        
    }
    
        
}
