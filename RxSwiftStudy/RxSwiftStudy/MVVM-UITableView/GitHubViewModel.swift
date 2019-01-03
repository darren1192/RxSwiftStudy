//
//  GitHubViewModel.swift
//  RxSwiftStudy
//
//  Created by share2glory on 2019/1/3.
//  Copyright © 2019 WH. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class GitHubViewModel {
    // 输入部分   查询行为
    let searchAction: Driver<String>
    
    // 输出部分  查询结果
    let searchResult: Driver<GitHubRepositories>
    
    // 查询结果里的资源列表
    let repositories: Driver<[GitHubRepository]>
    
    // 清空结果动作
    let cleanResult: Driver<Void>
    
    // 导航栏标题
    let navigationTitle: Driver<String>
    
    init(searchAction: Driver<String>) {
        self.searchAction = searchAction
        
        // 生成结果查询序列
        self.searchResult = searchAction.filter{ !$0.isEmpty } //如果输入为空则不发送请求了
            .flatMapLatest{
                GitHubProvider.rx.request(.repositories($0))
                            .filterSuccessfulStatusCodes()
                            .asObservable()
                            .mapModel(T: GitHubRepositories.self)
                            .asDriver(onErrorDriveWith: Driver.empty())
            }
        
        // 生成清空结果动作序列
        self.cleanResult = searchAction.filter{ !$0.isEmpty }.map{ _ in Void() }
        
        // 生成查询结果里的资源序列
        self.repositories = Driver.merge(
            searchResult.map{ $0.items!},
            cleanResult.map{ [] }
        )
        
        // 生成导航栏标题序列
        self.navigationTitle = Driver.merge(
            searchResult.map{ "共有" + String($0.items!.count) + "个结果" },
            cleanResult.map{ "MVVM-UITableView" }
        )
    }
}
