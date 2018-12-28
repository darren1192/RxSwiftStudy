//
//  ListModel.swift
//  RxSwiftStudy
//
//  Created by share2glory on 2018/12/28.
//  Copyright © 2018 WH. All rights reserved.
//
// 在RxAlamofire之中，我们使用ObjectMapper，这次换成HandyJSON去尝试一下(其实我个人蛮喜欢HandyJson)

import HandyJSON

struct ListModel: HandyJSON {
    var channels: [ListItemModel]?
}

struct ListItemModel: HandyJSON {
    var name_en: String?
    var seq_id: String?
    var abbr_en: String?
    var name: String?
    var channel_id: String?
}
