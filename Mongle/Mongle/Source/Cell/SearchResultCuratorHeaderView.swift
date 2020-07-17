//
//  SearchResultCuratorHeaderView.swift
//  Mongle
//
//  Created by 이예슬 on 7/12/20.
//  Copyright © 2020 이주혁. All rights reserved.
//

import UIKit

class SearchResultCuratorHeaderView: UICollectionReusableView {
    var curatorNum = 0
    @IBOutlet weak var headerViewLabel: UILabel!
    override func awakeFromNib() {
        headerViewLabel.text = "검색된 큐레이터 \(curatorNum)명"
        headerViewLabel.textColor = .brownishGrey
    }
}
