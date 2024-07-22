//
//  RolloverOptionCell.swift
//  TimeDeposit
//
//  Created by Kuncoro Galih Gemilang on 16/07/24.
//

import UIKit
import DLRadioButton

final class RolloverOptionCell: UITableViewCell {
    
    struct RolloverOption {
        let title: String
        let subtitle: String
        let description: String
        var isSelected: Bool
        
        mutating func setSelected(isSelected: Bool) {
            self.isSelected = isSelected
        }
    }
    
    static var reusableIdentifier: String {
        "RolloverOptionCell"
    }
    
    var onSelectOption: (() -> Void)?
    
    private lazy var title: UILabel = {
        let label: UILabel = UILabel.construct()
        label.font = UIFont(name: AppFont.bold.rawValue, size: 14)
        
        return label
    }()
    
    private lazy var subtitle: UILabel = {
        let label: UILabel = UILabel.construct()
        label.font = UIFont(name: AppFont.normal.rawValue, size: 12)
        label.numberOfLines = 0
        
        return label
    }()
    
    private lazy var explanation: UILabel = {
        let label: UILabel = UILabel.construct()
        label.font = UIFont(name: AppFont.normal.rawValue, size: 12)
        label.textColor = UIColor(rgb: 0x515151)
        label.numberOfLines = 0
        
        return label
    }()
    
    private lazy var contentStack: UIStackView = {
        let stack: UIStackView = UIStackView.construct()
        stack.axis = .vertical
        stack.spacing = 8
        
        return stack
    }()
    
    private lazy var selectionAction: DLRadioButton = {
        let button: DLRadioButton = DLRadioButton.construct()
        button.addTarget(self, action: #selector(self.optionSelected(_:)), for: .touchUpInside)
        button.iconColor = .black
        button.iconStrokeWidth = 1
        button.iconSelected = UIImage(named: "checkmarkIcon") ?? UIImage()

        return button
    }()
    
    private lazy var titleStack: UIStackView = {
        let stack: UIStackView = UIStackView.construct()
        stack.axis = .horizontal
        stack.distribution = .equalSpacing
        
        return stack
    }()
    
    override func prepareForReuse() {
        selectionAction.isSelected = false
    }
    
    @objc func optionSelected(_ sender: UIButton) {
        onSelectOption?()
    }
    
    func setupView(with option: RolloverOption) {
        title.text = option.title
        subtitle.text = option.subtitle
        explanation.text = option.description
        selectionAction.layer.cornerRadius = min(selectionAction.bounds.size.height, selectionAction.bounds.size.width) / 2

        if option.isSelected {
            selectionAction.isSelected = true
        }
        
        titleStack.addArrangedSubviews(title, selectionAction)
        contentStack.addArrangedSubviews(titleStack, explanation)
        
        if !option.subtitle.isEmpty {
            contentStack.insertArrangedSubview(subtitle, at: 1)
        }
        
        contentView.addSubview(contentStack)
        NSLayoutConstraint.activate([
            selectionAction.widthAnchor.constraint(equalToConstant: 16),
            selectionAction.heightAnchor.constraint(equalToConstant: 16),
            contentStack.topAnchor.constraint(equalTo: contentView.safeTopAnchor, constant: 16),
            contentStack.leadingAnchor.constraint(equalTo: contentView.safeLeadingAnchor),
            contentStack.trailingAnchor.constraint(equalTo: contentView.safeTrailingAnchor),
            bottomAnchor.constraint(equalTo: contentStack.bottomAnchor, constant: 16)
        ])
    }
}
