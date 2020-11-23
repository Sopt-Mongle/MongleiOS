//
//  SignUpEmail.swift
//  Mongle
//
//  Created by Yunjae Kim on 2020/11/11.
//  Copyright © 2020 이주혁. All rights reserved.
//

import Foundation
import Alamofire

struct SignUpEmailService{
    static let shared = SignUpEmailService()
    private func makeParameter(_ email : String)-> Parameters{
        return ["email" : email]
    }
    
    func signup(email : String , completion : @escaping (NetworkResult<Any>) -> Void){
        let header : HTTPHeaders = ["Content-Type" : "application/json"]
        
        let dataRequest = Alamofire.request(APIConstants.signupEmailURL,
                                            method: .post,
                                            parameters: makeParameter(email),
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
        guard let decodedData = try? decoder.decode(GenericResponse<SignUpEmailData>.self, from: data) else { return .serverErr }
        guard let tokenData = decodedData.data else { return .requestErr(decodedData.message) }
        return .success(tokenData.authNum)
        
        
        
    }


}
