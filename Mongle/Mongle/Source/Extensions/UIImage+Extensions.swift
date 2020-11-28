//
//  UIImage+Extensions.swift
//  Mongle
//
//  Created by 이주혁 on 2020/11/28.
//  Copyright © 2020 이주혁. All rights reserved.
//

import UIKit

extension UIImage {
    func makeImageBlurEffect() -> UIImage {
        // convert UIImage to CIImage
        let inputCIImage = CIImage(image: self)!
        
        // Create Blur CIFilter, and set the input image
        let blurFilter = CIFilter(name: "CIGaussianBlur")!
        blurFilter.setValue(inputCIImage, forKey: kCIInputImageKey)
        blurFilter.setValue(8, forKey: kCIInputRadiusKey)

        // Get the filtered output image and return it
        let outputImage = blurFilter.outputImage!
        return UIImage(ciImage: outputImage)
    }
}
