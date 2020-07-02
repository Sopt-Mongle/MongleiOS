//
//  GenericResponse.swift
//  Mongle
//
//  Created by 이주혁 on 2020/07/02.
//  Copyright © 2020 이주혁. All rights reserved.
//

import Foundation

struct GenericResponse<T: Codable>: Codable {
    
       var status: Int
       var success: Bool
       var message: String
       var data: T?
       
       enum CodingKeys: String, CodingKey {
           case status = "status"
           case success = "success"
           case message = "message"
           case data = "data"
       }
       
       init(from decoder: Decoder) throws {
              let values = try decoder.container(keyedBy: CodingKeys.self)
              status = (try? values.decode(Int.self, forKey: .status)) ?? -1
              success = (try? values.decode(Bool.self, forKey: .success)) ?? false
              message = (try? values.decode(String.self, forKey: .message)) ?? ""
              data = (try? values.decode(T.self, forKey: .data)) ?? nil
          }
}
