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
    @IBOutlet weak var textQuantityLabel: UILabel!
    
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
        $0.text = ""
        $0.font = UIFont.systemFont(ofSize: 13)
        $0.textColor = .veryLightPink
    }
    
    var headerLine = UIView().then {
        $0.backgroundColor = .veryLightPinkSix
        
    }
    
    var emptyImageView = UIImageView().then {
        $0.image = UIImage(named : "writingSentenceBook4EmptyImgMongle")
        
    }
    
    var emptyLabel1 = UILabel().then {
        $0.text = "검색 결과가 없습니다."
        $0.font = $0.font.withSize(16)
        $0.textColor = .black
        
        
    }
    var emptyLabel2 = UILabel().then {
        $0.text = "다른 키워드로 검색해보세요!"
        $0.font = $0.font.withSize(13)
        $0.textColor = .veryLightPink
        
    }
    
    var bookSendDelegate : BookSearchDataDelegate?
    var bookInformations : [Book] = []
    
   
    
    
    
    
    //MARK:- LifeCycle Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchTextField.delegate = self
       
        
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
    func setBookInformations(title : String){
        bookInformations = []
        BookSearchForWritingService.shared.bookSearch(title: title) { networkResult in
            switch networkResult{
            case .success(let data) :
                
                guard let bookDatas = data as? [BookSearchForWritingData]  else {return}
                
                
                
                
                for bookData  in bookDatas{
                    self.bookInformations.append(Book(bookImgName: bookData.thumbnail, bookTitle: bookData.title, bookAuthors: bookData.authors, bookPublisher: bookData.publisher))
                }
                
                
                self.bookTableView.reloadData()
                self.headerLabel2.text = "총" + String(bookDatas.count) + "건"
                
            case .requestErr(let message):
                guard let message = message as? String else {return}
                print(message)
            case .pathErr: print("pathErr")
            case .serverErr: print("serverErr")
            case .networkFail: print("networkFail")
                
                
                
            }
        }
        
        
        
        
      
    }
    
    
    func setItems(){
        containView.backgroundColor = .white
        containView.setBorder(borderColor: .veryLightPinkFive, borderWidth: 1)
        containView.makeRounded(cornerRadius: 5)
        searchTextField.setBorder(borderColor: .red, borderWidth: 0)
        searchTextField.placeholder = "책 제목을 검색해주세요"
        searchTextField.addTarget(self, action: #selector(textFieldDidChange),
        for: .editingChanged)
        textQuantityLabel.textColor = .veryLightPink
        
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
    
    func hideEmpty(){
          emptyLabel2.removeFromSuperview()
          emptyLabel1.removeFromSuperview()
          emptyImageView.removeFromSuperview()
          
          
      }
    func showEmpty(){
        bookTableView.isHidden = true
        self.view.addSubview(emptyImageView)
        self.view.addSubview(emptyLabel1)
        self.view.addSubview(emptyLabel2)
        
        emptyImageView.snp.makeConstraints{
            $0.top.equalToSuperview().offset(372)
            $0.leading.equalToSuperview().offset(155)
            $0.width.equalTo(65)
            $0.height.equalTo(70)
        }
        emptyLabel1.snp.makeConstraints{
            $0.top.equalToSuperview().offset(457)
            $0.leading.equalToSuperview().offset(121)
        }
        
        emptyLabel2.snp.makeConstraints{
            $0.top.equalToSuperview().offset(482)
            $0.leading.equalToSuperview().offset(117)
        }
        firstLabel.alpha = 0
        secondLabel.alpha = 0
        smallCircle.alpha = 0
        smallCircle2.alpha = 0
        
        
    }
    

    
    @IBAction func searchButtonAction(_ sender: Any) {
        
        //Temp logic
        if searchTextField.text == "" {
            showEmpty()
            self.view.endEditing(true)
            
        }
        
        else{
            hideEmpty()
            self.bookTableView.isHidden = false
            setBookInformations(title: searchTextField.text!)
            searchKeyWord = searchTextField.text!
            headerLabel1.text = "'" + searchKeyWord+"'" + "검색결과"
            smallCircle.alpha = 0
            smallCircle2.alpha = 0
            partialGreenColor()
            self.textQuantityLabel.alpha = 0
            self.view.endEditing(true)
            //        self.tempView.isHidden = true
        }
    
        
    }
    
    func partialGreenColor(){
        
        guard let text = self.headerLabel1.text else {
            return
        }
        headerLabel1.textColor = .black
        let attributedString = NSMutableAttributedString(string: headerLabel1.text!)
        attributedString.addAttribute(NSAttributedString.Key.foregroundColor,
                                      value: UIColor.softGreen,
                                      range: (text as NSString).range(of: "'" + searchKeyWord + "'"))
        headerLabel1.attributedText = attributedString
    }
    
    @objc func textFieldDidChange(){
    
        textQuantityLabel.text = String(searchTextField.text!.count)+"/40"
        partialGreenColor2()
    }

    
   
    func partialGreenColor2(){
        guard let text = self.textQuantityLabel.text else {
            return
        }
        textQuantityLabel.textColor = .softGreen
        let attributedString = NSMutableAttributedString(string: textQuantityLabel.text!)
        attributedString.addAttribute(NSAttributedString.Key.foregroundColor,
                                      value: UIColor.veryLightPink,
                                      range: (text as NSString).range(of: "/40"))
        if searchTextField.text == "" {
            textQuantityLabel.textColor = .veryLightPink
        }
        
        
        textQuantityLabel.attributedText = attributedString
        
        
    }
    
    @IBAction func backButtonAction(_ sender: Any) {
        
       
        dismiss(animated: true, completion: nil)
        
    }
    

}


extension SearchBookForWritingVC : UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
       
        
        
        bookSendDelegate?.sendBookData(Data: bookInformations[indexPath.row], isSelected: true,
                                       noAnimation: true)
        
        dismiss(animated: true, completion: nil)
              
            
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
        guard let bookCell = tableView.dequeueReusableCell(withIdentifier: "searchedBookCell",
                                                           for: indexPath) as? SearchedBookTVC
            else{
                return UITableViewCell()}
        bookCell.setBook(bookImgName: bookInformations[indexPath.row].bookImgName,
                         bookTitle: bookInformations[indexPath.row].bookTitle,
                         bookAuthors: bookInformations[indexPath.row].bookAuthors,
                         bookPublisher: bookInformations[indexPath.row].bookPublisher)
    
        return bookCell
        
        
        
        
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return header
    }
    
    
}
