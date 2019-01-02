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
        
        self.title = "RxSwift示例"
        
        self.tableView = UITableView.init(frame: self.view.bounds)
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        self.view.addSubview(tableView)
        
        let items = Observable.just([
                SectionModel.init(model: "基础控件", items: [
                    "UILabel",
                    "UITextField/UITextView",
                    "UIButton",
                    "UISwitch",
                    "UISegmentedControl",
                    "UIGestureRecognizer",
                    "UIDatePicker",
                    "倒计时"
                    ]),
                SectionModel.init(model: "高级控件", items: [
                    "UITableView",
                    "UICollectionView"
                    ]),
                SectionModel.init(model: "其它用法", items: [
                    "双向绑定",
                    "MVVM样例：注册页"
                    ]),
                SectionModel.init(model: "网络请求", items: [
                    "RxAlamofire请求",
                    "RxAlamofire结果处理",
                    "RxAlamofire自定义结果",
                    "RxMoya请求",
                    "RxMoya结果处理",
                    "RxMoya自定义结果"
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
            self.selectVC(to: item)
            
        }).disposed(by: disposeBag)
        
        self.tableView.rx.itemDeleted.subscribe(onNext: { indexPath in
            print("删除的的indexPath为：\(indexPath)")
        }).disposed(by: disposeBag)
        
        self.tableView.rx.modelDeleted(String.self).subscribe(onNext: {
            
            print("删除的内容为：\($0)")
        }).disposed(by: disposeBag)
 
    }
    
    private func selectVC(to vcName: String){
        switch vcName {
        case "UILabel":
            self.pushVC(to: LabelViewController())
        case "UITextField/UITextView":
            self.pushVC(to: TextFieldViewController())
        case "UIButton":
            self.pushVC(to: ButtonViewController())
        case "UISwitch":
            self.pushVC(to: SwitchViewController())
        case "UISegmentedControl":
            self.pushVC(to: SegmentedControlViewController())
        case "双向绑定":
            self.pushVC(to: BBViewController())
        case "UIGestureRecognizer":
            self.pushVC(to: GestureRecognizerViewController())
        case "UIDatePicker":
            self.pushVC(to: DatePickerViewController())
        case "倒计时":
            self.pushVC(to: CTimerViewController())
        case "UITableView":
            self.pushVC(to: TableViewController())
        case "UICollectionView":
            self.pushVC(to: CollectionViewViewController())
        case "RxAlamofire请求":
            self.pushVC(to: RxAlamofireViewController())
        case "RxAlamofire结果处理":
            self.pushVC(to: RxAlamofireJsonViewController())
        case "RxAlamofire自定义结果":
            self.pushVC(to: RxAlamofireCViewController())
        case "RxMoya请求":
            self.pushVC(to: RxMoyaViewController())
        case "RxMoya结果处理":
            self.pushVC(to: RxMoyaJsonViewController())
        case "RxMoya自定义结果":
            self.pushVC(to: RxMoyaCViewController())
        case "MVVM样例：注册页":
            self.pushVC(to: SignupViewController())
        default:
            break
        }
    }
    
    private func pushVC(to vc: UIViewController){
        self.navigationController?.pushViewController(vc, animated: true)
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
