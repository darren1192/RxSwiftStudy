//
//  GithubSearchViewController.swift
//  RxSwiftStudy
//
//  Created by share2glory on 2019/1/3.
//  Copyright © 2019 WH. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class GithubSearchViewController: UIViewController {

    var tableView: UITableView!
    
    var searchBar: UISearchBar!
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.white
        
        self.tableView = UITableView.init(frame: self.view.bounds, style: .plain)
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.view.addSubview(tableView)
        
        self.searchBar = UISearchBar.init(frame: CGRect.init(x: 0, y: 0, width: self.view.bounds.width, height: 60))
        self.tableView.tableHeaderView = self.searchBar
        
        // 查询条件输入
        let searchAction = searchBar.rx.text.orEmpty.asDriver().throttle(0.5).distinctUntilChanged()
        
        // vm初始化
        let viewModel = GitHubViewModel.init(searchAction: searchAction)
        
        viewModel.navigationTitle.drive(self.navigationItem.rx.title).disposed(by: disposeBag)
        
        viewModel.repositories.drive(tableView.rx.items){
            (tablebiew, row, element) in
            let cell = tablebiew.dequeueReusableCell(withIdentifier: "cell")!
            cell.textLabel?.text = element.name
            cell.detailTextLabel?.text = element.htmlUrl
            return cell
        }.disposed(by: disposeBag)
        
        tableView.rx.modelSelected(GitHubRepository.self)
            .subscribe(onNext: { [weak self] item in
                self?.showAlter(title: item.fullName, message: item.description)
            }).disposed(by: disposeBag)
        
    }
    
    
    func showAlter(title: String?, message: String?) {
        let alertController = UIAlertController.init(title: title, message: message, preferredStyle: .alert)
        
        let cancelAction = UIAlertAction.init(title: "确定", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
    }

}
