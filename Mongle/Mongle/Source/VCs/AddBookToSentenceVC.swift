//
//  AddBookToSentenceVC.swift
//  Mongle
//
//  Created by 이주혁 on 2020/07/13.
//  Copyright © 2020 이주혁. All rights reserved.
//

import UIKit

class AddBookToSentenceVC: UIViewController {
    @IBOutlet var introduceLabel: UILabel!
    
    @IBOutlet weak var authorTextField: UITextField!
    @IBOutlet weak var publisherTextField: UITextField!
    @IBOutlet weak var noticeLabel: UILabel!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var searchTextButton: UIButton!
    
    @IBOutlet weak var bookTitleLabel: UILabel!

    //MARK:- UI Component
    lazy var warningImageView: UIImageView = UIImageView().then {
        $0.frame = CGRect(x: 0, y: 0, width: 15, height: 15)
        $0.image = UIImage(named: "warning")
        
    }
    lazy var warningLabel: UILabel = UILabel().then {
        $0.frame = CGRect(x: 0, y: 0, width: 109, height: 16)
        $0.textColor = .reddish
        $0.text = "책 제목을 검색해주세요!"
        $0.sizeToFit()
        $0.font = UIFont.systemFont(ofSize: 13)
    }
    
    lazy var warningStackView: UIStackView = UIStackView().then {
        $0.frame = CGRect(x: 100, y: 100, width: 0, height: 0)
        $0.axis = .horizontal
        $0.alignment = .center
        $0.spacing = 8
    }
    
    var sentence: String?
    var themeIdx: Int?
    var bookInfo: Book?
    
    var isFill: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initLayout()
    }
    
    func setNextButton(){
        self.nextButton.backgroundColor = .softGreen
        self.nextButton.makeRounded(cornerRadius: 25)
    }
    
    func initLayout() {
        setNextButton()
        
        publisherTextField.then {
            $0.isEnabled = false
            $0.backgroundColor = .whiteThree
            $0.makeRounded(cornerRadius: 10)
            $0.setBorder(borderColor: .veryLightPinkFive, borderWidth: 1)
            $0.addLeftPadding(left: 15.0)
        }
        authorTextField.then {
            $0.isEnabled = false
            $0.backgroundColor = .whiteThree
            $0.makeRounded(cornerRadius: 10)
            $0.setBorder(borderColor: .veryLightPinkFive, borderWidth: 1)
            $0.addLeftPadding(left: 15.0)
        }
        
        bookTitleLabel.text = "책 제목을 검색해주세요."
        bookTitleLabel.textColor = .veryLightPink
        
        backButton.setImage(UIImage(named: "searchBtnBack"), for: .normal)
        backButton.tintColor = .veryLightPink
        
        
        let attributedString = NSMutableAttributedString(string: "한 문장이 담긴 책을 추가해주세요!", attributes: [
            .font: UIFont(name: "AppleSDGothicNeoM00", size: 18.0)!,
            .foregroundColor: UIColor.greyishBrown,
            .kern: -0.36
        ])
        attributedString.addAttribute(.foregroundColor, value: UIColor.softGreen, range: NSRange(location: 0, length: 4))
        introduceLabel.attributedText = attributedString
    }
    
    func setWarningState(){
        // stackview
        warningStackView.addArrangedSubview(warningImageView)
        warningStackView.addArrangedSubview(warningLabel)
        warningStackView.sizeToFit()
        
        self.view.addSubview(warningStackView)
        
        warningStackView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(16)
            $0.top.equalTo(searchTextButton.snp.bottom).offset(9)
        }

        searchTextButton.setBackgroundImage(UIImage(named: "themeWritingSentenceBookBtnBookSearch"), for: .normal)
    }
    
    func setNonWarningState(){
        warningStackView.removeFromSuperview()
        searchTextButton.setBackgroundImage(UIImage(named: "themeWritingSentence3BtnBookSearch"), for: .normal)

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
                            case .success(let idx):
                                self.showToast(text: "등록 완료")
                                guard let dvc = UIStoryboard(name: "EndOfWritingSentence", bundle: nil).instantiateViewController(identifier: "EndOfWritingSentenceVC") as? EndOfWritingSentenceVC else {
                                    return
                                }
                                dvc.sendingSentenceIdx = idx as! Int
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
        else {
            setWarningState()
        }
    }
}

extension AddBookToSentenceVC: BookSearchDataDelegate {
    func sendBookData(Data: Book, isSelected: Bool, noAnimation: Bool) {
        self.bookInfo = Data
        self.authorTextField.text = Data.bookAuthors[0]
        self.bookTitleLabel.text = Data.bookTitle
        self.bookTitleLabel.textColor = .black
        self.publisherTextField.text = Data.bookPublisher
        self.isFill = true
        setNonWarningState()
    }
}

