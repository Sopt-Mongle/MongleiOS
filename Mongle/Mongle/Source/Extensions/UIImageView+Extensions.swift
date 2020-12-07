//
//  UIImageView+Extensions.swift
//  Mongle
//
//  Created by 이주혁 on 2020/07/02.
//  Copyright © 2020 이주혁. All rights reserved.
//


import UIKit
import Kingfisher

// Kingfisher를 이용하여 url로부터 이미지를 가져오는 extension
extension UIImageView {
    
    public func imageFromUrl(_ urlString: String?) {
        if let url = urlString {
            self.kf.setImage(with: URL(string: url), options: [.transition(ImageTransition.fade(0.5))])
        }
    }
    
    public func imageFromUrl(_ urlString: String?, defaultImgPath : String) {
        let defaultImg = UIImage(named: defaultImgPath)
        if let url = urlString {
            if url.isEmpty {
                self.image = defaultImg
            } else {
                self.kf.setImage(with: URL(string: url), placeholder: defaultImg, options: [.transition(ImageTransition.fade(0.5))])
            }
        } else {
            self.image = defaultImg
        }
    }
    public func imageFromUrl(_ urlString: String?, defaultImgPath : String? = nil) {
        if let imageName = defaultImgPath
           ,let defaultImg = UIImage(named: imageName) {
            if let url = urlString {
                if url.isEmpty {
                    self.image = defaultImg
                } else {
                    self.kf.setImage(with: URL(string: url), placeholder: defaultImg, options: [.transition(ImageTransition.fade(0.5))])
                }
            } else {
                self.image = defaultImg
            }
        }
        else {
            if let url = urlString {
                if !url.isEmpty {
                    self.kf.setImage(with: URL(string: url), options: [.transition(ImageTransition.fade(0.5))])
                }
            }
        }
        
    }
    public func imageFromUrl(_ urlString: String?, defaultImgPath : String, completion: @escaping ()->()) {
        let defaultImg = UIImage(named: defaultImgPath)
        if let url = urlString {
            if url.isEmpty {
                self.image = defaultImg
            } else {
                self.kf.setImage(with: URL(string: url), placeholder: defaultImg, options: [.transition(ImageTransition.fade(0.5))]) { (result) in
                    completion()
                }
            }
        } else {
            self.image = defaultImg
        }
    }
    
    func makeBlurEffect() {
        // convert UIImage to CIImage
        if let image = self.image {
            let inputCIImage = CIImage(image: image)!
            
            // Create Blur CIFilter, and set the input image
            let blurFilter = CIFilter(name: "CIGaussianBlur")!
            blurFilter.setValue(inputCIImage, forKey: kCIInputImageKey)
            blurFilter.setValue(1, forKey: kCIInputRadiusKey)

            // Get the filtered output image and return it
            let outputImage = blurFilter.outputImage!
            self.image = UIImage(ciImage: outputImage)
        }
    }
}
