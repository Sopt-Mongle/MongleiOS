
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

        // Do any additional setup after loading the view.
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
