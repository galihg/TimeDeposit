//
//  Sheet.swift
//  TimeDeposit
//
//  Created by Kuncoro Galih Gemilang on 14/07/24.
//

import UIKit

final class Sheet: UIView {
    
    private lazy var title: UILabel = {
        let label: UILabel = UILabel.construct()
        label.font = UIFont(name: AppFont.bold.rawValue, size: 16)
        label.text = "Opsi Rollover"
        
        return label
    }()
    
    private lazy var closeAction: UIButton = {
        let button: UIButton = UIButton.construct()
        button.setImage(UIImage(named: "closeIcon"), for: .normal)
        button.addTarget(self, action: #selector(closeSheet), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var blurredEffect: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .dark)
        let blurredEffectView = UIVisualEffectView(effect: blurEffect)
        blurredEffectView.translatesAutoresizingMaskIntoConstraints = false
        
        return blurredEffectView
    }()
    
    var onDismissed: (() -> Void)?
    
    private var additionalView: UIView?
    private var contentHeightConstraint: NSLayoutConstraint!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        translatesAutoresizingMaskIntoConstraints = false
        
        setupViewAttributes()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func closeSheet(sender: UIButton) {
        dismiss()
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        dismiss()
    }
    
    func setupView(with additionalView: UIView) {
        self.additionalView = additionalView
        addSubviews(title, closeAction, additionalView)
        setupLayout(with: additionalView)
    }
    
    func show(from parentView: UIView) {
        addBlurEffect(on: parentView)
        parentView.addSubview(self)
                
        NSLayoutConstraint.activate([
            leadingAnchor.constraint(equalTo: parentView.leadingAnchor),
            trailingAnchor.constraint(equalTo: parentView.trailingAnchor),
            bottomAnchor.constraint(equalTo: parentView.bottomAnchor),
            heightAnchor.constraint(equalToConstant: 0)
        ])
        
        
        let screenSize = UIScreen.main.bounds
        let heightValue = screenSize.size.height / 2
        
        parentView.layoutIfNeeded()
        
        UIView.animate(
            withDuration: 0.5,
            delay: 0,
            usingSpringWithDamping: 1.0,
            initialSpringVelocity: 1.0,
            options: UIView.AnimationOptions.curveEaseIn,
            animations: {
                self.heightConstraint!.constant =  heightValue
                parentView.layoutIfNeeded()
        }, 
            completion: nil
        )
    }
    
    func dismiss() {
        onDismissed?()
        heightConstraint!.isActive = false
        contentHeightConstraint.isActive = false
        
        additionalView?.removeFromSuperview()
        blurredEffect.removeFromSuperview()
        removeFromSuperview()
    }
    
    private func setupViewAttributes(){
        backgroundColor = .white
        layer.cornerRadius = 16
    }
    
    private func setupLayout(with additionalView: UIView) {
        NSLayoutConstraint.activate([
            title.heightAnchor.constraint(equalToConstant: 16),
            title.centerXAnchor.constraint(equalTo: centerXAnchor),
            title.topAnchor.constraint(equalTo: safeTopAnchor, constant: 16),
            closeAction.topAnchor.constraint(equalTo: title.topAnchor, constant: 4),
            closeAction.widthAnchor.constraint(equalToConstant: 12),
            closeAction.heightAnchor.constraint(equalToConstant: 12),
            closeAction.trailingAnchor.constraint(equalTo: safeTrailingAnchor, constant: -16),
            additionalView.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 16),
            additionalView.leadingAnchor.constraint(equalTo: safeLeadingAnchor, constant: 16),
            additionalView.trailingAnchor.constraint(equalTo: safeTrailingAnchor, constant: -16),
            bottomAnchor.constraint(equalTo: additionalView.bottomAnchor, constant: 16)
        ])
        
        if additionalView.isKind(of: UITableView.self), let table = additionalView as? UITableView {
            contentHeightConstraint = table.heightAnchor.constraint(equalToConstant: 550)
            contentHeightConstraint.isActive = true
            
            table.reloadData()
            
            contentHeightConstraint.constant = CGFloat(table.contentSize.height)
        }
    }
    
    private func addBlurEffect(on view: UIView) {
        view.addSubview(blurredEffect)
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        blurredEffect.addGestureRecognizer(tap)
        NSLayoutConstraint.activate([
            blurredEffect.topAnchor.constraint(equalTo: view.topAnchor),
            blurredEffect.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            blurredEffect.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            blurredEffect.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
