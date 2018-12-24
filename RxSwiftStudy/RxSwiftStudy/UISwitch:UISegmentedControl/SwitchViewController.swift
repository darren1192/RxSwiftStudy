//
//  SwitchViewController.swift
//  RxSwiftStudy
//
//  Created by share2glory on 2018/12/24.
//  Copyright © 2018 WH. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
class SwitchViewController: UIViewController {

   
    @IBOutlet weak var testSwitch: UISwitch!
    
    @IBOutlet weak var showLabel: UILabel!
    let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        testSwitch.rx.isOn.asObservable()
                        .subscribe(onNext: {
                            print("当前开关状态：\($0)")
                        })
                        .disposed(by: disposeBag)
 
        testSwitch.rx.isOn.bind(to: showLabel.rx.isHidden)
                        .disposed(by: disposeBag)
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
