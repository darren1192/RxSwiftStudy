//
//  GestureRecognizerViewController.swift
//  RxSwiftStudy
//
//  Created by share2glory on 2018/12/25.
//  Copyright © 2018 WH. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class GestureRecognizerViewController: UIViewController {

    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.white
        
        self.methodTwo()
    }
    
    func methodOne() {
        let swipe = UISwipeGestureRecognizer()
        swipe.direction = .up
        self.view.addGestureRecognizer(swipe)
        
        swipe.rx.event.subscribe(onNext: { (recognizer) in
            let point = recognizer.location(in: recognizer.view)
            print("向上滑动 -- x:\(point.x) y:\(point.y)")
        }).disposed(by: disposeBag)
    }
    
    func methodTwo() {
        let swipe = UISwipeGestureRecognizer()
        swipe.direction = .up
        self.view.addGestureRecognizer(swipe)
        
        swipe.rx.event.bind { recognizer in
            let point = recognizer.location(in: recognizer.view)
            print("向上滑动 -- x:\(point.x) y:\(point.y)")
        }.disposed(by: disposeBag)
    }
}
