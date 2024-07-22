//
//  ViewHelper.swift
//  TimeDeposit
//
//  Created by Kuncoro Galih Gemilang on 14/07/24.
//

import UIKit

enum AppFont: String {
    case normal = "HelveticaNeue"
    case bold = "HelveticaNeue-Bold"
}

//final class ViewHelper {
//    
//    static func setupText(with labels: UILabel..., color: UIColor = UIColor(rgb: 0x000000), isBold: Bool = false, size: CGFloat = 17) {
//        labels.forEach { label in
//            label.font = UIFont(name: isBold ? "HelveticaNeue-Bold" : "HelveticaNeue", size: size)
//            label.textColor = color
//        }
//    }
//}

//final class ViewHelper {
//    
//    static let blurredEffect: UIVisualEffectView = {
//        let blurEffect = UIBlurEffect(style: .dark)
//        let blurredEffectView = UIVisualEffectView(effect: blurEffect)
//        blurredEffectView.translatesAutoresizingMaskIntoConstraints = false
//        
//        return blurredEffectView
//    }()
//    
//    static func showSheet(from view:)
//    
//    static func setupBlurView(from view: UIView) {
//        view.addSubview(blurredEffectView)
//        
//        NSLayoutConstraint.activate([
//            blurredEffectView.topAnchor.constraint(equalTo: view.topAnchor),
//            blurredEffectView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            blurredEffectView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            blurredEffectView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
//        ])
//    }
//}
