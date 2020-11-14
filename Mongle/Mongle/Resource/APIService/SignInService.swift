//
//  SignInService.swift
//  Mongle
//
//  Created by Yunjae Kim on 2020/07/15.
//  Copyright © 2020 이주혁. All rights reserved.
//

import Foundation
import Alamofire



struct SignInService {
    static let shared = SignInService()
    
    private func makeParameter(_ email : String,_ password : String)-> Parameters{
        return ["email" : email, "password" : password]
    }
    
    func signin(email : String, password : String, completion : @escaping (NetworkResult<Any>) -> Void){
        let header : HTTPHeaders = ["Content-Type" : "application/json"]
        
        let dataRequest = Alamofire.request(APIConstants.signinURL,
                                            method: .post,
                                            parameters: makeParameter(email, password),
                                            encoding: JSONEncoding.default,
                                            headers: header)
        
        
        dataRequest.responseData { dataResponse in
            switch dataResponse.result {
            case .success :
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                let date = Date()
                let dateString = dateFormatter.string(from: date)
                UserDefaults.standard.setValue(dateString, forKey: "tokenTime")
                
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
            return isUser(by: data)
        case 400 :
            return .pathErr
        case 600 :
            return .serverErr
        default :
            return .networkFail
            
        }
        
    }
    
    private func isUser(by data : Data) -> NetworkResult<Any> {
        let decoder = JSONDecoder()
        guard let decodedData = try? decoder.decode(GenericResponse<SigninData>.self, from: data)
            else { return .serverErr }
        guard let tokenData = decodedData.data else { return .requestErr(decodedData.message) }
        return .success(tokenData.accessToken)
        
        
    }
    
    
    
    
 
    
}
