//
//  EditTableViewController.swift
//  RxSwiftStudy
//
//  Created by share2glory on 2018/12/26.
//  Copyright © 2018 WH. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

enum TableEditingCommand {
    case setItems(items: [String])  //设置表格数据
    case addItem(item: String)  //新增表格
    case moveItem(from: IndexPath, to: IndexPath)   //移动数据
    case deleteItem(IndexPath)  //删除数据
}


class EditTableViewController: UIViewController {

    var tableView: UITableView!
    
    let disposeBag = DisposeBag()
    
    var refreshButton: UIButton!
    var addButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.white
        
        self.tableView = UITableView.init(frame: self.view.bounds, style: .plain)
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        self.view.addSubview(tableView)
        
        refreshButton = UIButton.init(frame: CGRect.init(x: 0, y: 0, width: 60, height: 30))
        refreshButton.setTitle("刷新", for: .normal)
        refreshButton.setTitleColor(.black, for: .normal)
        let refreshBar = UIBarButtonItem.init(customView: refreshButton)
        addButton = UIButton.init(type: .contactAdd)
        let addBar = UIBarButtonItem.init(customView: addButton)
        self.navigationItem.rightBarButtonItems = [refreshBar, addBar]
        
        // 表格模型
        let initialVM = TableViewModel()
        
        //刷新数据命令
        let refreshCommand = refreshButton.rx.tap.asObservable()
            .startWith(()) //加这个为了页面初始化时会自动加载一次数据
            .flatMapLatest(getRandomResult)
            .map(TableEditingCommand.setItems)
        
        //新增条目命令
        let addCommand = addButton.rx.tap.asObservable()
            .map{ "\(arc4random())" }
            .map(TableEditingCommand.addItem)
        
        //移动位置命令
        let movedCommand = tableView.rx.itemMoved
            .map(TableEditingCommand.moveItem)
        
        //删除条目命令
        let deleteCommand = tableView.rx.itemDeleted.asObservable()
            .map(TableEditingCommand.deleteItem)
        
        //绑定单元格数据
        Observable.of(refreshCommand, addCommand, movedCommand, deleteCommand)
            .merge()
            .scan(initialVM) { (vm: TableViewModel, command: TableEditingCommand)
                -> TableViewModel in
                return vm.execute(command: command)
            }
            .startWith(initialVM)
            .map {
                [AnimatableSectionModel(model: "", items: $0.items)]
            }
            .share(replay: 1)
            .bind(to: tableView.rx.items(dataSource: self.dataSource()))
            .disposed(by: disposeBag)
    }
    
    func getRandomResult() -> Observable<[String]> {
        let items = (0..<5).map{ _ in
            "\(arc4random())"
        }
        return Observable.just(items)
    }

    func dataSource() -> RxTableViewSectionedAnimatedDataSource<AnimatableSectionModel<String, String>> {
        return RxTableViewSectionedAnimatedDataSource(
            //设置插入、删除、移动单元格的动画效果
            animationConfiguration: AnimationConfiguration(insertAnimation: .top,
                                                           reloadAnimation: .fade,
                                                           deleteAnimation: .left),
            configureCell: {
                (dataSource, tv, indexPath, element) in
                let cell = tv.dequeueReusableCell(withIdentifier: "Cell")!
                cell.textLabel?.text = "条目\(indexPath.row)：\(element)"
                return cell
        },
            canEditRowAtIndexPath: { _, _ in
                return true //单元格可删除
        },
            canMoveRowAtIndexPath: { _, _ in
                return true //单元格可移动
        }
        )
    }
    
    
}

struct TableViewModel {
    fileprivate var items: [String]
    
    init(items: [String] = []) {
        self.items = items
    }
    
    func execute(command: TableEditingCommand) -> TableViewModel{
        switch command {
        case .setItems(items: let items):
            print("设置表格数据")
            return TableViewModel.init(items: items)
        case .addItem(item: let item):
            print("新增表格数据")
            var items = self.items
            items.append(item)
            return TableViewModel.init(items: items)
        case .moveItem(from: let from, to: let to):
            print("移动数据")
            var items = self.items
            items.insert(items.remove(at: from.row), at: to.row)
            return TableViewModel.init(items: items)
        case .deleteItem(let indexPath):
            print("删除数据")
            var items = self.items
            items.remove(at: indexPath.row)
            return TableViewModel.init(items: items)
 
        }
    }
}
