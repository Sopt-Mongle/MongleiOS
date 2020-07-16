//
//  SignUpService.swift
//  Mongle
//
//  Created by Yunjae Kim on 2020/07/15.
//  Copyright © 2020 이주혁. All rights reserved.
//

import Foundation
import Alamofire



struct SignUpService {
    static let shared = SignUpService()
    
    private func makeParameter(_ email : String,_ password : String, _ name : String)-> Parameters{
        return ["email" : email, "password" : password, "name" : name]
    }
    
    func signup(email : String, password : String, name : String, completion : @escaping (NetworkResult<Any>) -> Void){
        let header : HTTPHeaders = ["Content-Type" : "application/json"]
        
        let dataRequest = Alamofire.request(APIConstants.signupURL,
                                            method: .post,
                                            parameters: makeParameter(email, password,name),
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
            return isSignUp(by: data)
        case 400 :
            return .pathErr
        case 600 :
            return .serverErr
        default :
            return .networkFail
            
        }
        
    }
    
    private func isSignUp(by data : Data) -> NetworkResult<Any> {
        let decoder = JSONDecoder()
        guard let decodedData = try? decoder.decode(GenericResponse<SignupData>.self, from: data) else { return .serverErr }
        if (decodedData.success){
            print(decodedData.status)
            print(decodedData.message)
            return .success(data)
        }
        
        return .requestErr(decodedData.message)
        
        
    }
    
   
    
    
    
    
    
    
    
    
    
    
 
    
}
