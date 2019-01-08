//
//  SearchNovelViewModel.swift
//  RxSwiftStudy
//
//  Created by share2glory on 2019/1/4.
//  Copyright © 2019 WH. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import Moya

// 各项数据暂时写死，只是为了演示效果

class SearchNovelViewModel {
    
    let searchAction: Driver<String>
    // 表格数据
    let seacrhItem = BehaviorRelay<[SearchNovelItem]>.init(value: [])
    
    // 停止头部状态刷新
    var endHeaderRefreshing: Driver<Bool>
    
    // 停止尾部刷新状态
    let endFooterRefreshing: Driver<Bool>
    
    let start = 0
    
    init(searchAction: Driver<String>, headerRefresh: Driver<Void>, footerRefresh: Driver<Void> , disposeBag: DisposeBag) {
    
        self.searchAction = searchAction

        let headerRefreshData = headerRefresh.flatMapLatest{
            SearchNovelProvider.rx.request(.search("小虎", 0, 20))
                .filterSuccessfulStatusCodes()
                .mapModels(T: SearchNovelModel.self)
                .asDriver(onErrorDriveWith: Driver.empty())
        }
        
        let footerRefreshData = footerRefresh.flatMapLatest{
            SearchNovelProvider.rx.request(.search("小虎", 1, 20))
                .filterSuccessfulStatusCodes()
                .mapModels(T: SearchNovelModel.self)
                .asDriver(onErrorDriveWith: Driver.empty())
        }
        
        self.endHeaderRefreshing = headerRefreshData.map{ _ in true}
        
        self.endFooterRefreshing = footerRefreshData.map{ _ in true}

        headerRefreshData.drive(onNext: { item in
            self.seacrhItem.accept(item.books!)
        }).disposed(by: disposeBag)
        
        footerRefreshData.drive(onNext: { item in
            self.seacrhItem.accept(self.seacrhItem.value + item.books!)
        }).disposed(by: disposeBag)
        
        let searchResult = searchAction.filter{ !$0.isEmpty }
            .flatMapLatest{
                SearchNovelProvider.rx.request(.search($0, self.start, 20))
                    .filterSuccessfulStatusCodes()
                    .mapModels(T: SearchNovelModel.self)
                    .asDriver(onErrorDriveWith: Driver.empty())
        }
        
        searchResult.drive(onNext: { (item) in
            self.seacrhItem.accept(item.books!)
        }).disposed(by: disposeBag)
    }
    
}
