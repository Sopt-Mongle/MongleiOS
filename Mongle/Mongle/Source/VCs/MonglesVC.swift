
//
//  MonglesVC.swift
//  Mongle
//
//  Created by 이주혁 on 2020/07/15.
//  Copyright © 2020 이주혁. All rights reserved.
//

import UIKit

class MonglesVC: UIViewController {
    
    @IBOutlet var partLabels: [UILabel]!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        partLabels.forEach {
            $0.makeRounded(cornerRadius: 16)
            $0.setBorder(borderColor: .softGreen, borderWidth: 1)
        }

    }

    @IBAction func touchUpBackButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
