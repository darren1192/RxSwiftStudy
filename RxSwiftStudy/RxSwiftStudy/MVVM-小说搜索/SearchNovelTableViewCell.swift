//
//  SearchNovelTableViewCell.swift
//  RxSwiftStudy
//
//  Created by share2glory on 2019/1/4.
//  Copyright © 2019 WH. All rights reserved.
//

import UIKit
import Kingfisher

class SearchNovelTableViewCell: UITableViewCell {

    private lazy var imageV: UIImageView = {
        let imageV = UIImageView()
        imageV.contentMode = UIView.ContentMode.scaleAspectFit
        return imageV
    }()
    
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
            guard let imageCover = data?.cover else {
                return
            }
            if imageCover.contains("/agent/"){
                let range = imageCover.count - 7
                let url = PercentEncoding.DecodeURIComponent.evaluate(string: String(imageCover.suffix(range)))
                print(url)
                imageV.kf.setImage(with: URL.init(string: url))
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.addSubview(imageV)
        self.contentView.addSubview(titleLabel)
        self.contentView.addSubview(authorNameLabel)
        
        imageV.frame = CGRect.init(x: 10, y: 10, width: 80, height: 80)
        
        titleLabel.frame = CGRect.init(x: 100, y: 20, width: self.contentView.bounds.width-40, height: 30)
        
        authorNameLabel.frame = CGRect.init(x: 100, y: 60, width: self.contentView.bounds.width-40, height: 30)
        
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
