//
//  Response.swift
//  iOS_Coding
//
//  Created by Akash Sheelavant - Vendor on 7/18/20.
//  Copyright © 2020 Akash Sheelavant. All rights reserved.
//

import Foundation

protocol ResponseType {
    var title: String? { get }
    var rows: [Info]? { get }
}

protocol InfoType {
    var title: String? { get }
    var description: String? { get }
    var imageUrl: String? { get }
}

struct Response: Codable, ResponseType {
    let title: String?
    let rows: [Info]?
}

struct Info: Codable, InfoType {
    let title: String?
    let description: String?
    let imageUrl: String?

    enum CodingKeys: String, CodingKey {
        case title
        case description
        case imageUrl = "imageHref"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)

        title = try? values.decode(String.self, forKey: .title)
        description = try? values.decode(String.self, forKey: .description)
        imageUrl = try? values.decode(String.self, forKey: .imageUrl)
    }
}
