//
//  SearchNovelTableViewCell.swift
//  RxSwiftStudy
//
//  Created by share2glory on 2019/1/4.
//  Copyright © 2019 WH. All rights reserved.
//

import UIKit

class SearchNovelTableViewCell: UITableViewCell {

    private lazy var titleLabel: UILabel = {
        let label = UILabel.init()
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    private lazy var authorNameLabel: UILabel = {
        let label = UILabel.init()
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    public var data: SearchNovelItem?{
        didSet{
            if let author = data?.author {
                authorNameLabel.text = author
            }
            
            if let title = data?.title {
                titleLabel.text = title
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.addSubview(titleLabel)
        self.contentView.addSubview(authorNameLabel)
        
        titleLabel.frame = CGRect.init(x: 20, y: 20, width: self.contentView.bounds.width-40, height: 30)
        
        authorNameLabel.frame = CGRect.init(x: 20, y: 60, width: self.contentView.bounds.width-40, height: 30)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
