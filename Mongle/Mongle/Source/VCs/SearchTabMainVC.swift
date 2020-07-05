//
//  SearchTabMainVC.swift
//  Mongle
//
//  Created by 이예슬 on 7/3/20.
//  Copyright © 2020 이주혁. All rights reserved.
//

import UIKit

class SearchTabMainVC: UIViewController {
    // MARK:- IBOutlet
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var stringCounter: UILabel!
    @IBOutlet weak var recentSearchCV: UICollectionView!
    @IBOutlet weak var recommendSearchCV: UICollectionView!
    
    // MARK:- LifeCycle Method
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //searchTextField.delegate = self
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        searchTextField.becomeFirstResponder()
    }
    
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}

//extension SearchTabMainVC: UITextFieldDelegate{
//    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//        let strLength = textField.text?.count ?? 0
//        //print(strLength)
//        let lngthToAdd = string.count
//        //print(lngthToAdd)
//        let lengthCount = strLength + lngthToAdd
//        self.stringCounter.text = "\(lengthCount)"
//        return true
//    }
//
//}
