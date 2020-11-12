//
//  SignUpDuplicateService.swift
//  Mongle
//
//  Created by Yunjae Kim on 2020/11/12.
//  Copyright © 2020 이주혁. All rights reserved.
//

import Foundation
import Alamofire


struct SignUpDuplicateService {
    static let shared = SignUpDuplicateService()
    
    private func makeParameter(_ email : String,_ name : String)-> Parameters{
        return ["email" : email, "name" : name]
    }
    
    func checkDuplicate(email : String, name : String, completion : @escaping (NetworkResult<Any>) -> Void){
        let header : HTTPHeaders = ["Content-Type" : "application/json"]
        
        let dataRequest = Alamofire.request(APIConstants.signupDuplicateURL,
                                            method: .post,
                                            parameters: makeParameter(email,name),
                                            encoding: JSONEncoding.default,
                                            headers: header)
        
        
        dataRequest.responseData { dataResponse in
            switch dataResponse.result {
            case .success :
                print("succccceeesss")
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
            return succeed(by: data)
        case 400 :
            print("400__")
            return .pathErr
        case 600 :
            print("600__")
            return .serverErr
        default :
            print("other__")
            return .networkFail
            
        }
        
    }
    
    private func succeed(by data : Data) -> NetworkResult<Any> {
        let decoder = JSONDecoder()
        guard let decodedData = try? decoder.decode(GenericResponse<DataClass>.self, from: data) else { return .serverErr }
        guard let tokenData = decodedData.data else { return .requestErr(decodedData.message) }
        return .success(tokenData.duplicate)
        
    }
    
    
    
    
    
    
    
}
