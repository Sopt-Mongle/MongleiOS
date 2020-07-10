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
    
    
    //MARK:- lifeCycleMethods
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    //MARK:- User Define Functions
    func setBook(bookImgName : String, bookTitle : String, bookAuthor : String, bookPublisher : String){
        bookImageView.image = UIImage(named: bookImgName)
        titleLabel.text = bookTitle
        authorLabel.text = bookAuthor
        publisherLabel.text = bookPublisher
        
    }

}


struct Book {
    var bookImgName : String
    var bookTitle : String
    var bookAuthor : String
    var bookPublisher : String
    
    init(bookImgName : String, bookTitle : String, bookAuthor : String, bookPublisher : String){
        self.bookImgName = bookImgName
        self.bookTitle = bookTitle
        self.bookAuthor = bookAuthor
        self.bookPublisher = bookPublisher
        
    }
    
    
    
    
}
