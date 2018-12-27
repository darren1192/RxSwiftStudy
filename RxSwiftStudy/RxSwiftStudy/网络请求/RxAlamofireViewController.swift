//
//  RxAlamofireViewController.swift
//  RxSwiftStudy
//
//  Created by share2glory on 2018/12/27.
//  Copyright © 2018 WH. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxAlamofire

class RxAlamofireViewController: UIViewController {

    @IBOutlet weak var startButton: UIButton!
    
    @IBOutlet weak var cancelButton: UIButton!
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let urlString = "https://www.douban.com/j/app/radio/channels"
        let url = URL.init(string: urlString)!
        
        startButton.rx.tap.asObservable()
            .flatMap{
                request(.get, url).responseString().takeUntil(self.cancelButton.rx.tap)
            }
            .subscribe(onNext: { (respose, data) in
                print("请求成功，返回数据:\(data)")
                }, onError: { (error) in
                    print("请求失败，错误原因:\(error)")
            })
            .disposed(by: disposeBag)
        
 
    }

}
