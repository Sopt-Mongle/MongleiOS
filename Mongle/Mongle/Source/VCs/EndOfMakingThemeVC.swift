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
    

    override func viewDidLoad() {
        super.viewDidLoad()
      
        setItems()

        // Do any additional setup after loading the view.
    }
    
    
    func setItems(){
        mongleImageView.image = UIImage(named: "maengleCharacters")?.withRenderingMode(.alwaysOriginal)
        
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
    }
    

    
    
    
    @IBAction func backToMainButtonActino(_ sender: Any) {
        
        
        self.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
    
    }
    
    
    
    
    
    
    

}