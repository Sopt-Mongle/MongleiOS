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
    
    
    
    
    //MARK:- LifeCycle Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchTextField.delegate = self
       
       
        setItems()
       
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
        smallCircle.alpha = 0
        smallCircle2.alpha = 0
//        self.tempView.isHidden = true
        
    }
    
    
    
    

}

 
