//
//  ProductCell.swift
//  TimeDeposit
//
//  Created by Kuncoro Galih Gemilang on 12/07/24.
//

import UIKit

final class ProductCell: UITableViewCell {
    
    static var reusableIdentifier: String {
        "ProductCell"
    }
    
    var onTapProduct: (() -> Void)?
    
    private lazy var name: UILabel = {
        let label: UILabel = UILabel.construct()
        label.font = UIFont(name: AppFont.bold.rawValue, size: 16)
        
        return label
    }()
    
    private lazy var nameSuffix: UILabel = {
        let label: UILabel = UILabel.construct()
        label.font = UIFont(name: AppFont.bold.rawValue, size: 14)
        label.text = " Populer "
        label.textColor = .white
        label.backgroundColor = .red
        label.layer.cornerRadius = 8
        label.layer.masksToBounds = true
        
        return label
    }()
    
    private lazy var nameStack: UIStackView = {
        let stack: UIStackView = UIStackView.construct()
        stack.axis = .horizontal
        stack.spacing = 8
        
        return stack
    }()
    
    private lazy var points: UILabel = {
        let label: UILabel = UILabel.construct()
        label.font = UIFont(name: AppFont.normal.rawValue, size: 14)
        label.numberOfLines = 0
        
        return label
    }()
    
    private lazy var interest: UILabel = {
        let label: UILabel = UILabel.construct()
        label.font = UIFont(name: AppFont.bold.rawValue, size: 17)
        label.textColor = UIColor(rgb: 0x0EBE5A)
        
        return label
    }()
    
    private lazy var interestSuffix: UILabel = {
        let label: UILabel = UILabel.construct()
        label.font = UIFont(name: AppFont.bold.rawValue, size: 14)
        label.textColor = UIColor(rgb: 0x0EBE5A)
        label.text = "p.a."

        return label
    }()
    
    private lazy var interestTopStack: UIStackView = {
        let stack: UIStackView = UIStackView.construct()
        stack.axis = .horizontal
        stack.spacing = 16
        
        return stack
    }()
    
    private lazy var interestStack: UIStackView = {
        let stack: UIStackView = UIStackView.construct()
        stack.axis = .vertical
        stack.spacing = 8
        
        return stack
    }()
    
    private lazy var interestTitle: UILabel = {
        let label: UILabel = UILabel.construct()
        label.font = UIFont(name: AppFont.bold.rawValue, size: 14)
        label.textColor = UIColor(rgb: 0x515151)
        label.text = "Bunga"

        return label
    }()
    
    private lazy var amount: UILabel = {
        let label: UILabel = UILabel.construct()
        label.font = UIFont(name: AppFont.bold.rawValue, size: 15)
        
        return label
    }()
    
    private lazy var amountTitle: UILabel = {
        let label: UILabel = UILabel.construct()
        label.font = UIFont(name: AppFont.bold.rawValue, size: 14)
        label.textColor = UIColor(rgb: 0x515151)
        label.text = "Mulai dari"
        
        return label
    }()
    
    private lazy var amountStack: UIStackView = {
        let stack: UIStackView = UIStackView.construct()
        stack.axis = .vertical
        stack.spacing = 8
        
        return stack
    }()
    
    private lazy var actionButton: UIButton = {
        let button: UIButton = UIButton.construct()
        button.backgroundColor = UIColor(rgb: 0xFFD400)
        button.addTarget(self, action: #selector(handleTouch), for: .touchUpInside)
        button.setTitle("Buka", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont(name: AppFont.bold.rawValue, size: 14)
        button.layer.cornerRadius = 16
        
        return button
    }()
    
    private lazy var topStack: UIStackView = {
        let stack: UIStackView = UIStackView.construct()
        stack.axis = .vertical
        stack.spacing = 8
        stack.alignment = .leading
        
        return stack
    }()
    
    private lazy var bottomStack: UIStackView = {
        let stack: UIStackView = UIStackView.construct()
        stack.axis = .horizontal
        stack.distribution = .equalSpacing
        
        return stack
    }()
    
    private lazy var contentStack: UIStackView = {
        let stack: UIStackView = UIStackView.construct()
        stack.axis = .vertical
        stack.distribution = .equalSpacing
        
        return stack
    }()
    
    override func prepareForReuse() {
        nameSuffix.removeFromSuperview()
        contentStack.removeFromSuperview()
        
        super.prepareForReuse()
    }
    
    @objc func handleTouch(sender: UIButton) {
        onTapProduct?()
    }
    
    func setupUI(with product: Product) {
        name.text = product.productName
        
        if product.isPopular ?? false {
            nameStack.addArrangedSubviews(name, nameSuffix)
            topStack.addArrangedSubview(nameStack)
        } else {
            topStack.addArrangedSubview(name)
        }
                
        var productPoints: String = ""
        
        if let marketingPoints = product.marketingPoints {
            
            for (index, point) in marketingPoints.enumerated() {
                
                if index == marketingPoints.count - 1 {
                    productPoints += "\(point)"
                } else {
                    productPoints += "\(point);"
                }
            }
            
            points.text = productPoints
            
            topStack.addArrangedSubview(points)
        }
        
        interest.text = "\(product.rate ?? 0)%"
        
        interestTopStack.addArrangedSubviews(interest, interestSuffix)
        interestStack.addArrangedSubviews(interestTopStack, interestTitle)
        
        amount.text = "Rp\(product.startingAmount ?? 0) rb"
        amountStack.addArrangedSubviews(amount, amountTitle)
        
        bottomStack.addArrangedSubviews(interestStack, amountStack, actionButton)
        contentStack.addArrangedSubviews(topStack, bottomStack)
        
        contentView.addSubview(contentStack)
        NSLayoutConstraint.activate([
            name.heightAnchor.constraint(equalToConstant: 16),
            interestSuffix.heightAnchor.constraint(equalToConstant: 14),
            interestSuffix.bottomAnchor.constraint(equalTo: interest.bottomAnchor),
            topStack.heightAnchor.constraint(equalToConstant: 40),
            bottomStack.heightAnchor.constraint(equalToConstant: 36),
            amount.heightAnchor.constraint(equalToConstant: 15),
            amount.bottomAnchor.constraint(equalTo: interest.bottomAnchor),
            interest.heightAnchor.constraint(equalToConstant: 16),
            interestTitle.heightAnchor.constraint(equalToConstant: 14),
            amountTitle.bottomAnchor.constraint(equalTo: interestTitle.bottomAnchor),
            amountTitle.heightAnchor.constraint(equalToConstant: 14),
            actionButton.centerYAnchor.constraint(equalTo: bottomStack.centerYAnchor),
            actionButton.widthAnchor.constraint(equalToConstant: 72),
            actionButton.heightAnchor.constraint(equalToConstant: 16),
            contentStack.topAnchor.constraint(equalTo: contentView.safeTopAnchor, constant: 16),
            contentStack.leadingAnchor.constraint(equalTo: contentView.safeLeadingAnchor, constant: 16),
            contentStack.trailingAnchor.constraint(equalTo: contentView.safeTrailingAnchor, constant: -16),
            contentView.bottomAnchor.constraint(equalTo: contentStack.bottomAnchor, constant: 16)
        ])
    }
}
