//
//  OpenSourceDetailVC.swift
//  Mongle
//
//  Created by 이예슬 on 11/14/20.
//  Copyright © 2020 이주혁. All rights reserved.
//

import UIKit

class OpenSourceDetailVC: UIViewController {
    var titleText: String = ""
    var textViewText: String = ""
    
    @IBOutlet weak var titleView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = self.titleText
        textView.text = self.textViewText
        titleView.dropShadow(color: .black, offSet: CGSize(width: 0, height: 3), opacity: 0.04, radius: 6)
    
    }
    
    @IBAction func touchUpBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    

}
