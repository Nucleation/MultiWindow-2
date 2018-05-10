//
//  HomeNavigationView.swift
//  Sougua
//
//  Created by zhishen－mac on 2018/4/9.
//  Copyright © 2018年 zhishen－mac. All rights reserved.
//

import UIKit

class HomeNavigationView: UIView,NibLoadable{
    override var frame: CGRect {
        didSet {
            super.frame = CGRect(x: 0, y: 0, width: screenWidth, height: 150)
        }
    }
}
