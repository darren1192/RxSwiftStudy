//
//  RxMoyaViewController.swift
//  RxSwiftStudy
//
//  Created by share2glory on 2018/12/28.
//  Copyright © 2018 WH. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
class RxMoyaViewController: UIViewController {
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // 获取数据  常规请求
        
        DouBanProvider.rx.request(.channels)
            .subscribe{ event in
                switch event{
                case let .success(response):
                    let str = String.init(data: response.data, encoding: .utf8)
                    print("返回的数据是:", str ?? "")
                case let .error(error):
                    print("请求失败:", error)
                }
            }.disposed(by: disposeBag)
        /*
         
         DouBanProvider.rx.request(.channels)
         .subscribe(onSuccess: { (response) in
         let str = String.init(data: response.data, encoding: .utf8)
         print("返回的数据是:", str ?? "")
         }) { (error) in
         print("请求失败:", error)
         }.disposed(by: disposeBag)
         */
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
