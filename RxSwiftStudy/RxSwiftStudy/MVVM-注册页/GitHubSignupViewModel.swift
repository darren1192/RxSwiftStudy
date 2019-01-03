//
//  GitHubSignupViewModel.swift
//  RxSwiftStudy
//
//  Created by share2glory on 2019/1/2.
//  Copyright © 2019 WH. All rights reserved.
//

import RxSwift
import RxCocoa

class GitHubSignupViewModel {
    
    let validatedUsername: Driver<ValidationResult>
    
    let validatedPassword: Driver<ValidationResult>
    
    let validatedPasswordRepeated: Driver<ValidationResult>
    
    let signupEnabled: Driver<Bool>
    
    let signupResult: Driver<Bool>
    
    init(input: (username: Driver<String>, password: Driver<String>, repeatedPassword: Driver<String>, loginTaps: Signal<()>), dependency: (networkService: GitHubNetworkService, signupService: GitHubSignupService)) {
        
        validatedUsername = input.username.flatMapLatest{ username in
            return dependency.signupService.validateUsername(username).asDriver(onErrorJustReturn: .failed(message: "服务器发生错误!"))
        }
        
        validatedPassword = input.password.map{ password in
            return dependency.signupService.validatePassword(password)
        }
        
        validatedPasswordRepeated = Driver.combineLatest(
            input.password,
            input.repeatedPassword,
            resultSelector: dependency.signupService.validateRepeatedPassword)

        signupEnabled = Driver.combineLatest(validatedUsername, validatedPassword, validatedPasswordRepeated) { username, password, repeatPassword in
            username.isVaild && password.isVaild && repeatPassword.isVaild
        }.distinctUntilChanged()
        
        
        let usernameAndPassword = Driver.combineLatest(input.username, input.password) { (username: $0, password: $1) }
        
        signupResult = input.loginTaps.withLatestFrom(usernameAndPassword)
            .flatMapLatest { pair in  //也可考虑改用flatMapFirst
                return dependency.networkService.signup(pair.username,
                                                        password: pair.password)
                    .asDriver(onErrorJustReturn: false)
        }
        
        
    
    }
}
