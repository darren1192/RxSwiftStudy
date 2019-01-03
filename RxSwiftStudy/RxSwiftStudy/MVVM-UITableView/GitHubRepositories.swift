//
//  GitHubRepositories.swift
//  RxSwiftStudy
//
//  Created by share2glory on 2019/1/3.
//  Copyright © 2019 WH. All rights reserved.
//

import HandyJSON

struct GitHubRepositories: HandyJSON {
    var totalCount: Int?
    var incompleteResults: Bool?
    var items: [GitHubRepository]?
}

struct GitHubRepository: HandyJSON {
    var id: Int?
    var name: String?
    var fullName: String?
    var htmlUrl: String?
    var description: String?
}
