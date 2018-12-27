//
//  RxAlamofireCViewController.swift
//  RxSwiftStudy
//
//  Created by share2glory on 2018/12/27.
//  Copyright © 2018 WH. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxAlamofire

class RxAlamofireCViewController: UIViewController {

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
        
        let urlString = "https://www.douban.com/j/app/radio/channels"
        let url = URL.init(string: urlString)!
        
        let data = requestJSON(.get, url)
            .map{ $1 }
            .mapObject(type: Douban.self)
            .map{ $0.channels ?? [] }
        
        data.bind(to: self.tableView.rx.items){
            (tableView, row, element) in
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
            cell.textLabel?.text = "\(row): \(element.name!)"
            return cell
        }.disposed(by: disposeBag)
        
    }


}
