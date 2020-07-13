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
        
        vcName.modalPresentationStyle = .fullScreen
        self.present(vcName, animated: true, completion: nil)
        
    }
    
    @IBAction func backButton(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
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
