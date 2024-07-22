//
//  Toast.swift
//  TimeDeposit
//
//  Created by Kuncoro Galih Gemilang on 14/07/24.
//

import UIKit

final class Toast: UIView {
    
    private lazy var toastMessage: UILabel = {
        let label: UILabel = UILabel.construct()
        label.font = UIFont(name: AppFont.normal.rawValue, size: 14)
        label.textAlignment = .center
        
        return label
    }()
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        translatesAutoresizingMaskIntoConstraints = false
        
        setupViewAttributes()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func showToast(message: String, toastColor: UIColor, container: UIView) {
        container.addSubview(self)
        container.bringSubviewToFront(self)
        
        toastMessage.text = message
        backgroundColor = toastColor.withAlphaComponent(0.1)
        
        NSLayoutConstraint.activate([
            toastMessage.heightAnchor.constraint(equalToConstant: 16),
            heightAnchor.constraint(equalToConstant: 40),
            widthAnchor.constraint(equalToConstant: container.bounds.width - 32),
            bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -24),
            leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 16),
            trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -16)
        ])
        
        UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
            self.alpha = 0.0
        }, completion: { (isCompleted) in
            self.removeFromSuperview()
        })
    }
    
    private func setupViewAttributes() {
        layer.cornerRadius = 10
        clipsToBounds = true
        layer.borderColor = UIColor.lightGray.cgColor
        layer.borderWidth = 1
        
        addSubview(toastMessage)
        toastMessage.pin(to: self)
    }
}
