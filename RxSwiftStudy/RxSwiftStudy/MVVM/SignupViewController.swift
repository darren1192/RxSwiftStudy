//
//  SignupViewController.swift
//  RxSwiftStudy
//
//  Created by share2glory on 2019/1/2.
//  Copyright © 2019 WH. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa


class SignupViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var repeatedPasswordTextField: UITextField!
    
    @IBOutlet weak var signButton: UIButton!
    
    @IBOutlet weak var usernameValidationLabel: UILabel!
    @IBOutlet weak var passwordValidationLabel: UILabel!
    @IBOutlet weak var repeatedPasswordValidationLabel: UILabel!
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // vm初始化
        let viewModel = GitHubSignupViewModel.init(input: (username: usernameTextField.rx.text.orEmpty.asDriver(), password: passwordTextField.rx.text.orEmpty.asDriver(), repeatedPassword: repeatedPasswordTextField.rx.text.orEmpty.asDriver(), loginTaps: signButton.rx.tap.asSignal()), dependency: (networkService: GitHubNetworkService(), signupService: GitHubSignupService()))
        
        viewModel.validatedUsername.drive(usernameValidationLabel.rx.validationResult)
            .disposed(by: disposeBag)
        
        viewModel.validatedPasswordRepeated.drive(passwordValidationLabel.rx.validationResult)
        .disposed(by: disposeBag)
        
        viewModel.validatedPasswordRepeated.drive(repeatedPasswordValidationLabel.rx.validationResult)
        .disposed(by: disposeBag)
        
        viewModel.signupEnabled.drive(onNext: { [weak self]  valid in
            self?.signButton.isEnabled = valid
            self?.signButton.alpha = valid ? 1.0 : 0.3
        })
        .disposed(by: disposeBag)
        
        viewModel.signupResult.drive(onNext: { result in
            print("注册:\(result ? "成功" : "失败")")
        }).disposed(by: disposeBag)
        
        
    }


}


extension Reactive where Base: UILabel {
    //让验证结果（ValidationResult类型）可以绑定到label上
    var validationResult: Binder<ValidationResult> {
        return Binder(base) { label, result in
            label.textColor = result.textColor
            label.text = result.description
        }
    }
}
