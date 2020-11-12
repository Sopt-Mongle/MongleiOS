//
//  MyProfileService.swift
//  Mongle
//
//  Created by 이예슬 on 7/18/20.
//  Copyright © 2020 이주혁. All rights reserved.
//

import Foundation
import Alamofire

struct MyProfileService {
    static let shared = MyProfileService()
    
    func getMy(completion : @escaping (NetworkResult<Any>) -> Void) {
        let header : HTTPHeaders = ["Content-Type" : "application/json","token":UserDefaults.standard.string(forKey:"token")!]
        print(UserDefaults.standard.string(forKey:"token")!)
        let dataRequest = Alamofire.request(APIConstants.myProfileURL,
                                            method: .get,
                                            parameters: nil,
                                            encoding: URLEncoding.default,
                                            headers: header)
        
        
        dataRequest.responseData { dataResponse in
            switch dataResponse.result {
                case .success :
                    guard let statusCode = dataResponse.response?.statusCode else {return}
                    guard let data = dataResponse.result.value else {return}
                    let networkResult = self.judge(flag: 1, by: statusCode, data)
                    completion(networkResult)
                    
                case .failure :
                    completion(.networkFail)
                    
                    
            }
            
            
        }

        
    }
    func uploadMy(img: UIImage,name: String, introduce: String, keywordIdx: Int, completion : @escaping(NetworkResult<Any>) -> Void) {
        let header: HTTPHeaders = [
            "Content-Type": "multipart/form-data",
            "token":UserDefaults.standard.string(forKey:"token")!]
        let body: Parameters = [
            "name": name,
            "introduce": introduce,
            "keywordIdx": keywordIdx
        ]
        Alamofire.upload(multipartFormData: {multiPartFormData in
            let imageData = img.jpegData(compressionQuality: 1.0)!
            multiPartFormData.append(imageData,withName:"img",mimeType:"image/jpeg")
            print("img")
            for (key,value) in body{
                if value is String{
                    let val = value as! String
                    multiPartFormData.append(val.data(using:String.Encoding.utf8)!,withName:key)
                    print(key)
                }
                else if value is Int{
                    let val = value as! Int
                    let convertedValueNumber: NSNumber = NSNumber(value: val)
                    let data = NSKeyedArchiver.archivedData(withRootObject: convertedValueNumber)
                    multiPartFormData.append("\(val)".data(using:String.Encoding.utf8)!, withName: key)
                    print(key)
                }
//                else if value is UIImage{
//                    let image = value as! UIImage
//                    let imageData = image.jpegData(compressionQuality: 1.0)!
//                    multiPartFormData.append(imageData,withName:key,mimeType:"image/jpeg")
//                    print(key)
//                }
            }

        },usingThreshold:UInt64.init(), to: APIConstants.myProfileURL,method:.post, headers:header, encodingCompletion: { result in
            switch result {
                case .success(let upload,_,_):
                    upload.uploadProgress(closure: { (progress) in
                                            print(progress.fractionCompleted) })
                    upload.responseData { response in
                        guard let statusCode = response.response?.statusCode, let data = response.result.value else { return }
                        let networkResult = self.judge(flag: 2, by: statusCode, data)
                        completion(networkResult)
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                    completion(.networkFail) }
        })
    }
    
    private func judge(flag: Int, by statusCode : Int , _ data : Data) -> NetworkResult<Any> {
        switch statusCode{
            case 200 :
                return getMyProfile(flag: flag, by: data)
            case 400:
                return showErrorMessage(by : data)
            case 600 :
                return .serverErr
            default :
                return .networkFail
        }
        
    }
    
    private func getMyProfile(flag: Int, by data : Data) -> NetworkResult<Any> {
        
        let decoder = JSONDecoder()
        if flag == 1{
            guard let decodedData = try? decoder.decode(GenericResponse<[MyProfileData]>.self, from: data)
            else { return .pathErr }
            
            guard let data = decodedData.data else{
                return .requestErr("디코딩실패")
            }
            return .success(data)
        }
        else{
            guard let decodedData = try? decoder.decode(GenericResponse<[MyProfileUploadData]>.self, from: data)
            else { return .pathErr }
            
            guard let data = decodedData.data else{
                return .requestErr("디코딩실패")
            }
            return .success(data)
        }
        
    }
    
    private func showErrorMessage(by data : Data) -> NetworkResult<Any> {
        let decoder = JSONDecoder()
        guard let decodedData = try? decoder.decode(GenericResponse<[MyProfileData]>.self, from: data)
        else { return .pathErr }
        
        print(decodedData.message)
        return .requestErr(decodedData.message)
    }
    
    
    
    
    
    
    
}
