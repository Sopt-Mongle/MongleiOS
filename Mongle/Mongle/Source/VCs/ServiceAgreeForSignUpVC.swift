//
//  ServiceAgreeForSignUpVC.swift
//  Mongle
//
//  Created by Yunjae Kim on 2020/11/01.
//  Copyright © 2020 이주혁. All rights reserved.
//

import UIKit

class ServiceAgreeForSignUpVC: UIViewController {

    @IBOutlet weak var upperBlur: UIImageView!
    @IBOutlet weak var underBlur: UIImageView!
    
    
    @IBOutlet weak var xButtonImageView: UIImageView!
    @IBOutlet weak var wholeImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setItems()
        // Do any additional setup after loading the view.
    }
    
    func setItems(){
        wholeImageView.image = UIImage(named: "joinStep1ServiceGroup")
        xButtonImageView.image = UIImage(named: "mySettingsServiceBtnClose")
        upperBlur.image = UIImage(named: "joinStep1ServiceBoxBlur2")
        underBlur.image = UIImage(named: "mySettingsServiceBoxBlur")
        
    }

    @IBAction func xButtonAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
        
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
