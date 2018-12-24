//
//  ButtonViewController.swift
//  RxSwiftStudy
//
//  Created by share2glory on 2018/12/24.
//  Copyright © 2018 WH. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ButtonViewController: UIViewController {

    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.white
        
        
        methodTwo()
    }
    
    func methodOne() {
        let button = UIButton.init(frame: CGRect.init(x: 20, y: 100, width: 200, height: 30))
        button.setTitleColor(UIColor.black, for: .normal)
        self.view.addSubview(button)
        let observable = Observable.just("按钮")
        
        observable.bind(to: button.rx.title(for: .normal))
                  .disposed(by: disposeBag)
    }
    
    func methodTwo(){
        var buttons: [UIButton]! = []
        for i in 0..<3 {
            let button = UIButton.init(frame: CGRect.init(x: 20+CGFloat(i)*100, y: 100, width: 80, height: 30))
            button.backgroundColor = UIColor.blue
            button.setTitle("按钮", for: .normal)
            self.view.addSubview(button)
            
            if i == 0 {
                button.isSelected = true
            }else {
                button.isSelected = false
            }
            buttons.append(button)
        }
        
        let selectdButton = Observable.from(buttons.map{ button in button.rx.tap.map{ button } }).merge()
        
        for button in buttons {
            selectdButton.map{ $0 == button }
                        .bind(to: button.rx.isHidden)
                        .disposed(by: disposeBag)
        }
        
    }
    
}
