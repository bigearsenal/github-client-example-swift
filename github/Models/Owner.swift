//
//  Owner.swift
//  github
//
//  Created by Chung Tran on 22/07/2018.
//  Copyright © 2018 Chung Tran. All rights reserved.
//

import Foundation

struct Owner: Decodable {
    var id: UInt32
    var login: String
    var avatarURL: String
    var htmlLink: String
    enum CodingKeys: String, CodingKey {
        case id
        case login
        case avatarURL = "avatar_url"
        case htmlLink = "html_url"
    }
}
