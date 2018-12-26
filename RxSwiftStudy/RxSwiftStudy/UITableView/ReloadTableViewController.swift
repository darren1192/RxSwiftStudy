//
//  ReloadTableViewController.swift
//  RxSwiftStudy
//
//  Created by share2glory on 2018/12/25.
//  Copyright © 2018 WH. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class ReloadTableViewController: UIViewController {

    var tableView: UITableView!
    
    var searchBar: UISearchBar!
    
    let disposeBag = DisposeBag()
    
    var refreshButton: UIButton!
    
    var cancelButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.white
        
        self.tableView = UITableView.init(frame: self.view.bounds)
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        self.view.addSubview(tableView)
        
        self.searchBar = UISearchBar.init(frame: CGRect.init(x: 0, y: 0, width: self.view.bounds.width, height: 40))
        self.tableView.tableHeaderView = self.searchBar
        
        refreshButton = UIButton.init(frame: CGRect.init(x: 0, y: 0, width: 60, height: 30))
        refreshButton.setTitle("刷新", for: .normal)
        refreshButton.setTitleColor(.black, for: .normal)
        let refreshBar = UIBarButtonItem.init(customView: refreshButton)
        cancelButton = UIButton.init(frame: CGRect.init(x: 0, y: 0, width: 60, height: 30))
        cancelButton.setTitle("取消", for: .normal)
        cancelButton.setTitleColor(.black, for: .normal)
        let cancelBar = UIBarButtonItem.init(customView: cancelButton)
        self.navigationItem.rightBarButtonItems = [refreshBar, cancelBar]
        // 随机的表格数据
        let randomResult = refreshButton.rx.tap.asObservable()
                                                .startWith(())
                                                .flatMapLatest { self.getRandomResult().takeUntil(self.cancelButton.rx.tap)
                                                }.flatMap(filterResult)  //删选数据
                                                .share(replay: 1)
        
        // 创建数据源
        let dataSource = RxTableViewSectionedReloadDataSource<SectionModel<String, Int>>(configureCell: { (ds, tb, index, element) -> UITableViewCell in
            let cell = tb.dequeueReusableCell(withIdentifier: "Cell")!
            cell.textLabel?.text = "条目\(index.row)：\(element)"
            return cell
            })
        
        // 绑定单元格数据
        randomResult.bind(to: tableView.rx.items(dataSource: dataSource))
                    .disposed(by: disposeBag)
    }
    
    func getRandomResult() -> Observable<[SectionModel<String, Int>]>{
        print("正在请求数据....")
        let items = (0..<5).map{ _ in
            Int(arc4random())
        }
        let observable = Observable.just([SectionModel.init(model: "S", items: items)])
        return observable.delay(4, scheduler: MainScheduler.instance)
        
    }
    
    func filterResult(data: [SectionModel<String, Int>]) -> Observable<[SectionModel<String, Int>]> {
        return self.searchBar.rx.text.orEmpty
            //.debounce(0.5, scheduler: MainScheduler.instance) //只有间隔超过0.5秒才发送
            .flatMapLatest{
                query -> Observable<[SectionModel<String, Int>]> in
                print("正在筛选数据（条件为：\(query)）")
                //输入条件为空，则直接返回原始数据
                if query.isEmpty{
                    return Observable.just(data)
                }
                    //输入条件为不空，则只返回包含有该文字的数据
                else{
                    var newData:[SectionModel<String, Int>] = []
                    for sectionModel in data {
                        let items = sectionModel.items.filter{ "\($0)".contains(query) }
                        newData.append(SectionModel(model: sectionModel.model, items: items))
                    }
                    return Observable.just(newData)
                }
        }
    }


}
