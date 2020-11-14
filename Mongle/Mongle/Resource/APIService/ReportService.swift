//
//  ReportService.swift
//  Mongle
//
//  Created by 이주혁 on 2020/11/14.
//  Copyright © 2020 이주혁. All rights reserved.
//

import Foundation
import Alamofire

struct ReportService {
    static let shared = ReportService()
    
    func report(type: String, idx: Int, content: String, completion: @escaping (NetworkResult<Any>) -> ()) {
        
        let token: String = UserDefaults.standard.string(forKey: UserDefaultKeys.token.rawValue) ?? "guest"
        
        let header: HTTPHeaders = [
            "Content-Type":"application/json",
            "token":token
        ]
        
        let parameter: Parameters = [
            "sort": type,
            "idx": idx,
            "content" : content
        ]
        
        let url = APIConstants.detailReportURL
        
        Alamofire.request(url,
                          method: .post,
                          parameters: parameter,
                          encoding: JSONEncoding.default,
                          headers: header).responseData { response in
                            switch response.result {
                            case .success:
                                guard let statusCode = response.response?.statusCode else {
                                    return
                                }
                                guard let data = response.value else {
                                    return
                                }
                                completion(self.judge(status: statusCode, data: data))
                            case .failure(let err):
                                print(err)
                                completion(.networkFail)
                            }
        }
        
        
    }
    
    private func judge(status: Int, data: Data) -> NetworkResult<Any> {
        let decoder = JSONDecoder()
        guard let decodedData = try? decoder.decode(GenericResponse<String>.self, from: data) else {
            return .pathErr
        }
        switch status {
        case 200:
            return .success(decodedData.data)
        case 400..<500:
            return .requestErr(decodedData.message)
        case 600:
            return .serverErr
        default:
            return .networkFail
        }
    }
}
