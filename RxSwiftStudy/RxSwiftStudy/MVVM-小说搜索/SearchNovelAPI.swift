//
//  SearchNovelAPI.swift
//  RxSwiftStudy
//
//  Created by share2glory on 2019/1/4.
//  Copyright © 2019 WH. All rights reserved.
//

import Foundation
import Moya

let SearchNovelProvider = MoyaProvider<SearchNovelAPI>()

public enum SearchNovelAPI{
    case search(String, Int, Int)     //搜索小说
}

extension SearchNovelAPI: TargetType {
    public var baseURL: URL {
        return URL.init(string: "http://api.zhuishushenqi.com")!
    }
    
    public var path: String {
        switch self {
        case .search:
            return "/book/fuzzy-search"
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
        case .search(let query, let start, let limit):
            var params: [String: Any] = [:]
            params["query"] = query
            params["start"] = start
            params["limit"] = limit
            return .requestParameters(parameters: params, encoding: URLEncoding.default)
        }
    }
    
    public var headers: [String : String]? {
        return nil
    }
    
    
}


