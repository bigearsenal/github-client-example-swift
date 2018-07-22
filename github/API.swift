//
//  API.swift
//  github
//
//  Created by Chung Tran on 22/07/2018.
//  Copyright © 2018 Chung Tran. All rights reserved.
//

import Foundation
import Alamofire

fileprivate struct ServerSearchRepositoriesResponse: Decodable {
    let totalCount: UInt32
    let incompleteResults: Bool
    let repositories: [Repository]
    enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case incompleteResults = "incomplete_results"
        case repositories = "items"
    }
}

struct API {
    static let endpoint = "https://api.github.com"
    static func searchForReposWithKeyword(_ keyword: String, completion: @escaping ([Repository])->Void, failure:@escaping (Error)->Void) {
        Alamofire.request("\(endpoint)/search/repositories?q=\(keyword)&sort=stars&order=desc")
            .validate()
            .responseData { (response) in
                switch response.result {
                case .success(let value):
                    guard let serverResponse = try? JSONDecoder().decode(ServerSearchRepositoriesResponse.self, from: value ) else {
                        completion([Repository]())
                        return
                    }
                    completion(serverResponse.repositories)
                case .failure(let error):
                    failure(error)
                }
        }
    }
}
