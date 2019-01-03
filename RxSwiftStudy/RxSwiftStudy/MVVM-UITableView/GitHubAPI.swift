//
//  GitHubAPI.swift
//  RxSwiftStudy
//
//  Created by share2glory on 2019/1/3.
//  Copyright © 2019 WH. All rights reserved.
//

import Foundation
import Moya

let GitHubProvider = MoyaProvider<GitHubAPI>()

public enum GitHubAPI{
    case repositories(String)   //查询资料库
}

extension GitHubAPI: TargetType {
    public var baseURL: URL {
        return URL.init(string: "https://api.github.com")!
    }
    
    public var path: String {
        switch self {
        case .repositories:
            return "/search/repositories"
        }
    }
    
    public var method: Moya.Method {
        return .get
    }
    
    public var sampleData: Data {
        return "{}".data(using: .utf8)!
    }
    
    public var task: Task {
        switch self {
        case .repositories(let query):
            var params: [String: Any] = [ : ]
            params["q"] = query
            params["sort"] = "stars"
            params["order"] = "desc"
            return .requestParameters(parameters: params, encoding: URLEncoding.default)
        }
    }
    
    public var headers: [String : String]? {
        return nil
    }
    
    
}
