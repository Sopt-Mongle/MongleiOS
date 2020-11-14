//
//  SignUpServiceAgreeVC.swift
//  Mongle
//
//  Created by Yunjae Kim on 2020/10/31.
//  Copyright © 2020 이주혁. All rights reserved.
//

import UIKit

class SignUpServiceAgreeVC: UIViewController {

    @IBOutlet weak var xButtonArea: UIButton!
    @IBOutlet weak var xImage: UIImageView!
    @IBOutlet weak var mongleImageView: UIImageView!

    @IBOutlet var detailLabels: [UILabel]!
    
    @IBOutlet var titleLabels: [UILabel]!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setItems()
        // Do any additional setup after loading the view.
    }
    

    func setItems(){
        xImage.image = UIImage(named: "mySettingsServiceBtnClose")
        mongleImageView.image = UIImage(named: "mySettingsServiceImgMongle")
        
        for d in detailLabels {
            d.lineBreakMode = .byCharWrapping
            
            
        }
        
        
        
    }
    

}
