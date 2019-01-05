//
//  RxMoya+HandyJson.swift
//  RxSwiftStudy
//
//  Created by share2glory on 2018/12/28.
//  Copyright © 2018 WH. All rights reserved.
//

// 扩展moya支持handyjson解析

import Foundation
import RxSwift
import HandyJSON
import Moya

extension ObservableType where E == Response {
    public func mapModel<T: HandyJSON>(T: T.Type) -> Observable<T> {
        
        return flatMap({ (response) -> Observable<T> in
            return Observable.just(response.mapModel(type: T.self))
        })
    }
}

extension PrimitiveSequence where TraitType == SingleTrait, ElementType == Response {
    func mapModels<T: HandyJSON>(T: T.Type) -> Single<T>{
        return flatMap{ response -> Single<T> in
            return Single.just(response.mapModel(type: T.self))
        }
    }
}

extension Response {
    func mapModel<T: HandyJSON>(type: T.Type) -> T {
        let jsonString = String.init(data: data, encoding: .utf8)
        if let modelT = JSONDeserializer<T>.deserializeFrom(json: jsonString){
            return modelT
        }
        return JSONDeserializer<T>.deserializeFrom(json: "{msg:’请求有误‘}")!

    }
}


