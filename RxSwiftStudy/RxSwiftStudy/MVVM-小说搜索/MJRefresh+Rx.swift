//
//  MJRefresh+Rx.swift
//  RxSwiftStudy
//
//  Created by share2glory on 2019/1/5.
//  Copyright © 2019 WH. All rights reserved.
//

import RxSwift
import RxCocoa
import MJRefresh
// 扩展MJRefresh基类’MJRefreshComponent‘,转为ControlEvent
extension Reactive where Base: MJRefreshComponent {
    var refreshing: ControlEvent<Void> {
        let source: Observable<Void> = Observable.create{
            [weak control = self.base] observer in
            if let control = control{
                control.refreshingBlock = {
                    observer.on(.next(()))
                }
            }
            return Disposables.create()
        }
        return ControlEvent.init(events: source)
    }
    
    var endRefreshing: Binder<Bool> {
        return Binder(base) { refresh, isEnd in
            if isEnd{
                refresh.endRefreshing()
            }
        }
    }
}
