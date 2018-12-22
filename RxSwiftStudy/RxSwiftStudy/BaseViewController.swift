//
//  BaseViewController.swift
//  RxSwiftStudy
//
//  Created by share2glory on 2018/12/22.
//  Copyright © 2018 WH. All rights reserved.
//
//  每次设置背景颜色很麻烦，所以写一个基类
import UIKit
import RxSwift
import RxCocoa
class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        // Do any additional setup after loading the view.
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
