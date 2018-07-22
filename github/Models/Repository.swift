//
//  Repository.swift
//  github
//
//  Created by Chung Tran on 22/07/2018.
//  Copyright © 2018 Chung Tran. All rights reserved.
//

import Foundation

struct Repository {
    var id: UInt32
    var name: String
    var fullName: String
    var owner: Owner
    var starCount: UInt32
    var description: String
}
