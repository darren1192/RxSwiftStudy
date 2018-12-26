//
//  TableViewController.swift
//  RxSwiftStudy
//
//  Created by share2glory on 2018/12/25.
//  Copyright © 2018 WH. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class TableViewController: UIViewController {

    var tableView: UITableView!
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.white
        
        self.tableView = UITableView.init(frame: self.view.bounds)
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        self.view.addSubview(tableView)
        
        let sections = Observable.just([
            MySection.init(header: "自定义Section", items: [
                "数据刷新+过滤",
                "样式修改"
                ])
            ])
        let dataSource = RxTableViewSectionedAnimatedDataSource<MySection>(
            //设置单元格
            configureCell: { ds, tv, ip, item in
                let cell = tv.dequeueReusableCell(withIdentifier: "Cell")!
                cell.textLabel?.text = item
                return cell
        })
        dataSource.titleForHeaderInSection = { ds, index in
            return ds.sectionModels[index].header
            
        }
        // 绑定单元格数据
        sections.bind(to: tableView.rx.items(dataSource: dataSource))
                .disposed(by: disposeBag)
        
        self.tableView.rx.modelSelected(String.self).subscribe(onNext: {
            switch $0 {
            case "数据刷新+过滤":
                self.navigationController?.pushViewController(ReloadTableViewController(), animated: true)
            case "编辑表格":
                self.navigationController?.pushViewController(EditTableViewController(), animated: true)
            case "样式修改":
                self.navigationController?.pushViewController(CustomTableViewController(), animated: true)
            default:
                break
            }
        }).disposed(by: disposeBag)
        
    }
    

}
struct MySection {
    var header: String
    var items: [Item]
}

extension MySection: AnimatableSectionModelType{
    typealias Item = String
    
    var identity: String {
        return header
    }
    
    init(original: MySection, items: [Item]) {
        self = original
        self.items = items
    }
}
