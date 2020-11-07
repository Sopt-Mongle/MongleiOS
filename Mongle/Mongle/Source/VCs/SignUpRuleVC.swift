//
//  SignUpRuleVC.swift
//  Mongle
//
//  Created by Yunjae Kim on 2020/09/13.
//  Copyright © 2020 이주혁. All rights reserved.
//

import UIKit

class SignUpRuleVC: UIViewController {

    @IBOutlet weak var xButton: UIButton!
    @IBOutlet weak var xImageView: UIImageView!
    @IBOutlet weak var wholeImageView: UIImageView!
    @IBOutlet weak var upperBlur: UIImageView!
    @IBOutlet weak var underBlur: UIImageView!
    
    @IBOutlet weak var whoeScrollView: UIScrollView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setItems()
        whoeScrollView.delegate = self
        // Do any additional setup after loading the view.
    }
    
    func setItems(){
//        xButton.alpha = 0
        xImageView.image = UIImage(named: "joinStep1PolicyBtnClose")
        wholeImageView.image = UIImage(named: "joinStep1PolicyYangachiYoonjae")
        upperBlur.image = UIImage(named: "joinStep1ServiceBoxBlur2")
        underBlur.image = UIImage(named: "mySettingsServiceBoxBlur")
        
        upperBlur.alpha = 0
        underBlur.alpha = 0
        
    }

    @IBAction func xButtonAction(_ sender: Any) {
        print("called")
        dismiss(animated: true, completion: nil)
    }
    
    
    

}

extension SignUpRuleVC : UIScrollViewDelegate {
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        upperBlur.alpha = 1
        underBlur.alpha = 1
    }
    
    
}
