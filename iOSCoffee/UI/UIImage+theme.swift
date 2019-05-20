//
//  UIImage_theme.swift
//  iOSCoffee
//
//  Created by Vlad Eliseev on 17/05/2019.
//  Copyright © 2019 Vlad Eliseev. All rights reserved.
//

import UIKit

extension UIImage {
    func crop(rect: CGRect) -> UIImage {
        var rect = rect
        rect.origin.x*=self.scale
        rect.origin.y*=self.scale
        rect.size.width*=self.scale
        rect.size.height*=self.scale
        
        let imageRef = self.cgImage!.cropping(to: rect)
        let image = UIImage(cgImage: imageRef!, scale: self.scale, orientation: self.imageOrientation)
        return image
    }
}
