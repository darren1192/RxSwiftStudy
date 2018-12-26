//
//  CollectionViewViewController.swift
//  RxSwiftStudy
//
//  Created by share2glory on 2018/12/26.
//  Copyright © 2018 WH. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class CollectionViewViewController: UIViewController {

    var collectionView: UICollectionView!
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.white
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize.init(width: 100, height: 70)
        
        self.collectionView = UICollectionView.init(frame: self.view.bounds, collectionViewLayout: flowLayout)
        self.collectionView.backgroundColor = UIColor.white
        self.collectionView.register(MyCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        self.view.addSubview(self.collectionView)
        
        let items = Observable.just([
            SectionModel.init(model: "", items: [
                "Swift",
                "Java",
                "PHP",
                "JS",
                "OC",
                "C"
                ])
            ])
        
        let dataSource = RxCollectionViewSectionedReloadDataSource<SectionModel<String, String>>(configureCell: { (ds, collectionView, index, element) -> UICollectionViewCell in
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: index) as! MyCollectionViewCell
                cell.label.text = "\(element)"
                return cell
            })
        
        items.bind(to: self.collectionView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
        collectionView.rx.modelSelected(String.self).subscribe(onNext: {
            print("选中的内容:\($0)")
        }).disposed(by: disposeBag)
        
    }
    
}

