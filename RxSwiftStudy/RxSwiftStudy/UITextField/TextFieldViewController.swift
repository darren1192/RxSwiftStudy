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

class TextFieldViewController: UIViewController {
    let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.white
        
        methodFour()
        
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
        let inputField = UITextField.init(frame: CGRect.init(x: 20, y: 120, width: 300, height: 30))
        inputField.borderStyle = .roundedRect
        self.view.addSubview(inputField)

        let outputField = UITextField.init(frame: CGRect.init(x: 20, y: 180, width: 300, height: 30))
        outputField.borderStyle = .roundedRect
        outputField.isEnabled = false
        self.view.addSubview(outputField)

        let label = UILabel.init(frame: CGRect.init(x: 20, y: 230, width: 300, height: 30))
        label.text = "--"
        self.view.addSubview(label)

        let button = UIButton.init(frame: CGRect.init(x: 20, y: 280, width: 40, height: 20))
        button.setTitle("提交", for: .normal)
        button.setTitleColor(.black, for: .normal)
        self.view.addSubview(button)

        let input = inputField.rx.text.orEmpty.asDriver()
                                              .throttle(0.3)//在主线程中操作，0.3秒内值若多次改变，取最后一次
        // 内容绑定到另外一个输入框
        input.drive(outputField.rx.text)
            .disposed(by: disposeBag)
        // 内容绑定到标签中
        input.map { "当期数字:\($0.count)" }
             .drive(label.rx.text)
             .disposed(by: disposeBag)
        
        input.map { $0.count > 5}
             .drive(button.rx.isEnabled)
             .disposed(by: disposeBag)
        
        button.rx.tap.subscribe(onNext: { print("blick") })
                    .disposed(by: disposeBag)
        
        
    }

    // 同时监听多个textfield变化
    func methodThree() {
        let textFieldOne = UITextField.init(frame: CGRect.init(x: 20, y: 120, width: 300, height: 30))
        textFieldOne.borderStyle = .roundedRect
        self.view.addSubview(textFieldOne)
        
        let textFieldTwo = UITextField.init(frame: CGRect.init(x: 20, y: 180, width: 300, height: 30))
        textFieldTwo.borderStyle = .roundedRect
        self.view.addSubview(textFieldTwo)
        
        let label = UILabel.init(frame: CGRect.init(x: 20, y: 230, width: self.view.bounds.width, height: 30))
        self.view.addSubview(label)
        // combineLatest:将多个（两个或两个以上的）Observable 序列元素进行合并
        Observable.combineLatest(textFieldOne.rx.text.orEmpty, textFieldTwo.rx.text.orEmpty) { (textValueOne, textValueTwo) -> String in
                return "你输入的是:\(textValueOne) + \(textValueTwo)"
            }.map { $0 }
            .bind(to: label.rx.text)
            .disposed(by: disposeBag)
        
    }
    
    // 事件监听
    func methodFour() {
        let textField = UITextField.init(frame: CGRect.init(x: 20, y: 120, width: 300, height: 30))
        textField.borderStyle = .roundedRect
        self.view.addSubview(textField)
        
        textField.rx.controlEvent([.editingDidBegin])
                .asObservable()
                .subscribe(onNext: {
                    print("开始编辑内容")
                })
                .disposed(by: disposeBag)
        
        
    }
}
