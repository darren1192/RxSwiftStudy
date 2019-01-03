//
//  GitHubNetworkService.swift
//  RxSwiftStudy
//
//  Created by share2glory on 2019/1/2.
//  Copyright © 2019 WH. All rights reserved.
//

import Foundation
import RxSwift

class GitHubNetworkService {
    func usernameAvailabel(_ username: String) -> Observable<Bool> {
        let url = URL.init(string: "https://github.com/\(username.URLEscaped)")!
        let request = URLRequest.init(url: url)
        return URLSession.shared.rx.response(request: request)
            .map{ pair in
                return pair.response.statusCode == 404
            }
            .catchErrorJustReturn(false)
    }
    
    func signup(_ username: String, password: String) -> Observable<Bool> {
        // 模拟操作
        let signupResult = arc4random() % 3 == 0 ? false : true
        // 结果1.5秒返回
        return Observable.just(signupResult).delay(1.5, scheduler: MainScheduler.instance)
    }
}


extension String{
    var URLEscaped: String {
        return self.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? ""
    }
}
