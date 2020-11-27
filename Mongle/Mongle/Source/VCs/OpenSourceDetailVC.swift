//
//  OpenSourceDetailVC.swift
//  Mongle
//
//  Created by 이예슬 on 11/14/20.
//  Copyright © 2020 이주혁. All rights reserved.
//

import UIKit

class OpenSourceDetailVC: UIViewController, UITextViewDelegate{
    var titleText: String = ""
    var textViewText: String = ""
    
    @IBOutlet weak var titleView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var blurImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = self.titleText
        textView.text = self.textViewText
        textView.delegate = self
        textView.contentInset.bottom = 50
//        blurImageView.alpha = 0
    }
    
    @IBAction func touchUpBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let y = scrollView.contentOffset.y
        if y>0{
            titleView.dropShadow(color: .black, offSet: CGSize(width: 0, height: 7), opacity: 0.04, radius: 6)
            blurImageView.alpha = 1
        }
        else{
            titleView.layer.shadowOpacity = 0
        }
    }

}
