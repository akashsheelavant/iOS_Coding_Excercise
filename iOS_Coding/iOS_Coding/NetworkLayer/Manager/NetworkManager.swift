//
//  NetworkManager.swift
//  iOS_Coding
//
//  Created by Akash Sheelavant - Vendor on 7/18/20.
//  Copyright © 2020 Akash Sheelavant. All rights reserved.
//

import Foundation

protocol NetworkManagerType {
    func fetchFacts(completion: @escaping (_ response: Response?, _ error: String?) -> Void)
}

enum NetworkResponse:String {
    case success
    case authenticationError = "You need to be authenticated first."
    case badRequest = "Bad request"
    case outdated = "The url you requested is outdated."
    case failed = "Network request failed."
    case noData = "Response returned with no data to decode."
    case unableToDecode = "We could not decode the response."
}

enum Result<String> {
    case success
    case failure(String)
}

struct NetworkManager: NetworkManagerType {
    let router = Router<FactsApi>()

    func fetchFacts(completion: @escaping (_ response: Response?, _ error: String?) -> Void) {
        router.request(.facts) { (data, response, error) in

            if error != nil {
                completion(nil, "Please check the internet connection and try again")
            }
            if let response = response as? HTTPURLResponse {
                let result = self.handleNetworkResponse(response)

                switch result {
                case .success:
                    guard let data = data,
                        let utf8Data = String(decoding: data, as: UTF8.self).data(using: .utf8) else {
                            completion(nil, NetworkResponse.noData.rawValue)
                            return
                    }
                    let decoder = JSONDecoder()
                    do {
                        let response = try decoder.decode(Response.self, from: utf8Data)
                        completion(response, nil)
                    }  catch {
                        completion(nil, NetworkResponse.unableToDecode.rawValue)
                    }

                case .failure(let error):
                    completion(nil, error)

                }
            }
        }
    }

    fileprivate func handleNetworkResponse(_ response: HTTPURLResponse) -> Result<String> {
        switch response.statusCode {
        case 200...299: return .success
        case 401...500: return .failure(NetworkResponse.authenticationError.rawValue)
        case 501...599: return .failure(NetworkResponse.badRequest.rawValue)
        case 600: return .failure(NetworkResponse.outdated.rawValue)
        default: return .failure(NetworkResponse.failed.rawValue)
        }
    }
}
