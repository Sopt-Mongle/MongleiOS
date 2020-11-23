//
//  WithdrawService.swift
//  Mongle
//
//  Created by 이예슬 on 11/15/20.
//  Copyright © 2020 이주혁. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

struct WithdrawService{
    static let shared = WithdrawService()
    
    private func makeParameter(_ email : String,_ password : String)-> Parameters{
        return ["email" : email, "password" : password]
    }
    
    func deleteRequest(email:String, password:String, completion : @escaping (NetworkResult<Any>) -> Void){
        let header : HTTPHeaders = ["Content-Type" : "application/json", "token" : UserDefaults.standard.string(forKey: "token")!]
        
        let dataRequest = Alamofire.request(APIConstants.withdrawURL,
                                            method: .delete,
                                            parameters: makeParameter(email, password),
                                            encoding: JSONEncoding.default,
                                            headers: header)
        
        
        dataRequest.responseData { dataResponse in
            switch dataResponse.result {
            case .success :
                guard let statusCode = dataResponse.response?.statusCode else {return}
                guard let data = dataResponse.value else {return}
                let networkResult = self.judgeDelete(by: statusCode, data)
                completion(networkResult)
              
            case .failure :
               
                completion(.networkFail)
                
                
            }
        }
    }
    private func judgeDelete( by statusCode:Int, _ data :Data) -> NetworkResult<Any> {
        let decoder = JSONDecoder()
        
            guard let decodedData = try? decoder.decode(GenericResponse<String>.self, from: data)
            else { return .pathErr }
        
        switch statusCode{
            case 200 :
                return .success(decodedData.message)
            case 400:
                return .requestErr(decodedData.message)
            case 600 :
                return .serverErr
            default :
                return .networkFail
        }
        
    }

}

