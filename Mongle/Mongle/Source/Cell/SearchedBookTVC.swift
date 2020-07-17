//
//  SearchedBookTVC.swift
//  Mongle
//
//  Created by Yunjae Kim on 2020/07/10.
//  Copyright © 2020 이주혁. All rights reserved.
//

import UIKit

class SearchedBookTVC: UITableViewCell {
    
    //MARK:- IBOutlets
    
    @IBOutlet weak var bookImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var publisherLabel: UILabel!
    
    @IBOutlet weak var bottomLine: UIView!
    
    //MARK:- lifeCycleMethods
    override func awakeFromNib() {
        bottomLine.backgroundColor = .veryLightPinkSix
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    //MARK:- User Define Functions
    func setBook(bookImgName : String, bookTitle : String, bookAuthors : [String], bookPublisher : String){
        
        bookImageView.imageFromUrl(bookImgName, defaultImgPath: "")
        titleLabel.text = bookTitle
        authorLabel.text = ""
        
        for bookAuthor in bookAuthors{
            authorLabel.text! += bookAuthor + " "
        }
        
        publisherLabel.text = bookPublisher
        
        
    }

}


struct Book {
    var bookImgName : String
    var bookTitle : String
    var bookAuthors : [String]
    var bookPublisher : String
    
    init(bookImgName : String, bookTitle : String, bookAuthors : [String], bookPublisher : String){
        self.bookImgName = bookImgName
        self.bookTitle = bookTitle
        self.bookAuthors = bookAuthors
        self.bookPublisher = bookPublisher
        
    }
    
    
    
    
}
