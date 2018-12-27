//
//  ObjectMapperModel.swift
//  RxSwiftStudy
//
//  Created by share2glory on 2018/12/27.
//  Copyright © 2018 WH. All rights reserved.
//

import ObjectMapper
import RxSwift

// 数据映射错误
public enum RxObjectMapperError: Error {
    case parsingError
}

// 扩展Observable: 增加模型映射方法
public extension Observable where Element: Any{
    // 将JSON数据转为对象
    public func mapObject<T>(type: T.Type) -> Observable<T> where T: Mappable {
        let mapper = Mapper<T>()
        return self.map{ (element) -> T in
            guard let parseElement = mapper.map(JSONObject: element) else {
                throw RxObjectMapperError.parsingError
            }
            return parseElement
        }
    }
    
    // 将JSON数据转为数组
    public func mapArray<T>(type: T.Type) -> Observable<[T]> where T: Mappable {
        let mapper = Mapper<T>()
        
        return self.map({ (element) -> [T] in
            guard let parsedArray = mapper.mapArray(JSONObject: element)else {
                throw RxObjectMapperError.parsingError
            }
            return parsedArray
        })
    }
}

// 豆瓣接口模型
class Douban: Mappable {
    var channels: [Channel]?
    init() {
        
    }
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        channels <- map["channels"]
    }
}

class Channel: Mappable {
    
    var name: String?
    var nameEn: String?
    var channelId: String?
    var seqId: String?
    var abbrEn: String?
    
    init() {
    }
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        name <- map["name"]
        nameEn <- map["nameEn"]
        channelId <- map["channelId"]
        seqId <- map["seqId"]
        abbrEn <- map["abbrEn"]
    }
}
