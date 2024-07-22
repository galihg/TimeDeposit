//
//  PaymentSectionHeaderCell.swift
//  TimeDeposit
//
//  Created by Kuncoro Galih Gemilang on 14/07/24.
//

import UIKit

final class PaymentSectionHeaderCell: UITableViewCell {
    
    static var reusableIdentifier: String {
        "PaymentSectionHeaderCell"
    }
    
    func setupView(section: PaymentViewController.PaymentSection) {
        let placeholder: UIStackView = UIStackView.construct()
        placeholder.axis = .horizontal
        placeholder.distribution = .equalSpacing
        
        let leftStack: UIStackView = UIStackView.construct()
        leftStack.axis = .horizontal
        leftStack.spacing = 16
        
        let placeholderTitle: UILabel = UILabel.construct()
        placeholderTitle.font = UIFont(name: AppFont.bold.rawValue, size: 16)
        placeholderTitle.text = section.title
        
        let leftIcon: UIImageView = UIImageView.construct()
        leftIcon.image = section.icons[0]
        leftIcon.contentMode = .scaleAspectFit
        
        leftStack.addArrangedSubviews(leftIcon, placeholderTitle)

        let rightStack: UIStackView = UIStackView.construct()
        leftStack.axis = .horizontal
        
        let rightIcon: UIImageView = UIImageView.construct()
        rightIcon.image = section.icons[1]
        rightIcon.contentMode = .scaleAspectFit
        
        rightStack.addArrangedSubviews(UIView(), rightIcon)
        placeholder.addArrangedSubviews(leftStack, rightStack)
        contentView.addSubview(placeholder)
        
        placeholder.pin(to: contentView)
        
        NSLayoutConstraint.activate([
            placeholder.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            placeholder.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            leftIcon.heightAnchor.constraint(equalToConstant: 24),
            leftIcon.widthAnchor.constraint(equalToConstant: 24),
            rightIcon.heightAnchor.constraint(equalToConstant: 16),
            rightIcon.widthAnchor.constraint(equalToConstant: 16),
            contentView.bottomAnchor.constraint(equalTo: placeholder.bottomAnchor, constant: 16)
        ])
    }
}
