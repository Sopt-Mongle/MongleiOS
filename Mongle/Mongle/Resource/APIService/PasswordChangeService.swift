//
//  PasswordChangeService.swift
//  Mongle
//
//  Created by 이예슬 on 11/19/20.
//  Copyright © 2020 이주혁. All rights reserved.
//

import Foundation
import Alamofire
struct PasswordChangeService{
    static let shared = PasswordChangeService()
    
    private func makeParameter(_ password : String)-> Parameters{
        return ["password" : password]
    }
    
    func putRequest(password:String, completion : @escaping (NetworkResult<Any>) -> Void){
        let header : HTTPHeaders = ["Content-Type" : "application/json", "token" : UserDefaults.standard.string(forKey: "token")!]
        
        let dataRequest = Alamofire.request(APIConstants.passwordChangeURL,
                                            method: .put,
                                            parameters: makeParameter(password),
                                            encoding: JSONEncoding.default,
                                            headers: header)
        
        
        dataRequest.responseData { dataResponse in
            switch dataResponse.result {
            case .success :
                guard let statusCode = dataResponse.response?.statusCode else {return}
                guard let data = dataResponse.value else {return}
                let networkResult = self.judgePut(by: statusCode, data)
                completion(networkResult)
              
            case .failure :
               
                completion(.networkFail)
                
                
            }
        }
    }
    private func judgePut( by statusCode:Int, _ data :Data) -> NetworkResult<Any> {
        let decoder = JSONDecoder()
        
            guard let decodedData = try? decoder.decode(GenericResponse<String>.self, from: data)
            else { return .pathErr }
        
        switch statusCode{
            case 200 :
                return .success(decodedData.message)
            case 400_:
                return .requestErr(decodedData.message)
            case 600 :
                return .serverErr
            default :
                return .networkFail
        }
        
    }

}
