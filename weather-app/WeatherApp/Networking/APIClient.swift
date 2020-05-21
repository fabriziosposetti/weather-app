//
//  APIClient.swift
//  weather-app
//
//  Created by Fabrizio Sposetti on 17/05/2020.
//  Copyright © 2020 Fabrizio Sposetti. All rights reserved.
//

import Alamofire
import PromiseKit
import SwiftyJSON

class APIClient {
    
    static func request<T>(request: URLRequest) -> Promise<T> where T: Decodable {
        return Promise { completion in
            if Connectivity.isConnectedToInternet() {
                AF.request(request)
                    .responseDecodable {(response: DataResponse<T, AFError>) in
                        switch response.result {
                        case .success(let value):
                            completion.fulfill(value)
                        case .failure(let error):
                            if let data = response.data {
                                let json = JSON(data)
                                let error = AppWeatherError(error: json)
                                completion.reject(error)
                                return
                            }
                            completion.reject(error)
                        }
                }
            } else {
                let error = AppWeatherError.notConnectedToInternet
                completion.reject(error)
            }
        }
    }
}

class Connectivity {
    class func isConnectedToInternet() -> Bool {
        return NetworkReachabilityManager()?.isReachable ?? false
    }
}
