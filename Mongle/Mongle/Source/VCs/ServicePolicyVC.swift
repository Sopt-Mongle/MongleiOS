//
//  ServicePolicyVC.swift
//  Mongle
//
//  Created by 이예슬 on 11/14/20.
//  Copyright © 2020 이주혁. All rights reserved.
//

import UIKit

class ServicePolicyVC: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var blurImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        blurImageView.alpha = 0
        scrollView.delegate = self
    }
    
    @IBAction func touchUpClose(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
  
}
extension ServicePolicyVC: UIScrollViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y > 0{
            blurImageView.alpha = 1
        }
        else{
            blurImageView.alpha = 0
        }
    }
}
