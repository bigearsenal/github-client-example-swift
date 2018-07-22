//
//  Repository.swift
//  github
//
//  Created by Chung Tran on 22/07/2018.
//  Copyright © 2018 Chung Tran. All rights reserved.
//

import Foundation

struct Repository: Decodable {
    var id: UInt32
    var name: String
    var fullName: String
    var owner: Owner
    var starCount: UInt32
    var description: String
    var htmlLink: String
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case fullName = "full_name"
        case owner
        case starCount = "stargazers_count"
        case description
        case htmlLink = "html_url"
    }
}
