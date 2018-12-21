//
//  ViewController.swift
//  RxSwiftStudy
//
//  Created by share2glory on 2018/12/21.
//  Copyright © 2018 WH. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    var tableView: UITableView!
    let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.tableView = UITableView.init(frame: self.view.bounds)
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        self.view.addSubview(tableView)
        
        let items = Observable.just(["RxDataSources用法", "test2", "test3", "test4"])
        
        items.bind(to: self.tableView.rx.items){ (tableView, row, element) in
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")!
            cell.textLabel?.text = "\(row)：\(element)"
            return cell
            }.disposed(by: disposeBag)
        
        self.tableView.rx.itemSelected.subscribe(onNext: { indexPath in
            print("选中项的indexPath为：\(indexPath)")
            self.navigationController?.pushViewController(RxDataSourcesViewController(), animated: true)
        }).disposed(by: disposeBag)
        
        self.tableView.rx.modelSelected(String.self).subscribe(onNext: { item in
            print("选中项的标题为：\(item)")
        }).disposed(by: disposeBag)
        
        self.tableView.rx.itemDeleted.subscribe(onNext: { indexPath in
            print("删除的的indexPath为：\(indexPath)")
        }).disposed(by: disposeBag)
        
        self.tableView.rx.modelDeleted(String.self).subscribe(onNext: {
            
            print("删除的内容为：\($0)")
        }).disposed(by: disposeBag)
    }
    

}

