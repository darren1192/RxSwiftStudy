//
//  BBViewController.swift
//  RxSwiftStudy
//
//  Created by share2glory on 2018/12/25.
//  Copyright © 2018 WH. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class BBViewController: UIViewController {
    
    @IBOutlet weak var inputTextField: UITextField!
    
    @IBOutlet weak var label: UILabel!
    
    var bbModel = BBModel()
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        /*
        // 将用户名与textField做双向绑定
        bbModel.userName.asObservable().bind(to: inputTextField.rx.text).disposed(by: disposeBag)
        inputTextField.rx.text.orEmpty.bind(to: bbModel.userName).disposed(by: disposeBag)
 */
        // 将用户名与textField做双向绑定
        _ = self.inputTextField.rx.textInput <-> self.bbModel.userName
        
        // 将用户信息绑定到label上
        bbModel.userInfo.bind(to: label.rx.text).disposed(by: disposeBag)
 
        
        
        
        
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
