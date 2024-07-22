//
//  amountCellCollectionViewCell.swift
//  TimeDeposit
//
//  Created by Kuncoro Galih Gemilang on 13/07/24.
//

import UIKit

class AmountCell: UICollectionViewCell {
    
    static var reusableIdentifier: String {
        "AmountCell"
    }
    
    private lazy var amountTitle: UILabel = {
        let label: UILabel = UILabel.construct()
        label.font = UIFont(name: AppFont.normal.rawValue, size: 14)

        return label
    }()
    
    func setupView(amount: String) {
        layer.borderColor = UIColor.lightGray.cgColor
        layer.cornerRadius = 4
        layer.borderWidth = 1
        amountTitle.text = amount
        
        contentView.addSubview(amountTitle)
        amountTitle.pin(to: contentView)
    }
}
