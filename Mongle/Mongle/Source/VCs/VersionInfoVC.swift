//
//  AppInfoVC.swift
//  Mongle
//
//  Created by 이주혁 on 2020/07/15.
//  Copyright © 2020 이주혁. All rights reserved.
//

import UIKit

class VersionInfoVC: UIViewController {

    @IBOutlet var versionStateLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        versionStateLabel.makeRounded(cornerRadius: 15)
        versionStateLabel.setBorder(borderColor: .softGreen, borderWidth: 1)
    }
    
    @IBAction func touchUpBackButton(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }

}
