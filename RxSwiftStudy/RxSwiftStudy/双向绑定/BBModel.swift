//
//  BBModel.swift
//  RxSwiftStudy
//
//  Created by share2glory on 2018/12/25.
//  Copyright © 2018 WH. All rights reserved.
//

import RxSwift
import RxCocoa
struct BBModel {
    let userName = BehaviorRelay.init(value: "guest")
    lazy var userInfo = {
        return self.userName.asObservable()
                            .map{ $0 == "wh" ? "您是管理员" : "您是游客" }
                            .share(replay: 1)
    }()
}
