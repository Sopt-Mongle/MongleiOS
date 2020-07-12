//
//  ThemeInfoVC.swift
//  Mongle
//
//  Created by 이주혁 on 2020/07/10.
//  Copyright © 2020 이주혁. All rights reserved.
//

import UIKit

class ThemeInfoVC: UIViewController {
    
    //MARK:- IBOutlet
    @IBOutlet var sentenceTableView: UITableView! {
        didSet {
            sentenceTableView.delegate = self
            sentenceTableView.dataSource = self
        }
    }
    @IBOutlet var sentencesBackgroundView: UIView!
    @IBOutlet var themeBackgroundView: UIView!
    @IBOutlet var writeInThemeButton: UIButton!
    @IBOutlet var themeInfoStackView: UIStackView!
    @IBOutlet var themeNameLabel: UILabel!
    
    @IBOutlet var curatorProfileImageView: UIImageView!
    @IBOutlet var curatorNameLabel: UILabel!
    
    
    //MARK:- Property
    var hasTheme: Bool = true
    
    
    var sentences = [
        "아아아아아아나난나ㅏ나난나나\n나나나나나난나ㅏ난아아아아아아나난나ㅏ나난",
        "아아아아아아나난나ㅏ나난나\n나나나나나나난나ㅏ난",
        "아아아아아아나난나ㅏ나난나나나나나나나난나ㅏ난",
        "아아아아아아나난나ㅏ나난나\n나나나나나나난나ㅏ난",
        "아아아아아아나난나ㅏ나난나나나나나나나난나ㅏ난",
        "아아아아아아나난나ㅏ나난나\n나나나나나나난나ㅏ난",
        "아아아아아아나난나ㅏ나난나나나나나나나난나ㅏ난",
        "아아아아아아나난나ㅏ나난나\n나나나나나나난나ㅏ난",
        "아아아아아아나난나ㅏ나난나나나나나나나난나ㅏ난"
    ]
    var themeText: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setInitLayout()
    }
    
    func setInitLayout(){
        if hasTheme {
            self.themeNameLabel.text = themeText ?? ""
            themeBackgroundView.backgroundColor = UIColor(red: 90/255,
                                                          green: 145 / 255,
                                                          blue: 105 / 255,
                                                          alpha: 0.55)
        }
        else {
            curatorProfileImageView.isHidden = true
            themeBackgroundView.backgroundColor = .veryLightPink
            themeInfoStackView.alpha = 0
            curatorNameLabel.snp.makeConstraints {
                $0.leading.equalToSuperview().offset(16)
            }
        }
        
        
        sentencesBackgroundView.layer.cornerRadius = 25
        sentencesBackgroundView.clipsToBounds = true
        writeInThemeButton.backgroundColor = .softGreen
        // .layerMaxXMinYCorner : 오른쪽 위
        // .layerMaxXMaxYCorner : 오른쪽 아래
        // .layerMinXMaxYCorner : 왼쪽 아래
        // .layerMinXMinYCorner : 왼쪽 위
        sentencesBackgroundView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
    }
    
    //MARK:- IBAction
    @IBAction func touchUpBackButton(sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
}

// MARK:- Extension
// MARK: UITableViewDelegate
extension ThemeInfoVC: UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 19
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 375, height: 19))
        //view.backgroundColor = .blue
        return view
    }
    
}
// MARK: UITableViewDataSource
extension ThemeInfoVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sentences.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SentenceInThemeTVC.identifier,
                                                       for: indexPath) as? SentenceInThemeTVC
            else {
                return UITableViewCell()
        }
        
        cell.sentenceLabel.text = self.sentences[indexPath.row]
        return cell
    }
}
