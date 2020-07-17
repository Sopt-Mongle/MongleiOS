//
//  BookSearchForWritingService.swift
//  Mongle
//
//  Created by Yunjae Kim on 2020/07/16.
//  Copyright © 2020 이주혁. All rights reserved.
//

import Foundation
import Alamofire

struct BookSearchForWritingService {
    
    static let shared = BookSearchForWritingService()
    
    private func makeParameter(_ title : String)-> Parameters{
        return ["query" : title]
    }
    
    func bookSearch(title : String, completion : @escaping (NetworkResult<Any>) -> Void){
        let header : HTTPHeaders = ["Content-Type" : "application/json"]
        
        
        let dataRequest = Alamofire.request(APIConstants.bookSearchForWritingURL,
                                            method: .get,
                                            parameters: makeParameter(title),
                                            encoding: URLEncoding.default,
            headers: header)
        
        
        
        dataRequest.responseData { dataResponse in
            switch dataResponse.result {
            case .success :
                
                guard let statusCode = dataResponse.response?.statusCode else {return}
                guard let data = dataResponse.value else {return}
                let networkResult = self.judge(by: statusCode, data)
                completion(networkResult)
                
            case .failure(let err):
                print(err)
                completion(.networkFail)
                
                
            }
            
            
        }
    }
    
    
    private func judge(by statusCode : Int , _ data : Data) -> NetworkResult<Any> {
        switch statusCode{
        case 200 :
            return getBooks(by: data)
        case 400 :
            return emptyRequest(by: data)
        case 600 :
            return .serverErr
        default :
            return .networkFail
            
        }
        
    }
    
    private func getBooks(by data : Data) -> NetworkResult<Any> {
        let decoder = JSONDecoder()
        guard let decodedData = try? decoder.decode(GenericResponse<[BookSearchForWritingData]>.self, from: data)
            else { return .pathErr }
        
        guard let datas = decodedData.data else{
            return .requestErr(decodedData.message)
        }
        
        
        
        
        return .success(datas)
        
    }
    
     private func emptyRequest(by data : Data) -> NetworkResult<Any> {
        let decoder = JSONDecoder()
        guard let decodedData = try? decoder.decode(GenericResponse<[BookSearchForWritingData]>.self, from: data)
            else { return .pathErr }
        
       
        return .requestErr(decodedData.message)
        
    }
    
    
    
    
}


    
    
