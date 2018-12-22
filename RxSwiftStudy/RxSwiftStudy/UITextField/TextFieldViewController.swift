//
//  TextFieldViewController.swift
//  RxSwiftStudy
//
//  Created by share2glory on 2018/12/22.
//  Copyright © 2018 WH. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class TextFieldViewController: BaseViewController {
    let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        methodTwo()
        
    }
    // 基本用法
    private func methodOne() {
        let textField = UITextField.init(frame: CGRect.init(x: 20, y: 120, width: 200, height: 30))
        textField.borderStyle = .roundedRect
        self.view.addSubview(textField)
        // orEmpty 可以将 String? 类型的 ControlProperty 转成 String，省得我们再去解包
        textField.rx.text.orEmpty.asObservable()
            .subscribe(onNext: {
                print("输入的是:\($0)")
            })
            .disposed(by: disposeBag)
        
        // or
        /*
         textField.rx.text.orEmpty.changed
         .subscribe(onNext: {
         print("输入的是:\($0)")
         })
         .disposed(by: disposeBag)
         */
        
    }
    // 输入内容绑定到其它控件上
    private func methodTwo() {
//        let inputField = UITextField.init(frame: CGRect.init(x: 20, y: 120, width: 300, height: 30))
//        inputField.borderStyle = .roundedRect
//        self.view.addSubview(inputField)
//
//        let outputField = UITextField.init(frame: CGRect.init(x: 20, y: 180, width: 300, height: 30))
//        outputField.borderStyle = .roundedRect
//        self.view.addSubview(outputField)
//
//        let label = UILabel.init(frame: CGRect.init(x: 20, y: 230, width: 300, height: 30))
//        label.text = "--"
//        self.view.addSubview(label)
//
//        let button = UIButton.init(frame: CGRect.init(x: 20, y: 280, width: 40, height: 20))
//        button.setTitle("提交", for: .normal)
//        button.setTitleColor(.black, for: .normal)
//        self.view.addSubview(button)
//
//        let input = inputField.rx.text.orEmpty.asDriver()
//                                              .throttle(0.3)//在主线程中操作，0.3秒内值若多次改变，取最后一次
//        input.drive(outputField.rx.text)
//            .disposed(by: disposeBag)
        
        
    }
    

}
