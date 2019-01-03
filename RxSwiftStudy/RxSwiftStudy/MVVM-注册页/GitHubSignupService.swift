//
//  GitHubSignupService.swift
//  RxSwiftStudy
//
//  Created by share2glory on 2019/1/2.
//  Copyright © 2019 WH. All rights reserved.
//

import UIKit
import RxSwift

class GitHubSignupService {
    
    let minPasswordCount = 5
    
    lazy var networkService = {
        return GitHubNetworkService()
    }()
    
    func validateUsername(_ username: String) -> Observable<ValidationResult> {
        if username.isEmpty {
            return Observable.just(.empty)
        }
        //判断用户名是否只有数字和字母
        if username.rangeOfCharacter(from: CharacterSet.alphanumerics.inverted) != nil {
            return Observable.just(.failed(message: "用户名只能包含数字和字母"))
        }
        
        //发起网络请求检查用户名是否已存在
        return networkService
            .usernameAvailabel(username)
            .map { available in
                //根据查询情况返回不同的验证结果
                if available {
                    return .ok(message: "用户名可用")
                } else {
                    return .failed(message: "用户名已存在")
                }
            }
            .startWith(.validating) //在发起网络请求前，先返回一个“正在检查”的验证结果
        
    }
    
    // 验证密码
    func validatePassword(_ password: String) -> ValidationResult{
        let numberOfCharaters = password.count
        
        if numberOfCharaters == 0 {
            return ValidationResult.empty
        }
        
        if numberOfCharaters < minPasswordCount {
            return ValidationResult.failed(message: "密码至少需要 \(minPasswordCount) 个字符")
        }
        
        return ValidationResult.ok(message: "密码有效")
    }
    
    func validateRepeatedPassword(_ password: String, repeatedPassword: String)
        -> ValidationResult {
            //判断密码是否为空
            if repeatedPassword.count == 0 {
                return .empty
            }
            
            //判断两次输入的密码是否一致
            if repeatedPassword == password {
                return .ok(message: "密码有效")
            } else {
                return .failed(message: "两次输入的密码不一致")
            }
    }
}

