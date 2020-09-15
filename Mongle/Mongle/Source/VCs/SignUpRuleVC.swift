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
    @IBOutlet weak var containImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setItems()
        // Do any additional setup after loading the view.
    }
    
    func setItems(){
//        xButton.alpha = 0
        xImageView.image = UIImage(named: "joinStep1PolicyBtnClose")
        containImageView.image = UIImage(named: "joinStep1PolicyYangachiYoonjae")
        
    }

    @IBAction func xButtonAction(_ sender: Any) {
        print("called")
        dismiss(animated: true, completion: nil)
    }
    

}
