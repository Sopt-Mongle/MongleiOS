//
//  SearchResultSentenceTVC.swift
//  Mongle
//
//  Created by 이예슬 on 7/11/20.
//  Copyright © 2020 이주혁. All rights reserved.
//

import UIKit

class SearchResultSentenceTVC: UITableViewCell {

    var isWritten = false
    @IBOutlet weak var themeLabel: UILabel!
    @IBOutlet weak var sentenceLabel: UILabel!
    @IBOutlet weak var curatorLabel: UILabel!
    @IBOutlet weak var curatorSquare: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.themeLabel.text = "번아웃을 극복하고 싶을 때 봐야하는 문장"
        self.themeLabel.textColor = .veryLightPink
        self.sentenceLabel.text = "결국 봄이 언제나 찾아왔지만, 하마터면 오지 않을 뻔했던 봄을 생각하면 마음이 섬찟해진다."
        self.curatorLabel.textColor = .veryLightPink
        
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
