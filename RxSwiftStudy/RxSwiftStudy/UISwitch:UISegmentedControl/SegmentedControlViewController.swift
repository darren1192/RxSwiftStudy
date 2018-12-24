//
//  SegmentedControlViewController.swift
//  RxSwiftStudy
//
//  Created by share2glory on 2018/12/24.
//  Copyright © 2018 WH. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class SegmentedControlViewController: UIViewController {

    @IBOutlet weak var segmented: UISegmentedControl!
    
    @IBOutlet weak var showLabel: UILabel!
    
    let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let showColorObservable: Observable<UIColor> = segmented.rx.selectedSegmentIndex.asObservable().map{
            let colors = [UIColor.red, UIColor.blue, UIColor.yellow]
            return colors[$0]
        }
    
        showColorObservable.bind(to: showLabel.rx.backgroundColor)
                            .disposed(by: disposeBag)
    }


}

