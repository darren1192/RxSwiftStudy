//
//  SearchNovelModel.swift
//  RxSwiftStudy
//
//  Created by share2glory on 2019/1/4.
//  Copyright © 2019 WH. All rights reserved.
//
import Foundation
//import ObjectMapper
import HandyJSON


struct SearchNovelModel: HandyJSON {
    var books: [SearchNovelItem]?
    var total: Int?
    var ok: Bool?
}

struct SearchNovelItem: HandyJSON{
    var id: String?
    var hasCp: String?
    var title: String?
    var aliases: String?
    var cat: String?
    var author: String?
    var site: String?
    var cover: String?
    var shortIntro: String?
    var lastChapter: String?
    var retentionRatio: Int?
    var banned: Int?
    var allowMonthly: Bool?
    var latelyFollower: Int?
    var wordCount: Int?
    var contentType: String?
    var superscript: String?
    var sizetype: Int?
}
