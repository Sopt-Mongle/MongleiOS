//
//  SentenceInThemeTVC.swift
//  Mongle
//
//  Created by 이주혁 on 2020/07/10.
//  Copyright © 2020 이주혁. All rights reserved.
//

import UIKit

class SentenceInThemeTVC: UITableViewCell {

    static let identifier = "SentenceInThemeTVC"
    
//    @IBOutlet var sentenceLabel: UILabel!
    @IBOutlet var sentenceLabel: UILabel!
    
    @IBOutlet var bookNameLabel: UILabel!
    
    @IBOutlet var likeCountLabel: UILabel!
    @IBOutlet var bookmarkCountLabel: UILabel!
    
    
    @IBOutlet var likeImageView: UIImageView!
    @IBOutlet var bookmarkImageView: UIImageView!
    @IBOutlet var likeAndBookmarkCountStackview: UIStackView!
    
    
    lazy var indicatorView: UIView = UIView().then {
        $0.backgroundColor = .veryLightPinkSix
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setIndicatorSate(state: Bool) {
        if state {
            self.addSubview(indicatorView)
            indicatorView.snp.makeConstraints {
                $0.leading.trailing.bottom.equalToSuperview()
                $0.height.equalTo(1)
            }
        }
        else {
            indicatorView.removeFromSuperview()
        }
    }
    
    
    func setData(sentence: String,
                 bookName: String,
                 likeCount: Int,
                 bookMarkCount: Int) {
        self.sentenceLabel.text = sentence

        self.bookNameLabel.text = bookName
        self.likeCountLabel.text = "\(likeCount)"
        self.bookmarkCountLabel.text = "\(bookMarkCount)"
    }
    
    func setNoThemeData(sentence: String, bookName: String){
        self.sentenceLabel.text = sentence
        self.bookNameLabel.text = bookName
        self.likeAndBookmarkCountStackview.isHidden = true
    }
}
