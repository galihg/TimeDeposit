//
//  UIImage+Extension.swift
//  TimeDeposit
//
//  Created by Kuncoro Galih Gemilang on 18/07/24.
//

import UIKit

extension UIImage {
    convenience init?(color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) {
        let renderer = UIGraphicsImageRenderer(size: size)
        let image = renderer.image { (context) in
            color.setFill()
            context.fill(CGRect(origin: CGPoint.zero, size: size))
        }
        guard let pngData = image.pngData() else { return nil }
        self.init(data: pngData)
    }
}
