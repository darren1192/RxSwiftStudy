//
//  DouBanAPI.swift
//  RxSwiftStudy
//
//  Created by share2glory on 2018/12/28.
//  Copyright © 2018 WH. All rights reserved.
//

import Foundation
import Moya

let DouBanProvider = MoyaProvider<DouBanAPI>()

public enum DouBanAPI {
    case channels   // 获取频道列表
    case playlist(String)   // 获取歌曲
}

// 请求配置  继承TargetType协议
extension DouBanAPI: TargetType {
    // 服务器地址
    public var baseURL: URL {
        switch self {
        case .channels:
            return URL.init(string: "https://www.douban.com")!
        case .playlist(_):
            return URL.init(string: "https://douban.fm/")!
        }
    }
    // 各个请求的具体路径
    public var path: String {
        switch self {
        case .channels:
            return "/j/app/radio/channels"
        case .playlist(_):
            return "/j/mine/playlist"
        }
    }
    // 请求类型
    public var method: Moya.Method {
        return .get
    }
    // 做单元测试模拟的数据，只会在单元测试文件中有作用
    public var sampleData: Data {
        return "{}".data(using: .utf8)!
    }
    // 请求任务事件
    public var task: Task {
        switch self {
        case .playlist(let channel):
            var params: [String: Any] = [:]
            params["channel"] = channel
            params["type"] = "n"
            params["from"] = "mainsite"
            return .requestParameters(parameters: params, encoding: URLEncoding.default)
        default:
            return .requestPlain
        }
    }
    // 请求头
    public var headers: [String : String]? {
        return nil
    }
    
    
    
}
