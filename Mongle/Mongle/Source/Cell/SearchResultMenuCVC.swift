//
//  SearchResultMenuCVC.swift
//  Mongle
//
//  Created by 이예슬 on 7/9/20.
//  Copyright © 2020 이주혁. All rights reserved.
//

import UIKit

class SearchResultMenuCVC: UICollectionViewCell {
    static let identifier = "SearchResultMenuCVC"
    
    @IBOutlet weak var menuLabel: UILabel!
    
    override func awakeFromNib() {
        menuLabel.textColor = .veryLightPink
    }
    override var isSelected: Bool {
        didSet {
            menuLabel.textColor = isSelected ? .softGreen : .veryLightPink
            
        }
    }
}
