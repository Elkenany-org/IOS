//
//  ApiServiceForQueryParamater.swift
//  Elkenany-Project
//
//  Created by عبدالعزيز رضا  on 12/11/21.
//

import Foundation
import Alamofire

class APIServiceForQueryParameter {
    static let shared = APIServiceForQueryParameter() // Singltone
    
    func fetchData<T: Codable, E: Codable>(url: String, parameters: Parameters?, headers: HTTPHeaders?, method: HTTPMethod?, completion: @escaping((T?, E?, Error?)->Void)) {
        Alamofire.request(url, method: method ?? .get, parameters: parameters, encoding:URLEncoding.queryString, headers: headers)
            .validate(statusCode: 200..<300)
            .responseJSON { (response) in
                switch response.result {
                case .success(_):
                    do {
                        guard let data = response.data else { return }
                        let reposnseData = try JSONDecoder().decode(T?.self, from: data)
                        completion(reposnseData, nil, nil)
                    } catch let jsonError {
                        print(jsonError)
                    }
                    
                case .failure(let error):
                    let statusCode = response.response?.statusCode ?? 0
                    if statusCode > 300 {
                        do {
                            guard let data = response.data else { return }
                            let reposnseError = try JSONDecoder().decode(E?.self, from: data)
                            completion(nil, reposnseError, nil)
                        } catch let jsonError {
                            print(jsonError)
                        }
                    } else {
                        completion(nil, nil, error)
                    }
                }
            }
    }
}
