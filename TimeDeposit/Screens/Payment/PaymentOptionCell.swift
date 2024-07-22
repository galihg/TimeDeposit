//
//  PaymentOptionCell.swift
//  TimeDeposit
//
//  Created by Kuncoro Galih Gemilang on 13/07/24.
//

import UIKit

final class PaymentOptionCell: UITableViewCell {

    struct PaymentOption {
        let title: String
        let logo: UIImage
    }
    
    private lazy var optionTitle: UILabel = {
        let title: UILabel = UILabel.construct()
        title.font = UIFont(name: AppFont.normal.rawValue, size: 14)
        
        return title
    }()
    
    private lazy var optionIcon: UIImageView = {
        let icon: UIImageView = UIImageView.construct()
        icon.contentMode = .scaleAspectFit
        
        return icon
    }()
    
    static var reusableIdentifier: String {
        "PaymentOptionCell"
    }
    
    func setupView(with option: PaymentOption) {
        optionTitle.text = option.title
        optionIcon.image = option.logo
        
        contentView.addSubviews(optionIcon, optionTitle)
        
        NSLayoutConstraint.activate([
            optionIcon.leadingAnchor.constraint(equalTo: contentView.safeLeadingAnchor, constant: 24),
            optionIcon.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            optionTitle.leadingAnchor.constraint(equalTo: optionIcon.trailingAnchor, constant: 16),
            optionTitle.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            optionIcon.heightAnchor.constraint(equalToConstant: 28),
            optionIcon.widthAnchor.constraint(equalToConstant: 40)
        ])
    }
}
