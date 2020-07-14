//
//  EndOfWritingSentenceVC.swift
//  Mongle
//
//  Created by Yunjae Kim on 2020/07/11.
//  Copyright © 2020 이주혁. All rights reserved.
//

import UIKit

class EndOfWritingSentenceVC: UIViewController {

    
    //MARK:- IBOutlets
    
    @IBOutlet weak var EndImageView: UIImageView!
    @IBOutlet weak var firstLabel: UILabel!
    @IBOutlet weak var secondLabel: UILabel!
    @IBOutlet weak var sentenceCheckButton: UIButton!
    @IBOutlet weak var backToMainButton: UIButton!
    
    
    //MARK:- User Define Variables
    
    
    
    
    //MARK:- LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setItems()
        //self.view.addSubview(yesButton)
        imageAnimation1()
         
        // Do any additional setup after loading the view.
        
        
    }
    

  
    //MARK:- User Define Functions
    func setItems(){
        secondLabel.text = "몽글이님의 문장으로\n몽글이 더욱 풍부해졌어요!"
        secondLabel.textColor = .brownGreyTwo
        EndImageView.image = UIImage(named: "writingSentenceFinishImgSentence")?.withRenderingMode(.alwaysOriginal)
        sentenceCheckButton.backgroundColor = .softGreen
        sentenceCheckButton.setTitleColor(.white, for: .normal)
        sentenceCheckButton.makeRounded(cornerRadius: 21)
        backToMainButton.setTitleColor(.softGreen, for: .normal)
        backToMainButton.makeRounded(cornerRadius: 21)
        backToMainButton.setBorder(borderColor: .softGreen, borderWidth: 1.0)
        
        
        
    }
    
    
     
    func imageAnimation1(){
        UIView.animate(withDuration: 0.34, animations: {
            self.EndImageView.transform = CGAffineTransform(rotationAngle: 12/180)
            
            
        }, completion: { finish in
            UIView.animate(withDuration: 0.34, animations: {
                self.EndImageView.transform = CGAffineTransform(rotationAngle: -12/180)
                
                
            },completion: { finish in
                
                UIView.animate(withDuration: 0.34, animations: {
                    self.EndImageView.transform = CGAffineTransform(rotationAngle: 0/180)
                })
                
            })
            
            
            
        })
       
        
        
    }
    
    func imageAnimation(){
        UIView.animate(withDuration: 0.5, animations: {
            self.EndImageView.transform = CGAffineTransform(rotationAngle: -1/180)
            
            
        })
        
    }
    
     
     
     
    
    
    @IBAction func backToMainButtonAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        
    }
    
}
