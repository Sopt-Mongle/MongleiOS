//
//  WritingThemeViewController.swift
//  Mongle
//
//  Created by Yunjae Kim on 2020/07/03.
//  Copyright © 2020 이주혁. All rights reserved.
//

import UIKit

class WritingThemeVC: UIViewController, UITextFieldDelegate {
    
    

    @IBOutlet weak var textQuantityLabel: UILabel!
    @IBOutlet weak var applyButton: UIButton!
    @IBOutlet weak var themeNameTextField: UITextField!
    
    
    var textNum : Int?
    let textLengthSelector : Selector =  #selector(WritingThemeVC.updateTextLength)
    var timer : Timer!
    var lastLetter : String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        themeNameTextField.delegate = self
        setThemeNameTextField()
        // Do any additional setup after loading the view.
        setApplyButton()
        textQuantityLabel.text = "0/80"
        textNum = 0;
        textNum = themeNameTextField.text?.count
        lastLetter = ""
        print(textNum!)
        timer = Timer.scheduledTimer(timeInterval: 0.1,
                                     target: self,
                                     selector: textLengthSelector,
                                     userInfo: nil,
                                     repeats: true)
        
    }
    
//
//    func textField(_ textField: UITextField,
//                   shouldChangeCharactersIn range: NSRange,
//                   replacementString string: String) -> Bool {
//
//        textNum = textField.text?.count ?? 0
//        print(lastLetter!)
//
////        입력
//        if string.count==1{
////            모음이 입력됨
//            if collectionKorean.contains(string){
////                lastLetter : 모음
//                if collectionKorean.contains(lastLetter!){
//                    print("1")
//                    textQuantityLabel.text = String(textNum!)+"/80"
//                }
//
////                lastLetter : 자음
//                else{
//                    print("2")
//                    textQuantityLabel.text = String(textNum!+1)+"/80"
//                }
//
//            }
//
////            자음이 입력됨
//            else{
////                lastletter가 모음
//                if collectionKorean.contains(lastLetter!){
//                    print("3")
//                    textQuantityLabel.text = String(textNum!)+"/80"
//
//                }
//                else{
//                    print("4")
//                    textQuantityLabel.text = String(textNum!+1)+"/80"
//
//
//                }
//
//            }
//
//        }
//        else{
//
//            textQuantityLabel.text = String(textNum!-1)+"/80"
//
//        }
//
//        lastLetter = string
//
//        return true
//
//    }



   
    
    func setThemeNameTextField(){
        themeNameTextField.setBorder(borderColor: .white, borderWidth: 1.0)

    }
    
    func setApplyButton(){
        
        applyButton.makeRounded(cornerRadius: 25)
        applyButton.backgroundColor = .softGreen
        
        
    }
    
    @objc func updateTextLength(){
        textNum = themeNameTextField.text?.count
        textQuantityLabel.text = String(textNum!)+"/80"
        
    }
    
    
    @IBAction func resetTextQuantity(_ sender: UITextField) {
        textNum = themeNameTextField.text?.count
       
        textQuantityLabel.text = String(textNum!)+"80"
        
    }
    @IBAction func applyButtonAction(_ sender: Any) {
        textNum = themeNameTextField.text?.count
        print(textNum!)
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation
     before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    
    
    

}
