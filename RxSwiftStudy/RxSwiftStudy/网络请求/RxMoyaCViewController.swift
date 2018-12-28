//
//  RxMoyaCViewController.swift
//  RxSwiftStudy
//
//  Created by share2glory on 2018/12/28.
//  Copyright © 2018 WH. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources
import HandyJSON
class RxMoyaCViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        if #available(iOS 11.0, *){
            self.tableView.contentInsetAdjustmentBehavior = UIScrollView.ContentInsetAdjustmentBehavior.never
        }else {
            self.tableView.translatesAutoresizingMaskIntoConstraints = false
        }
        
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
       
        let data = DouBanProvider.rx.request(.channels)
                                    .asObservable()
                                    .mapModel(T: ListModel.self)
                                    .map{ $0.channels ?? [] }
        
        data.bind(to: self.tableView.rx.items){
            (tb, row, element) in
            let cell = tb.dequeueReusableCell(withIdentifier: "cell")!
            cell.textLabel?.text = element.name!
            return cell
        }.disposed(by: disposeBag)
        
        
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
