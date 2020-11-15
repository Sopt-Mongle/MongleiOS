//
//  AddBookToSentenceVC.swift
//  Mongle
//
//  Created by 이주혁 on 2020/07/13.
//  Copyright © 2020 이주혁. All rights reserved.
//

import UIKit

class AddBookToSentenceVC: UIViewController {
    
    @IBOutlet weak var authorTextField: UITextField!
    @IBOutlet weak var publisherTextField: UITextField!
    @IBOutlet weak var noticeLabel: UILabel!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var searchTextButton: UIButton!
    
    @IBOutlet weak var bookTitleLabel: UILabel!

    
    var sentence: String?
    var themeIdx: Int?
    var bookInfo: Book?
    
    var isFill: Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()

        publisherTextField.isEnabled = false
        authorTextField.isEnabled = false
        backButton.setImage(UIImage(named: "searchBtnBack"), for: .normal)
        backButton.tintColor = .veryLightPink
        setNextButton()
        searchTextButton.setImage(UIImage(named: "themeWritingSentenceBookBtnBookSearch")?.withRenderingMode(.alwaysOriginal), for: .normal)
        bookTitleLabel.text = ""
    }
    
    func setNextButton(){
          self.nextButton.backgroundColor = .softGreen
          self.nextButton.makeRounded(cornerRadius: 25)
          
          
      }
    

    
    @IBAction func searchTextButtonAction(_ sender: Any) {
        
        
        guard let vcName = UIStoryboard(name: "SearchBookForWriting",
                                        bundle: nil).instantiateViewController(
                                            withIdentifier: "SearchBookForWritingVC")
            as? SearchBookForWritingVC
            else{
                return
        }
        vcName.bookSendDelegate = self
        vcName.modalPresentationStyle = .fullScreen
        self.present(vcName, animated: true, completion: nil)
        
    }
    
    @IBAction func backButton(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func touchUpNextButton(sender: UIButton){
        if isFill {
            PostBookService
                .shared
                .postBook(sentence: self.sentence ?? "",
                          title: self.bookInfo?.bookTitle ?? "",
                          author: self.bookInfo?.bookAuthors[0] ?? "",
                          publisher: self.bookInfo?.bookPublisher ?? "",
                          thumbnail: self.bookInfo?.bookImgName ?? "",
                          themeIdx: self.themeIdx ?? 0) { networkResult in
                            switch networkResult{
                            case .success(_):
                                self.showToast(text: "등록 완료")
                                guard let dvc = UIStoryboard(name: "EndOfWritingSentence", bundle: nil).instantiateViewController(identifier: "EndOfWritingSentenceVC") as? EndOfWritingSentenceVC else {
                                    return
                                }
                                self.navigationController?.pushViewController(dvc, animated: true)
                            case .requestErr(let msg):
                                self.showToast(text: msg as? String ?? "request err")
                            case .pathErr:
                                self.showToast(text: "pathErr")
                            case .serverErr:
                                self.showToast(text: "serverErr")
                            case .networkFail:
                                self.showToast(text: "networkFail")
                                
                            }
            }
        }
    }
}

extension AddBookToSentenceVC: BookSearchDataDelegate {
    func sendBookData(Data: Book, isSelected: Bool, noAnimation: Bool) {
        self.bookInfo = Data
        self.authorTextField.text = Data.bookAuthors[0]
        self.bookTitleLabel.text = Data.bookTitle
        self.publisherTextField.text = Data.bookPublisher
        self.isFill = true
    }
}

