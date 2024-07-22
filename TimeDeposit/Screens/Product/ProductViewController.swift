//
//  ViewController.swift
//  TimeDeposit
//
//  Created by Kuncoro Galih Gemilang on 12/07/24.
//

import UIKit
import PKHUD

final class ProductViewController: UIViewController {
    
    let viewModel: ProductViewModel
    var onOpenProduct: ((Product) -> Void)?
    
    private lazy var underlineBar: UIView = {
        let underline: UIView = UIView.construct()
        underline.backgroundColor = UIColor(rgb: 0xFFD400)
        
        return underline
    }()
    
    private lazy var productTable: UITableView = {
        let table: UITableView = UITableView.construct()
        table.dataSource = self
        table.delegate = self
        table.bounces = false
        table.rowHeight = 136
        table.showsVerticalScrollIndicator = false
        table.separatorStyle = .singleLine
        table.separatorColor = .lightGray
        table.layer.cornerRadius = 16
        table.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.5).cgColor
        table.layer.borderWidth = 1
        table.separatorInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        
        table.register(ProductCell.self, forCellReuseIdentifier: ProductCell.reusableIdentifier)
                
        return table
    }()
    
    private lazy var productTitle: UILabel = {
        let label: UILabel = UILabel.construct()
        label.font = UIFont(name: AppFont.bold.rawValue, size: 16)
        
        return label
    }()
    
    private lazy var productSegment: UISegmentedControl = {
        let segment: UISegmentedControl = UISegmentedControl.construct()
        segment.setBackgroundImage(UIImage(color: .white), for: .normal, barMetrics: .default)
        segment.addTarget(self, action: #selector(self.changeProductType(_:)), for: .valueChanged)
        
        segment.setTitleTextAttributes(
            [NSAttributedString.Key.font : UIFont(name: AppFont.normal.rawValue, size: 15) ?? UIFont()],
            for: .normal
        )
        segment.setTitleTextAttributes(
            [NSAttributedString.Key.font : UIFont(name: AppFont.bold.rawValue, size: 15) ?? UIFont()],
            for: .selected
        )
        
        return segment
    }()
    
    private var underlineBarLeftAnchor: NSLayoutConstraint!

    init(viewModel: ProductViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        view.addSubviews(productSegment, underlineBar, productTitle, productTable)
        addSwipeGesture()
        HUD.show(.progress)
        viewModel.getProducts { [weak self] in
            
            DispatchQueue.main.async {
                HUD.hide()
                self?.setupProductSegment()
                self?.setupConstraint()
            }
        }
        
        setupPageHeader()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        productTable.heightConstraint?.constant = CGFloat(productTable.contentSize.height)
    }

    private func setupPageHeader() {
        let title: UILabel = UILabel()
        title.font = UIFont(name: AppFont.bold.rawValue, size: 16.0)
        title.text = "Wealth"
        
        let spacer = UIView()
        let constraint = spacer.widthAnchor.constraint(greaterThanOrEqualToConstant: CGFloat.greatestFiniteMagnitude)
        constraint.isActive = true
        constraint.priority = .defaultLow

        let stack = UIStackView(arrangedSubviews: [title, spacer])
        stack.axis = .horizontal

        navigationItem.titleView = stack
    }
    
    private func setupProductSegment() {
        var segmentTitle: [String] = []
        
        viewModel.products.forEach { product in
            segmentTitle.append(product.productGroupName == ProductViewModel.ProductType.flexible.rawValue ? "Fleksibel" : "Bunga Tetap")
        }
                
        for titleIndex in 0...segmentTitle.count - 1 {
            productSegment.insertSegment(withTitle: segmentTitle[titleIndex], at: titleIndex, animated: false)
        }
        
        productSegment.selectedSegmentIndex = 0
        
        productTitle.text = productSegment.titleForSegment(at: productSegment.selectedSegmentIndex)
        
        if let groupName = viewModel.products[productSegment.selectedSegmentIndex].productGroupName {
            viewModel.changeProduct(groupName: groupName)
            productTable.reloadData()
            
        }
    }
    
    private func addSwipeGesture() {
        let rightSwipe: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(self.swipeRight(_:)))
        rightSwipe.direction = .right
        view.addGestureRecognizer(rightSwipe)
        
        let leftSwipe: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(self.swipeLeft(_:)))
        leftSwipe.direction = .left
        view.addGestureRecognizer(leftSwipe)
    }
    
    private func setupConstraint() {
        
        NSLayoutConstraint.activate([
            productSegment.topAnchor.constraint(equalTo: view.safeTopAnchor, constant: 16),
            productSegment.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            productSegment.heightAnchor.constraint(equalToConstant: 20),
            underlineBar.topAnchor.constraint(equalTo: productSegment.bottomAnchor, constant: 8),
            underlineBar.heightAnchor.constraint(equalToConstant: 3),
            underlineBar.widthAnchor.constraint(equalTo: productSegment.widthAnchor, multiplier: 0.3 / CGFloat(productSegment.numberOfSegments)),
            productTitle.leadingAnchor.constraint(equalTo: view.safeLeadingAnchor, constant: 16),
            productTitle.heightAnchor.constraint(equalToConstant: 16),
            productTitle.topAnchor.constraint(equalTo: underlineBar.bottomAnchor, constant: 16),
            productTable.topAnchor.constraint(equalTo: productTitle.bottomAnchor, constant: 16),
            productTable.leadingAnchor.constraint(equalTo: view.safeLeadingAnchor, constant: 16),
            productTable.trailingAnchor.constraint(equalTo: view.safeTrailingAnchor, constant: -16),
            productTable.heightAnchor.constraint(equalToConstant: 300),
            view.bottomAnchor.constraint(equalTo: productTable.bottomAnchor, constant: 16)
        ])
        
        underlineBarLeftAnchor = underlineBar.leftAnchor.constraint(equalTo: productSegment.leftAnchor, constant: 40)
        underlineBarLeftAnchor.isActive = true
    }
    
    @objc func swipeRight(_ sender: UIGestureRecognizer) {
        
        if productSegment.selectedSegmentIndex > 0 {
            productSegment.selectedSegmentIndex -= 1
            changeProductType(productSegment)
        }
    }
    
    @objc func swipeLeft(_ sender: UIGestureRecognizer) {
        
        if productSegment.selectedSegmentIndex < productSegment.numberOfSegments - 1 {
            productSegment.selectedSegmentIndex += 1
            changeProductType(productSegment)
        }
    }
    
    @objc func changeProductType(_ sender: UISegmentedControl) {
        productTitle.text = productSegment.titleForSegment(at: productSegment.selectedSegmentIndex)

        let padding: CGFloat
        
        if productSegment.selectedSegmentIndex == 0 {
            padding = productSegment.bounds.width / CGFloat(productSegment.numberOfSegments) - underlineBar.bounds.width * 2 - 4
        } else {
            padding = underlineBar.frame.width * CGFloat(productSegment.selectedSegmentIndex) + productSegment.bounds.width / CGFloat(productSegment.numberOfSegments)
        }
        
        underlineBarLeftAnchor.constant = padding
        
        if let groupName = viewModel.products[sender.selectedSegmentIndex].productGroupName {
            viewModel.changeProduct(groupName: groupName)
            
            productTable.reloadData()
        }
        
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
}

extension ProductViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.currentProducts.count
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if viewModel.reloadNextContent(currentIndex: indexPath.row, groupName: viewModel.products[productSegment.selectedSegmentIndex].productGroupName ?? "") {
            viewModel.loadProducts(groupName: viewModel.products[productSegment.selectedSegmentIndex].productGroupName ?? "")
            tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: ProductCell.reusableIdentifier, for: indexPath) as? ProductCell {
            cell.setupUI(with: viewModel.currentProducts[indexPath.row])
            cell.selectionStyle = .none
            cell.onTapProduct = {
                self.onOpenProduct?(self.viewModel.currentProducts[indexPath.row])
            }
            
            return cell
        } else {
            return UITableViewCell()
        }
    }
}

extension ProductViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        onOpenProduct?(viewModel.currentProducts[indexPath.row])
    }
}
