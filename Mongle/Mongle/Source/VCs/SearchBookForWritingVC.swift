//
//  SearchBookForWritingVC.swift
//  Mongle
//
//  Created by Yunjae Kim on 2020/07/09.
//  Copyright © 2020 이주혁. All rights reserved.
//

import UIKit
import Then
import SnapKit

class SearchBookForWritingVC: UIViewController,UITextFieldDelegate {
    
    //MARK:- IBOutlets
    
    @IBOutlet weak var containView: UIView!
    @IBOutlet weak var searchTextField: UITextField!
    
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    
    @IBOutlet weak var bookTableView: UITableView!
    @IBOutlet weak var tempView: UIView!
    
    @IBOutlet weak var firstLabel: UILabel!
    @IBOutlet weak var secondLabel: UILabel!
    
    //MARK:- User Define Variables
    
    let smallCircle = UIView().then{
        $0.backgroundColor = .veryLightPink
        
        
    }
    
    let smallCircle2 = UIView().then{
        $0.backgroundColor = .veryLightPink
        
        
    }
    var header = UIView()
    var searchKeyWord : String = ""

    var headerLabel1 = UILabel().then{
        $0.text = "'해리'검색결과"


        $0.font = UIFont.systemFont(ofSize: 13)
        

    }
    var headerLabel2 = UILabel().then{
        $0.text = "총 10건"
        $0.font = UIFont.systemFont(ofSize: 13)
        $0.textColor = .veryLightPink
    }
    
    var headerLine = UIView().then {
        $0.backgroundColor = .veryLightPinkSix
        
    }
    
    
    private var bookInformations : [Book] = []
    
   
    
    
    
    
    //MARK:- LifeCycle Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchTextField.delegate = self
       
        setBookInformations()
        setItems()
        bookTableView.delegate = self
        bookTableView.dataSource = self
        setTableViewHeader()
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        searchTextField.becomeFirstResponder()
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow(_:)), name:
            UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)),
                                               name:
            UIResponder.keyboardWillHideNotification, object: nil)
    }

    
    
    //MARK:- User Define Functions
    
    @objc func keyboardWillShow(_ notification: NSNotification) {
        
        
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey]
            as? NSValue)?.cgRectValue {
       
            
            self.view.layoutIfNeeded()
            
            
        }
    }
    func setTableViewHeader(){
        header = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 44))
        header.backgroundColor = .white
        self.header.addSubview(headerLabel1)
        self.header.addSubview(headerLabel2)
        self.header.addSubview(headerLine)
        
        headerLabel1.snp.makeConstraints{

            
            $0.leading.equalToSuperview().offset(0)
            $0.top.equalToSuperview().offset(13)
            
            
        }
        headerLabel2.snp.makeConstraints{
            $0.trailing.equalToSuperview().offset(0)
            $0.top.equalToSuperview().offset(13)
            
        }
        headerLine.snp.makeConstraints{
            $0.height.equalTo(1)
            $0.leading.trailing.equalToSuperview()
            $0.top.equalToSuperview().offset(44)
            
        }
        
    }
    func setBookInformations(){
        let book1 = Book(bookImgName: "themeWritingSentenceBook4ImgBook", bookTitle: "몽글이", bookAuthor: "이주혁", bookPublisher: "몽글")
        let book2 = Book(bookImgName: "themeWritingSentenceBook4ImgBook", bookTitle: "망글이", bookAuthor: "이예슬", bookPublisher: "몽글")
        let book3 = Book(bookImgName: "themeWritingSentenceBook4ImgBook", bookTitle: "밍글이", bookAuthor: "박현주", bookPublisher: "몽글")
        let book4 = Book(bookImgName: "themeWritingSentenceBook4ImgBook", bookTitle: "멍글이", bookAuthor: "유보미", bookPublisher: "몽글")
        let book5 = Book(bookImgName: "themeWritingSentenceBook4ImgBook", bookTitle: "뮹글이", bookAuthor: "유동현", bookPublisher: "몽글")
        let book6 = Book(bookImgName: "themeWritingSentenceBook4ImgBook", bookTitle: "몽글이", bookAuthor: "박세란", bookPublisher: "몽글")
        let book7 = Book(bookImgName: "themeWritingSentenceBook4ImgBook", bookTitle: "맹글이", bookAuthor: "이소민", bookPublisher: "몽글")
        bookInformations = [book1,book2,book3,book4,book5,book6,book7]
    }
    
    
    func setItems(){
        containView.backgroundColor = .white
        containView.setBorder(borderColor: .veryLightPinkFive, borderWidth: 1)
        containView.makeRounded(cornerRadius: 5)
        searchTextField.setBorder(borderColor: .red, borderWidth: 0)
        searchButton.backgroundColor = .white
        searchButton.setImage(UIImage(named: "searchBtnSearch"), for: .normal)
        searchButton.tintColor = .softGreen
        backButton.setImage(UIImage(named: "searchBtnBack"), for: .normal)
        backButton.tintColor = .veryLightPink
        bookTableView.isHidden = true
        secondLabel.text = "책 제목의 일부만 입력해도 책을 찾을 수 있어요 예) 해리포터와 불의 잔 → 해리"
        firstLabel.textColor = .veryLightPink
        secondLabel.textColor = .veryLightPink
        
        self.view.addSubview(smallCircle)
        self.view.addSubview(smallCircle2)
        
        smallCircle.snp.makeConstraints{
            $0.width.height.equalTo(5)
            $0.leading.equalToSuperview().offset(19.5)
            $0.centerY.equalTo(firstLabel.snp_centerYWithinMargins)
                  
        }
        smallCircle.makeRounded(cornerRadius: 2.5)
        
        smallCircle2.snp.makeConstraints{
            $0.width.height.equalTo(5)
            $0.leading.equalToSuperview().offset(19.5)
            $0.centerY.equalTo(firstLabel.snp_centerYWithinMargins).offset(24)
            
        }
        smallCircle2.makeRounded(cornerRadius: 2.5)
        
    }
    
    func setSearchTextField(){
        searchButton.setImage(UIImage(named: "searchBtnSearch"), for: .normal)
        searchButton.tintColor = .softGreen
        searchTextField.addLeftPadding(left : 7)
        
               
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        let newLength = (textField.text?.count)! + string.count - range.length
        return !(newLength > 40)
    }
    
    @objc func keyboardWillHide(_ notification: NSNotification) {
     
        
        self.view.layoutIfNeeded()
    }
    

    
    @IBAction func searchButtonAction(_ sender: Any) {
        self.bookTableView.isHidden = false
        searchKeyWord = searchTextField.text!
        headerLabel1.text = "'" + searchKeyWord+"'" + "검색결과"
        smallCircle.alpha = 0
        smallCircle2.alpha = 0
        partialGreenColor()
//        self.tempView.isHidden = true
        
    }
    
    func partialGreenColor(){
        
        guard let text = self.headerLabel1.text else {
            return
        }
        headerLabel1.textColor = .black
        let attributedString = NSMutableAttributedString(string: headerLabel1.text!)
        attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.softGreen,
                                      range: (text as NSString).range(of: "'" + searchKeyWord + "'"))
        headerLabel1.attributedText = attributedString
    }
    
    
    @IBAction func backButtonAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
        
    }
    

}


extension SearchBookForWritingVC : UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 112
    }

}


extension SearchBookForWritingVC : UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
  

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bookInformations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let bookCell = tableView.dequeueReusableCell(withIdentifier: "searchedBookCell", for: indexPath) as? SearchedBookTVC
            else{
                return UITableViewCell()}
        bookCell.setBook(bookImgName: bookInformations[indexPath.row].bookImgName, bookTitle: bookInformations[indexPath.row].bookTitle, bookAuthor: bookInformations[indexPath.row].bookAuthor, bookPublisher: bookInformations[indexPath.row].bookPublisher)
        
        return bookCell
        
        
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return header
    }
    
    
}