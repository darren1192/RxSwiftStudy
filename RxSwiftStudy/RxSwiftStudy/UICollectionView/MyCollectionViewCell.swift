//
//  MyCollectionViewCell.swift
//  RxSwiftStudy
//
//  Created by share2glory on 2018/12/26.
//  Copyright © 2018 WH. All rights reserved.
//

import UIKit

class MyCollectionViewCell: UICollectionViewCell {
    var label: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.yellow
        
        label = UILabel.init(frame: bounds)
        label.textColor = .black
        label.textAlignment = .center
        
        self.contentView.addSubview(label)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
