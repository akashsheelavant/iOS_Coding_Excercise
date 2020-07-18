//
//  FactsEndPoint.swift
//  iOS_Coding
//
//  Created by Akash Sheelavant - Vendor on 7/18/20.
//  Copyright © 2020 Akash Sheelavant. All rights reserved.
//

import Foundation

public enum FactsApi {
    case facts
}

extension FactsApi: EndPointType {
    var baseURL: URL {
        return URL(string: "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl")!
    }

    var path: String {
        switch self {
        case .facts:
            return "/facts.json"
        }
    }

    var httpMethod: HTTPMethod {
        return .get
    }

    var task: HTTPTask {
        switch self {
        case .facts:
            return .requestParameters(bodyParameters: nil, bodyEncoding: .urlEncoding, urlParameters: nil)
        }
    }

    var headers: HTTPHeaders? {
        return nil
    }
}
