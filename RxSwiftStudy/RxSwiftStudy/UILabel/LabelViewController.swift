//
//  LabelViewController.swift
//  RxSwiftStudy
//
//  Created by share2glory on 2018/12/22.
//  Copyright © 2018 WH. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class LabelViewController: UIViewController {

    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.white
        
        let label = UILabel.init(frame: CGRect.init(x: 20, y: 120, width: 200, height: 30))
        label.textColor = UIColor.black
        label.text = "--"
        self.view.addSubview(label)
        // 计时器
        let time = Observable<Int>.interval(1, scheduler: MainScheduler.instance)
        // map 对每个元素进行转换
        time.map { String($0) }
            .bind(to: label.rx.text)
            .disposed(by: disposeBag)
        
        
    }


}
