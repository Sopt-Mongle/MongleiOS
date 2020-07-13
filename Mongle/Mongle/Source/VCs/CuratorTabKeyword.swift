//
//  CuratorTabKeyword.swift
//  Mongle
//
//  Created by 이예슬 on 7/13/20.
//  Copyright © 2020 이주혁. All rights reserved.
//

import UIKit

class CuratorTabKeyword: UIViewController {
    
    var selectedKeyword:String?
    @IBOutlet weak var keywordTitleLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        keywordTitleLabel.text = selectedKeyword
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
