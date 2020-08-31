//
//  GoogleMap.swift
//  TaskMapCluster
//
//  Created by Mohanned on 7/14/20.
//  Copyright © 2020 Mohanned. All rights reserved.
//

import Foundation
import Alamofire



class APIServiceGeneric {

    static let instance = APIServiceGeneric() // singletone
    func getData(url: String, method: HTTPMethod?, parameters: Parameters?, encoding: ParameterEncoding?, headers: HTTPHeaders?, viewController: UIViewController?, completion: @escaping(JsonBase?, Error?)->()) {
        //present loader 

        //Alamofire
        Alamofire.request(url, method: method ?? .post, parameters: parameters, encoding: encoding ?? JSONEncoding.default, headers: headers)
            //            .validate(statusCode: 200..<300)
            .responseJSON { (response) in

                switch response.result {
                case .success(let value):
                    print(value, "VALUE")
                    guard let data = response.data else { return }
                    do {
                        let successData = try JSONDecoder().decode(JsonBase.self, from: data)
                        completion(successData, nil)
                    } catch let jsonError {
                        print(jsonError)
                    }

                case .failure(let error):
                    completion(nil, error)
                }
        }
    }
}
