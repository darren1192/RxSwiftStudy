//
//  SearchNovelViewController.swift
//  RxSwiftStudy
//
//  Created by share2glory on 2019/1/4.
//  Copyright © 2019 WH. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import MJRefresh

class SearchNovelViewController: UIViewController {

    
    var tableView: UITableView!

    var searchBar: UISearchBar!
    
    let disposeBag = DisposeBag()
    
    var query = ""
    var limit = 0
    var start = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.white
        
        self.tableView = UITableView.init(frame: self.view.bounds, style: .plain)
        self.tableView.register(SearchNovelTableViewCell.self, forCellReuseIdentifier: "cell")
        self.view.addSubview(tableView)
        
        self.searchBar = UISearchBar.init(frame: CGRect.init(x: 0, y: 0, width: self.view.bounds.width, height: 50))
        self.tableView.tableHeaderView = self.searchBar
        
        self.tableView.mj_header = MJRefreshNormalHeader()
        self.tableView.mj_footer = MJRefreshBackNormalFooter()
        
        let searchAction = self.searchBar.rx.text.orEmpty.asDriver().throttle(0.5).distinctUntilChanged()
        
        let viewModel = SearchNovelViewModel.init(searchAction: searchAction, headerRefresh: self.tableView.mj_header.rx.refreshing.asDriver(), footerRefresh: self.tableView.mj_footer.rx.refreshing.asDriver(),disposeBag: disposeBag)

        viewModel.seacrhItem.asDriver().drive(tableView.rx.items){
            (tablebiew, row, element) in
            let cell = tablebiew.dequeueReusableCell(withIdentifier: "cell") as! SearchNovelTableViewCell
            cell.data = element
            return cell
            }.disposed(by: disposeBag)
    viewModel.endHeaderRefreshing.drive(self.tableView.mj_header.rx.endRefreshing).disposed(by: disposeBag)
    viewModel.endFooterRefreshing.drive(self.tableView.mj_header.rx.endRefreshing).disposed(by: disposeBag)
        
        self.tableView.rx.setDelegate(self).disposed(by: disposeBag)
        
        
    }
    
}

extension SearchNovelViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
