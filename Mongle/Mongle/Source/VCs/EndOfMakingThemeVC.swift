//
//  EndOfMakingThene.swift
//  Mongle
//
//  Created by Yunjae Kim on 2020/07/12.
//  Copyright © 2020 이주혁. All rights reserved.
//

import UIKit

class EndOfMakingThemeVC: UIViewController {
    
    
    @IBOutlet weak var mongleImageView: UIImageView!
    @IBOutlet weak var firstLabel: UILabel!
    @IBOutlet weak var writeSentenceButton: UIButton!
    @IBOutlet weak var secondLabel: UILabel!
    @IBOutlet weak var backToMainButton: UIButton!
    
    @IBOutlet weak var imageTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var topConstraint2: NSLayoutConstraint!
    
    let deviceBound = UIScreen.main.bounds.height/812.0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        setItems()

        // Do any additional setup after loading the view.
    }
    
    
    func setItems(){
        mongleImageView.image = UIImage(named: "writingThemeFinishImgMongleTheme")?.withRenderingMode(.alwaysOriginal)
        
        firstLabel.text = "테마가 등록되었습니다!"
        secondLabel.text = "몽글이님의 테마를 의미있는 문장으로\n채워보는 건 어떨까요?"
        secondLabel.textColor = .brownGreyTwo
        writeSentenceButton.backgroundColor = .softGreen
        backToMainButton.setBorder(borderColor: .softGreen, borderWidth: 1.0)
        writeSentenceButton.makeRounded(cornerRadius: 22)
        backToMainButton.makeRounded(cornerRadius: 22)
        writeSentenceButton.setTitleColor(.white, for: .normal)
        backToMainButton.setTitleColor(.softGreen, for: .normal)
        secondLabel.textAlignment = .center
        if deviceBound < 1{
            imageTopConstraint.constant = 50
        }
       
        mongleImageView.frame.size.height *= deviceBound
        
        UIView.animate(withDuration: 1.0, animations: {
            self.mongleImageView.transform = CGAffineTransform(translationX: 0, y: 600)
            
            
        }, completion: { finished in
            
            UIView.animate(withDuration: 3.0,  delay : 0, options: [.curveEaseIn], animations: {
                self.mongleImageView.transform = .identity
                
            }, completion :{ finished in
                
                UIView.animate(withDuration: 1.0, animations: {
                    self.mongleImageView.transform = CGAffineTransform(translationX: 0, y: -600)
                    
                },completion: {finished in
                    UIView.animate(withDuration: 3.0, delay : 0.5,  animations: {
                     
                        self.mongleImageView.transform = CGAffineTransform(translationX: 0, y: 0)
                    })
                    
                    
                })
            })
            
        })
        
    }
    
    
    
    
    @IBAction func backToMainButtonActino(_ sender: Any) {
        
        
        self.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
    
    }
    
    
    
    
    
    
    

}
