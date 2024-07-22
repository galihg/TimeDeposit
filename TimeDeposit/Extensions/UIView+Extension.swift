//
//  UIView+Extension.swift
//  TimeDeposit
//
//  Created by Kuncoro Galih Gemilang on 13/07/24.
//

import UIKit

extension UIView {
    
    var heightConstraint: NSLayoutConstraint? {
        return constraints.first(where: {
            $0.firstAttribute == .height && $0.relation == .equal
        })
    }
    
    var widthConstraint: NSLayoutConstraint? {
        return constraints.first(where: {
            $0.firstAttribute == .width && $0.relation == .equal
        })
    }
    
    var centerYConstraint: NSLayoutConstraint? {
        return constraints.first(where: {
            $0.firstAttribute == .centerY && $0.relation == .equal
        })
    }
    
    var topConstraint: NSLayoutConstraint? {
        return constraints.first(where: {
            $0.firstAttribute == .top && $0.relation == .equal
        })
    }
    
    var safeTopAnchor: NSLayoutYAxisAnchor {
        return self.safeAreaLayoutGuide.topAnchor
    }
    
    var safeLeftAnchor: NSLayoutXAxisAnchor {
        return self.safeAreaLayoutGuide.leftAnchor
    }
    
    var safeRightAnchor: NSLayoutXAxisAnchor {
        return self.safeAreaLayoutGuide.rightAnchor
    }
    
    var safeBottomAnchor: NSLayoutYAxisAnchor {
        return self.safeAreaLayoutGuide.bottomAnchor
    }
    
    var safeLeadingAnchor: NSLayoutXAxisAnchor {
        return self.safeAreaLayoutGuide.leadingAnchor
    }
    
    var safeTrailingAnchor: NSLayoutXAxisAnchor {
        return self.safeAreaLayoutGuide.trailingAnchor
    }
    
    @inline(__always) static func construct<T>(applyAttributes: ((T) -> Void)? = nil) -> T where T: UIView {
        let uiComponent = T(frame: .zero)
        uiComponent.translatesAutoresizingMaskIntoConstraints = false
        applyAttributes?(uiComponent)
        return uiComponent
    }
    
    func addSubviews(_ views: UIView...) {
        views.forEach { addSubview($0) }
    }
    
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
    
    func pin(to superview: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        pinTopAndSide(to: superview)
        if #available(iOS 11, *) {
            let guide = superview.safeAreaLayoutGuide
            NSLayoutConstraint.activate([
                guide.bottomAnchor.constraint(equalToSystemSpacingBelow: self.bottomAnchor, multiplier: 1.0)
            ])
        } else {
            let standardSpacing: CGFloat = 8.0
            NSLayoutConstraint.activate([
                self.bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: standardSpacing)
            ])
        }
    }
    
    func pinTopAndSide(to superview: UIView) {
        if #available(iOS 11, *) {
            let guide = superview.safeAreaLayoutGuide
            NSLayoutConstraint.activate([
                self.topAnchor.constraint(equalToSystemSpacingBelow: guide.topAnchor, multiplier: 1.0),
                self.leadingAnchor.constraint(equalToSystemSpacingAfter: guide.leadingAnchor, multiplier: 1.0),
                guide.trailingAnchor.constraint(equalToSystemSpacingAfter: self.trailingAnchor, multiplier: 1.0)
            ])
        } else {
            let standardSpacing: CGFloat = 8.0
            NSLayoutConstraint.activate([
                self.topAnchor.constraint(equalTo: superview.topAnchor, constant: standardSpacing),
                self.leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: standardSpacing),
                self.trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: standardSpacing)
            ])
        }
    }
    
    func pinTightly(to superview: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        let standardSpacing: CGFloat = 0.0
        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: superview.topAnchor, constant: standardSpacing),
            self.leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: standardSpacing),
            self.trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: standardSpacing),
            self.bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: standardSpacing)
        ])
    }
    
    public func pin(to view: UIView, topEdge: CGFloat? = nil, bottomEdge: CGFloat? = nil, leadingEdge: CGFloat? = nil, trailingEdge: CGFloat? = nil, height: CGFloat? = nil, width: CGFloat? = nil, centerX: CGFloat? = nil, centerY: CGFloat? = nil) {
        translatesAutoresizingMaskIntoConstraints = false
        if let topEdge = topEdge {
            topAnchor.constraint(equalTo: view.topAnchor, constant: topEdge).isActive = true
        }
        if let leadingEdge = leadingEdge {
            leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: leadingEdge).isActive = true
        }
        if let trailingEdge = trailingEdge {
            view.trailingAnchor.constraint(equalTo: trailingAnchor, constant: trailingEdge).isActive = true
        }
        if let bottomEdge = bottomEdge {
            view.bottomAnchor.constraint(equalTo: bottomAnchor, constant: bottomEdge).isActive = true
        }
        if let height = height {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
        if let width = width {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        if let centerX = centerX {
            centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: centerX).isActive = true
        }
        if let centerY = centerY {
            centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: centerY).isActive = true
        }
    }
}

extension UIStackView {
    func addArrangedSubviews(_ views: UIView...) {
        views.forEach { addArrangedSubview($0) }
    }
}
