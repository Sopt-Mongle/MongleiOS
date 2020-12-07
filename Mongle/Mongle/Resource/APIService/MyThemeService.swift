//
//  MyThemeService.swift
//  Mongle
//
//  Created by 이예슬 on 7/18/20.
//  Copyright © 2020 이주혁. All rights reserved.
//

import Foundation
import Alamofire

struct MyThemeService {
    static let shared = MyThemeService()
    
    func getMy(completion : @escaping (NetworkResult<Any>) -> Void) {
        let header : HTTPHeaders = ["Content-Type" : "application/json","token":UserDefaults.standard.string(forKey:"token")!]
        let dataRequest = Alamofire.request(APIConstants.myThemeURL,
                                            method: .get,
                                            parameters:nil,
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
            return getMyTheme(by: data)
        case 400,401:
            return showErrorMessage(by : data)
        case 600 :
            return .serverErr
        default :
            return .networkFail
            
        }
        
        
    }
    
    private func getMyTheme(by data : Data) -> NetworkResult<Any> {
      
        let decoder = JSONDecoder()
        guard let decodedData = try? decoder.decode(GenericResponse<MyThemeData>.self, from: data)
            else { return .pathErr }
        
        print("@@@테마 데이터 \(decodedData)")
        guard let data = decodedData.data else{
            return .requestErr(decodedData.message)
        }
        
        return .success(data)
        
    }
    
    private func showErrorMessage(by data : Data) -> NetworkResult<Any> {
        let decoder = JSONDecoder()
        guard let decodedData = try? decoder.decode(GenericResponse<MyThemeData>.self, from: data)
            else { return .pathErr }
        
        print(decodedData.message)
        return .requestErr(decodedData.message)
    }

    
}
