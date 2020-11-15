//
//  MainPictureCVC.swift
//  Mongle
//
//  Created by 이주혁 on 2020/07/06.
//  Copyright © 2020 이주혁. All rights reserved.
//

import UIKit

class MainPictureCVC: UICollectionViewCell {
    static let identifier = "MainPictureCVC"

    @IBOutlet var displayPictureImageView: UIImageView!
    @IBOutlet var themeCountLabel: UILabel!
    @IBOutlet var themeNameLabel: UILabel!
    
    @IBOutlet var goThemeView: UIView!
    
    override func awakeFromNib() {
        setCell()
    }
    func setCell() {
        // 1
        goThemeView.backgroundColor = .clear
        
        goThemeView.makeRounded(cornerRadius: goThemeView.frame.width / 139 * 18)
        // 2
        let blurEffect = UIBlurEffect(style: .light)
        let vibrancyEffect = UIVibrancyEffect(blurEffect: blurEffect)
        let vibrancyView = UIVisualEffectView(effect: vibrancyEffect)
        vibrancyView.translatesAutoresizingMaskIntoConstraints = false
        // 3
//        vibrancyView.contentView.addSubview(optionsView)
        // 3
        let blurView = UIVisualEffectView(effect: blurEffect)
        // 4
        blurView.translatesAutoresizingMaskIntoConstraints = false
        blurView.contentView.addSubview(vibrancyView)
        
        goThemeView.insertSubview(blurView, at: 0)
        
        blurView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
        vibrancyView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
    }
}
