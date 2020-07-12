//
//  SearchResultCuratorHeaderView.swift
//  Mongle
//
//  Created by 이예슬 on 7/12/20.
//  Copyright © 2020 이주혁. All rights reserved.
//

import UIKit

class SearchResultCuratorHeaderView: UICollectionReusableView {
        
    @IBOutlet weak var headerViewLabel: UILabel!
    override func awakeFromNib() {
        headerViewLabel.text = "검색된 큐레이터 8명"
        headerViewLabel.textColor = .brownishGrey
    }
}
