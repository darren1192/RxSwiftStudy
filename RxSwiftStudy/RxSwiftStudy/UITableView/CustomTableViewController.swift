//
//  CustomTableViewController.swift
//  RxSwiftStudy
//
//  Created by share2glory on 2018/12/26.
//  Copyright © 2018 WH. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class CustomTableViewController: UIViewController {

    var tableView: UITableView!
    
    var dataSource: RxTableViewSectionedReloadDataSource<SectionModel<String, String>>?
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.white
        
        self.tableView = UITableView.init(frame: self.view.bounds, style: .plain)
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.view.addSubview(tableView)
        
        let sections = Observable.just([
            SectionModel.init(model: "First Section", items: [
                "one",
                "two",
                "three"
                ]),
            SectionModel.init(model: "Second Section", items: [
                "one",
                "two",
                "three"
                ])
            ])
        
        let dataSource = RxTableViewSectionedReloadDataSource<SectionModel<String, String>>(configureCell: { (ds, tv, index, element) in
            let cell = tv.dequeueReusableCell(withIdentifier: "cell")
            cell?.textLabel?.text = element
            return cell!
        })
        dataSource.titleForHeaderInSection = {
            ds, index in
            return "共有\(ds.sectionModels[index].items.count)个控件"
        }
        
        self.dataSource = dataSource
        
        sections.bind(to: self.tableView.rx.items(dataSource: dataSource))
                .disposed(by: disposeBag)
        
        tableView.rx.setDelegate(self)
                .disposed(by: disposeBag)
    }

}

extension CustomTableViewController: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.blue
        let titleLabel = UILabel()
        titleLabel.text = self.dataSource?[section].model
        titleLabel.textColor = .white
        titleLabel.sizeToFit()
        titleLabel.center = CGPoint.init(x: self.view.frame.width/2, y: 20)
        headerView.addSubview(titleLabel)
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
}
