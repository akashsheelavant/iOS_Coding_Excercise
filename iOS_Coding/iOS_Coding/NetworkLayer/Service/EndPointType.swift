//
//  EndPointType.swift
//  iOS_Coding
//
//  Created by Akash Sheelavant - Vendor on 7/18/20.
//  Copyright © 2020 Akash Sheelavant. All rights reserved.
//

import Foundation

protocol EndPointType {
    var baseURL: URL { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var task: HTTPTask { get }
    var headers: HTTPHeaders? { get }
}
