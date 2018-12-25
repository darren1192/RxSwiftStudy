//
//  CTimerViewController.swift
//  RxSwiftStudy
//
//  Created by share2glory on 2018/12/25.
//  Copyright © 2018 WH. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class CTimerViewController: UIViewController {

    @IBOutlet weak var ctimerDatePicker: UIDatePicker!
    
    @IBOutlet weak var startButton: UIButton!
    
    var leftTime = BehaviorRelay.init(value: TimeInterval(180))
    
    var countDownStopped = BehaviorRelay.init(value: true)
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //剩余时间与datepicker做双向绑定
        DispatchQueue.main.async {
            _ = self.ctimerDatePicker.rx.countDownDuration <-> self.leftTime
        }
        // 绑定button标题
        Observable.combineLatest(leftTime.asObservable(), countDownStopped.asObservable()) {
            leftTimeValue, countDownStoppedValue in
            //根据当前的状态设置按钮的标题
            if countDownStoppedValue {
                return "开始"
            }else{
                return "倒计时开始，还有 \(Int(leftTimeValue)) 秒..."
            }
            }.bind(to: startButton.rx.title())
            .disposed(by: disposeBag)
        
        // 绑定button和datepicker状态（在倒计过程中，按钮和时间选择组件不可用）
        countDownStopped.asDriver().drive(ctimerDatePicker.rx.isEnabled).disposed(by: disposeBag)
        countDownStopped.asDriver().drive(startButton.rx.isEnabled).disposed(by: disposeBag)
        
        startButton.rx.tap.bind{ [weak self] in
            self?.startClicked()
        }.disposed(by: disposeBag)
    }
    
    // 开始倒计时
    func startClicked(){
        self.countDownStopped.accept(false)
    
        // 创建一个计时器
        Observable<Int>.interval(1, scheduler: MainScheduler.instance)
                       .takeUntil(countDownStopped.asObservable().filter{ $0 })  //倒计时结束时停止计时器
                        .subscribe { (event) in
                            self.leftTime.accept(self.leftTime.value-1)
                            if self.leftTime.value == 0 {
                                print("倒计时结束")
                                self.countDownStopped.accept(true)
                                self.leftTime.accept(180)
                            }
                        }.disposed(by: disposeBag)
    }


}
