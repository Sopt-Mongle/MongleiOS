//
//  SignUpEndVC.swift
//  Mongle
//
//  Created by Yunjae Kim on 2020/07/15.
//  Copyright © 2020 이주혁. All rights reserved.
//

import UIKit

class SignUpEndVC: UIViewController {
    
    //MARK:- IBOutlets
    
    @IBOutlet var endImageView: UIImageView!
    
    @IBOutlet var firstLabel: UILabel!
   
    
    @IBOutlet var endButton: UIButton!
    
    @IBOutlet var labelImageView: UIImageView!
    
    
    //MARK:- LifeCycle Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        endImageView.image = UIImage(named: "joinFinishImgMongles")
        labelImageView.image = UIImage(named: "yoonjaeHi")
        endButton.backgroundColor = .softGreen
        endButton.setTitle("메인으로 가기", for: .normal)
        endButton.setTitleColor(.white, for: .normal)
        endButton.makeRounded(cornerRadius: 20)
        
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func endButtonAction(_ sender: Any) {
        guard let vcName = UIStoryboard(name: "UnderTab",
                                        bundle: nil).instantiateViewController(
                                            withIdentifier: "UnderTabBarController") as? UINavigationController
            else{
                return
        }
        
        vcName.modalPresentationStyle = .fullScreen
        
        self.present(vcName, animated: true, completion: nil)
        
        
    }
    
   
}
