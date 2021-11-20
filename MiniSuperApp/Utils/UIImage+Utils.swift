//
//  UIImage+Utils.swift
//  MiniSuperApp
//
//  Created by Damor on 2021/11/20.
//

import UIKit

extension UIImage {
    convenience init?(color: UIColor) {
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context!.setFillColor(color.cgColor)
        context!.fill(rect)
        guard let image = UIGraphicsGetImageFromCurrentImageContext(),
              let data = image.pngData() else { return nil }
        UIGraphicsEndImageContext()
        self.init(data: data)
    }
}
