//
//  NetworkCall.swift
//  M-V-C
//
//  Created by Axat MAC Mini 1 on 19/07/19.
//  Copyright © 2019 Axat MAC Mini 1. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class NetworkCall {
    
    class func Login(forUser user: User, completion: @escaping (Bool, String?, UserDetail?) -> Void) {
        let params = ["email": user.Email, "password": user.Password]
        Alamofire.request(URL(string: "http://18.216.238.150/energyeye/public/api/user/login")!, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
            switch response.result {
            case .success(_):
                if response.result.isSuccess {
                    let Data = JSON(response.result.value!)
                    print(Data)
                    if Data["token"].exists() {
                        completion(true, nil, UserDetail(Email: Data["user_details"]["email"].stringValue, Name: Data["user_details"]["name"].stringValue, id: Data["user_details"]["id"].stringValue, token: Data["token"].stringValue, mobile: Data["user_details"]["mobile_no"].stringValue))
                        
                    } else {
                        completion(false, Data["error"].stringValue, nil)
                    }
                } else {
                    completion(false, (response.result.error?.localizedDescription)!, nil)
                }
                break
            case .failure(let error):
                completion(false, error.localizedDescription, nil)
                break
            }
        }
    }
    
    class func PerformCall(url: String, params: [String: String], completion: @escaping (Bool, String?, JSON?) -> Void) {
        Alamofire.request(URL(string: url)!, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
            switch response.result {
            case .success(_):
                if response.result.isSuccess {
                    let Data = JSON(response.result.value!)
                    print(Data)
                    completion(true, nil, Data)
                } else {
                    completion(false, (response.result.error?.localizedDescription)!, nil)
                }
                break
            case .failure(let error):
                completion(false, error.localizedDescription, nil)
                break
            }
        }
    }
}
