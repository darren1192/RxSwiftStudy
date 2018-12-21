//
//  RxDataSourcesViewController.swift
//  RxSwiftStudy
//
//  Created by share2glory on 2018/12/21.
//  Copyright © 2018 WH. All rights reserved.
//

import UIKit
import RxDataSources
import RxSwift
import RxCocoa


class RxDataSourcesViewController: UIViewController {

    var tableView: UITableView!
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.white
        
        self.tableView = UITableView.init(frame: self.view.bounds, style: .plain)
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.view.addSubview(tableView)
        
        // 数据初始化
        // 自带的section
        let items = Observable.just([
            SectionModel.init(model: "", items: [
                "UILabel用法",
                "UIButtono用法"])
            ])
        //
        // 创建数据源
        let dataSource = RxTableViewSectionedReloadDataSource<SectionModel<String, String>> (
            configureCell: { (_, tv, indexPath, element) in
                let cell = tv.dequeueReusableCell(withIdentifier: "cell")!
                cell.textLabel?.text = element
                return cell
        }
        )
        // 绑定单元格数据
        items.bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
    }
    

}
