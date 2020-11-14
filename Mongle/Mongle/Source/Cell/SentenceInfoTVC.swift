//
//  SentenceInfoTVC.swift
//  Mongle
//
//  Created by 이주혁 on 2020/07/12.
//  Copyright © 2020 이주혁. All rights reserved.
//

import UIKit

class SentenceInfoTVC: UITableViewCell {
    
    static let identifier = "SentenceInfoTVC"
    
    @IBOutlet var editButton: UIButton!
    @IBOutlet var sentenceLabel: UILabel!
    @IBOutlet var curatorProfileImageView: UIImageView!
    @IBOutlet var curatorNameLabel: UILabel!
    
    @IBOutlet var bookNameLabel: UILabel!
    @IBOutlet var bookWriterNameLabel: UILabel!
    @IBOutlet var bookPublisherNameLabel: UILabel!
    
    @IBOutlet var bookImageView: UIImageView!
    
    var sentence: String?
    var editButtonDelegate: ((UIAlertController) -> Void) = { _ in }

    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        sentenceLabel.text = sentence ?? ""
        self.curatorProfileImageView.makeRounded(cornerRadius: self.curatorProfileImageView.frame.width / 2)
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
    }
    
    
    @IBAction func touchUpEditButton(sender: UIButton) {
        
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        self.editButtonDelegate(actionSheet)
    }
    
    func setSentenceData(sentence: String,
                         profileImg: String,
                         curatorName: String,
                         isLiked: Bool,
                         isBookmarked: Bool){
        self.sentenceLabel.text = sentence
        self.curatorProfileImageView.imageFromUrl(profileImg, defaultImgPath: "themeImgCurator")
        self.curatorNameLabel.text = curatorName
    }
    
    func setBookData(bookName: String, writerName: String, publisherName: String, bookImageUrl: String) {
        self.bookNameLabel.text = bookName
        self.bookWriterNameLabel.text = writerName
        self.bookPublisherNameLabel.text = publisherName
//        self.bookImageView.imageFromUrl(bookImageUrl, defaultImgPath: "themeWritingSentenceBook4ImgBook")
        self.bookImageView.image = UIImage(named: "themeWritingSentenceBook4ImgBook")
    }
}



extension UIAlertAction {
    var titleTextColor: UIColor? {
        get {
            return self.value(forKey: "titleTextColor") as? UIColor
        } set {
            self.setValue(newValue, forKey: "titleTextColor")
        }
    }
}
