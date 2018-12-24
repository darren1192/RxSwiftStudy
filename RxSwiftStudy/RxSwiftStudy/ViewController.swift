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
import RxDataSources

class ViewController: UIViewController {
    var tableView: UITableView!
    let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.tableView = UITableView.init(frame: self.view.bounds)
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        self.view.addSubview(tableView)
        
        let items = Observable.just([
                SectionModel.init(model: "基础控件", items: [
                    "UILabel",
                    "UITextField/UITextView",
                    "UIButton",
                    "UISwitch",
                    "UISegmentedControl"
                    ]),
                SectionModel.init(model: "高级控件", items: [
                    "UITableView",
                    "UICollectionView"
                    ])
            ])
        let dataSource = RxTableViewSectionedReloadDataSource<SectionModel<String, String>>(configureCell: { (ds, tv, index, element) in
            let cell = tv.dequeueReusableCell(withIdentifier: "Cell")
            cell?.textLabel?.text = element
            return cell!
        })
        dataSource.titleForHeaderInSection = { ds, index in
            return ds.sectionModels[index].model
        }
        // 绑定单元格数据
        items.bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        self.tableView.rx.setDelegate(self)
            .disposed(by: disposeBag)
        
        
        self.tableView.rx.itemSelected.subscribe(onNext: { indexPath in
            print("选中项的indexPath为：\(indexPath)")

        }).disposed(by: disposeBag)
        
        self.tableView.rx.modelSelected(String.self).subscribe(onNext: { item in
            self.pushVC(to: item)
            
        }).disposed(by: disposeBag)
        
        self.tableView.rx.itemDeleted.subscribe(onNext: { indexPath in
            print("删除的的indexPath为：\(indexPath)")
        }).disposed(by: disposeBag)
        
        self.tableView.rx.modelDeleted(String.self).subscribe(onNext: {
            
            print("删除的内容为：\($0)")
        }).disposed(by: disposeBag)
 
    }
    
    
    func pushVC(to vcName: String){
        switch vcName {
        case "UILabel":
            self.navigationController?.pushViewController(LabelViewController(), animated: true)
        case "UITextField/UITextView":
            self.navigationController?.pushViewController(TextFieldViewController(), animated: true)
        case "UIButton":
            self.navigationController?.pushViewController(ButtonViewController(), animated: true)
        case "UISwitch":
            self.navigationController?.pushViewController(SwitchViewController(), animated: true)
        case "UISegmentedControl":
            self.navigationController?.pushViewController(SegmentedControlViewController(), animated: true)
        default:
            break
        }
    }

}

extension ViewController: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 40
    }
}

extension Reactive where Base : UIView {
    public var backgroundColor: Binder<UIColor> {
        return Binder(self.base){
            view, color in
            view.backgroundColor = color
        }
    }
}
