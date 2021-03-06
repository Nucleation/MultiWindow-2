//
//  ImageTableViewCell.swift
//  Sougua
//
//  Created by zhishen－mac on 2018/4/11.
//  Copyright © 2018年 zhishen－mac. All rights reserved.
//

import UIKit

class ImageTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!

    @IBOutlet weak var image1: UIImageView!
    @IBOutlet weak var image2: UIImageView!
    @IBOutlet weak var image3: UIImageView!
    @IBOutlet weak var newsFrom: UILabel!
    @IBOutlet weak var reviewLab: UILabel!
    var aNews = HomePageNews(){
        didSet {
            titleLabel.text = aNews.title
            image1.kf.setImage(with: URL(string: aNews.imageurls[0]))
            image2.kf.setImage(with: URL(string: aNews.imageurls[1]))
            image3.kf.setImage(with: URL(string: aNews.imageurls[2]))
            newsFrom.text = aNews.source
            reviewLab.text = "评论数：\(aNews.comment)"
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
