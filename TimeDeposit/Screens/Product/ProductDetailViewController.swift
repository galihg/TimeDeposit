//
//  ProductDetailViewController.swift
//  TimeDeposit
//
//  Created by Kuncoro Galih Gemilang on 14/07/24.
//

import UIKit
import SafariServices
import DLRadioButton

final class ProductDetailViewController: UIViewController {
    
    let viewModel: ProductDetailViewModel
    
    var onOpenPayment: ((String) -> Void)?
    
    private lazy var topStack: UIStackView = {
        let stack: UIStackView = UIStackView.construct()
        stack.axis = .vertical
        stack.spacing = 16
        stack.alignment = .leading
        stack.backgroundColor = .white
        stack.layoutMargins = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        stack.isLayoutMarginsRelativeArrangement = true
        
        return stack
    }()
    
    private lazy var productName: UILabel = {
        let label: UILabel = UILabel.construct()
        label.font = UIFont(name: AppFont.bold.rawValue, size: 16)
        
        return label
    }()
    
    private lazy var duration: UILabel = {
        let label: UILabel = UILabel.construct()
        label.font = UIFont(name: AppFont.normal.rawValue, size: 15)
        
        return label
    }()
        
    private lazy var topMiddleStack: UIStackView = {
        let stack: UIStackView = UIStackView.construct()
        stack.axis = .horizontal
        stack.spacing = 32
        
        return stack
    }()
    
    private lazy var interest: UILabel = {
        let label: UILabel = UILabel.construct()
        
        return label
    }()
    
    private lazy var interestSuffix: UILabel = {
        let label: UILabel = UILabel.construct()
        label.font = UIFont(name: AppFont.bold.rawValue, size: 14)
        label.textColor = UIColor(rgb: 0x0EBE5A)
        label.text = "p.a"

        return label
    }()
    
    private lazy var topDescription: UILabel = {
        let label: UILabel = UILabel.construct()
        label.font = UIFont(name: AppFont.normal.rawValue, size: 14)
        label.textColor = UIColor(rgb: 0x515151)
        label.numberOfLines = 0
        label.text = "Suku bunga saat ini akan dihitung berdasarkan \"suku bunga dasar + suku bunga tambahan\" dan suku bunga saat roll-over akan dihitung berdasarkan sunga bunga yang berlaku di tanggal roll-over"
        
        return label
    }()
    
    private lazy var middleStack: UIStackView = {
        let stack: UIStackView = UIStackView.construct()
        stack.axis = .vertical
        stack.spacing = 16
        stack.backgroundColor = .white
        stack.layoutMargins = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        stack.isLayoutMarginsRelativeArrangement = true

        return stack
    }()
    
    private lazy var innerMiddleStack: UIStackView = {
        let stack: UIStackView = UIStackView.construct()
        stack.axis = .vertical
        stack.spacing = 8
        
        return stack
    }()
    
    private lazy var amountTitle: UILabel = {
        let label: UILabel = UILabel.construct()
        label.font = UIFont(name: AppFont.bold.rawValue, size: 16)
        label.text = "Masukkan jumlah deposito"
        
        return label
    }()
    
    private lazy var currencyFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        
        return formatter
    }()
    
    private lazy var amountField: UITextField = {
        let field: UITextField = UITextField.construct()
        field.font = UIFont(name: AppFont.bold.rawValue, size: 17)
        
        let currency: UILabel = UILabel.construct()
        currency.font = UIFont(name: AppFont.bold.rawValue, size: 17)
        currency.text = "Rp"
        
        field.borderStyle = .roundedRect
        field.leftView = currency
        field.delegate = self
        field.keyboardType = .asciiCapableNumberPad
        
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 40))
        doneToolbar.barStyle = .default
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.doneButtonAction))
        
        let items = [flexSpace, done]
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        
        field.inputAccessoryView = doneToolbar
        
        return field
    }()
    
    private lazy var amountSection: UICollectionView = {
        let flow: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        flow.minimumLineSpacing = 4
        flow.minimumInteritemSpacing = 0
        flow.scrollDirection = .vertical
        
        let collection: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: flow)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.dataSource = self
        collection.delegate = self
        collection.register(AmountCell.self, forCellWithReuseIdentifier: AmountCell.reusableIdentifier)
        
        return collection
    }()
    
    private lazy var minAmount: UILabel = {
        let label: UILabel = UILabel.construct()
        label.font = UIFont(name: AppFont.normal.rawValue, size: 14)
        label.textColor = UIColor(rgb: 0x515151)
        
        return label
    }()
    
    private lazy var dueDate: UILabel = {
        let label: UILabel = UILabel.construct()
        label.font = UIFont(name: AppFont.normal.rawValue, size: 14)
        
        return label
    }()
    
    private lazy var separatorLine: SeparatorLine = {
        let separator: SeparatorLine = SeparatorLine.construct()
        separator.alignment = .horizontal
        separator.lineColor = .lightGray
        separator.lineGap = 4
        separator.lineLength = 4
        separator.lineWidth = 1
        separator.pattern = .dash
        
        return separator
    }()
    
    private lazy var interestAmount: UILabel = {
        let label: UILabel = UILabel.construct()
        label.font = UIFont(name: AppFont.normal.rawValue, size: 15)
        
        return label
    }()
    
    private lazy var interestAmountTitle: UILabel = {
        let label: UILabel = UILabel.construct()
        label.font = UIFont(name: AppFont.normal.rawValue, size: 15)
        label.text = "Estimasi bunga"
        label.textColor = UIColor(rgb: 0x515151)
        
        return label
    }()
    
    private lazy var interestAmountStack: UIStackView = {
        let stack: UIStackView = UIStackView.construct()
        stack.axis = .horizontal
        stack.distribution = .equalSpacing
        
        return stack
    }()
    
    private lazy var rolloverStack: UIStackView = {
        let stack: UIStackView = UIStackView.construct()
        stack.axis = .horizontal
        stack.backgroundColor = .white
        stack.layoutMargins = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        stack.isLayoutMarginsRelativeArrangement = true

        return stack
    }()
    
    private lazy var rolloverTitle: UILabel = {
        let label: UILabel = UILabel.construct()
        label.font = UIFont(name: AppFont.normal.rawValue, size: 15)
        label.textColor = UIColor(rgb: 0x515151)
        label.text = "Opsi Rollover"
        
        return label
    }()
    
    private lazy var rolloverOptionAction: UIButton = {
        let button: UIButton = UIButton.construct()
        button.setImage(UIImage(named: "rightArrow"), for: .normal)
        button.addTarget(self, action: #selector(selectRolloverOption), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var rolloverOptionTitle: UILabel = {
        let label: UILabel = UILabel.construct()
        label.font = UIFont(name: AppFont.normal.rawValue, size: 15)
        label.text = "Pokok"
        
        return label
    }()
    
    private lazy var rolloverOptionStack: UIStackView = {
        let stack: UIStackView = UIStackView.construct()
        stack.spacing = 16
        stack.axis = .horizontal
        
        return stack
    }()
    
    private lazy var rolloverOptionTable: UITableView = {
        let table: UITableView = UITableView.construct()
        table.separatorStyle = .singleLine
        table.separatorColor = .lightGray
        table.rowHeight = 136
        table.showsVerticalScrollIndicator = false
        table.isScrollEnabled = false
        table.allowsMultipleSelection = false
        table.dataSource = self
        table.delegate = self
        table.register(RolloverOptionCell.self, forCellReuseIdentifier: RolloverOptionCell.reusableIdentifier)
        
        return table
    }()
    
    private lazy var tncAction: UIButton = {
        let button: UIButton = UIButton.construct()
        button.setTitleColor(UIColor(rgb: 0x0085FF), for: .normal)
        button.addTarget(self, action: #selector(tapTnC), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var tncTitle: UILabel = {
        let label: UILabel = UILabel.construct()
        label.font = UIFont(name: AppFont.normal.rawValue, size: 13)
        label.text = "Saya telah membaca dan menyetujui"
        
        return label
    }()
    
    private lazy var tncCheckAction: DLRadioButton = {
        let button: DLRadioButton = DLRadioButton.construct()
        button.addTarget(self, action: #selector(self.tncChecked(_:)), for: .touchUpInside)
        button.iconSelected = UIImage(named: "checkmarkIcon") ?? UIImage()
        button.indicatorColor = .black
        button.iconColor = .black
        
        return button
    }()
    
    private lazy var nextAction: UIButton = {
        let button: UIButton = UIButton.construct()
        let titleAttribute: [NSAttributedString.Key : Any] = [
            NSAttributedString.Key.font : UIFont(name: AppFont.bold.rawValue, size: 17) ?? [:],
        ]
        let buttonTitle: NSMutableAttributedString = NSMutableAttributedString(
            string: "Buka Sekarang",
            attributes: titleAttribute
        )
        button.setAttributedTitle(buttonTitle, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(proceedNext), for: .touchUpInside)
        button.backgroundColor = UIColor(rgb: 0xFFD400)
        button.layer.cornerRadius = 20
        
        return button
    }()
    
    private lazy var tncStack: UIStackView = {
        let stack: UIStackView = UIStackView.construct()
        stack.axis = .horizontal
        stack.distribution = .equalCentering
        stack.alignment = .center
        stack.spacing = 4
        stack.layoutMargins = UIEdgeInsets(top: 16, left: 8, bottom: 16, right: 8)
        stack.isLayoutMarginsRelativeArrangement = true
        
        return stack
    }()
    
    private lazy var bottomStack: UIStackView = {
        let stack: UIStackView = UIStackView.construct()
        stack.axis = .vertical
        stack.spacing = 16
        stack.layoutMargins = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        stack.isLayoutMarginsRelativeArrangement = true
        
        return stack
    }()
    
    private lazy var topContentStack: UIStackView = {
        let stack: UIStackView = UIStackView.construct()
        stack.axis = .vertical
        stack.spacing = 16

        return stack
    }()
    
    private lazy var contentStack: UIStackView = {
        let stack: UIStackView = UIStackView.construct()
        stack.axis = .vertical
        stack.spacing = 24
        
        return stack
    }()
    
    private var isTnCChecked: Bool = false
    private let amountInputs: [String] = ["1000.000", "50.000.000", "100.000.000", "500.000.000"]
    private var rolloverOptions: [RolloverOptionCell.RolloverOption] = [RolloverOptionCell.RolloverOption(title: "Pokok", subtitle: "Bunga dikirim ke saldo aktif setelah jatuh tempo. Nilai pokok otomatis diperpanjang dengan jangka waktu deposito yang sama.", description: "Suku bunga saat ini akan dihitung berdasarkan \"suku bunga dasar + suku bunga tambahan\" dan suku bunga saat roll-over akan dihitung berdasarkan suku bunga yang berlaku di tanggal roll-over.", isSelected: true), RolloverOptionCell.RolloverOption(title: "Pokok + Bunga", subtitle: "Nilai pokok + bunga otomatis diperpanjang dengan jangka waktu deposito yang sama.", description: "Suku bunga saat ini akan dihitung berdasarkan \"suku bunga dasar + suku bunga tambahan\" dan suku bunga saat roll-over akan dihitung berdasarkan suku bunga yang berlaku di tanggal roll-over.", isSelected: false), RolloverOptionCell.RolloverOption(title: "Tidak Diperpanjang", subtitle: "Nilai pokok & bunga otomatis masuk ke saldo aktif setelah lewat jatuh tempo", description: "", isSelected: false)]

    init(viewModel: ProductDetailViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .lightGray.withAlphaComponent(0.1)

        setupPageHeader()
        setupUI()
        setupConstraint()
    }
    
    private func setupPageHeader() {
        let title: UILabel = UILabel()
        title.font = UIFont(name: AppFont.bold.rawValue, size: 16.0)
        title.text = ""
        
        let spacer = UIView()
        let constraint = spacer.widthAnchor.constraint(greaterThanOrEqualToConstant: CGFloat.greatestFiniteMagnitude)
        constraint.isActive = true
        constraint.priority = .defaultLow

        let stack = UIStackView(arrangedSubviews: [title, spacer])
        stack.axis = .horizontal

        navigationItem.titleView = stack
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.backgroundColor = .white
    }
    
    @objc func doneButtonAction(){
        amountField.resignFirstResponder()
    }
    
    @objc func tapTnC(sender: UIButton) {
        let webVC = SFSafariViewController(url: URL(string: "https://www.bankneocommerce.co.id/id/home")!)
        webVC.modalPresentationStyle = .overFullScreen

        present(webVC, animated: true, completion: nil)
    }
    
    @objc func selectRolloverOption(sender: UIButton) {
        let bottomSheet: Sheet = Sheet(frame: .zero)
        
        bottomSheet.tag = 1
        bottomSheet.setupView(with: rolloverOptionTable)
        bottomSheet.show(from: view)
        navigationController?.setNavigationBarHidden(true, animated: false)
        
        bottomSheet.onDismissed = {
            self.navigationController?.setNavigationBarHidden(false, animated: false)
        }
    }
    
    @objc func tncChecked(_ sender: UIButton) {
        isTnCChecked = !isTnCChecked
        tncCheckAction.isSelected = isTnCChecked
    }
    
    @objc func proceedNext(sender: UIButton) {
        
        if !isTnCChecked {
            let toast: Toast = Toast(frame: .zero)
            toast.showToast(message: "Setujui persyaratan terlebih dahulu", toastColor: .red, container: view)
        } else {
            onOpenPayment?(amountField.text ?? "")
        }
    }
    
    @objc func setAmount(sender: UIButton) {
        amountField.text = sender.currentTitle?.replacingOccurrences(of: "Rp", with: "")
    }
    
    private func setupUI() {
        productName.text = viewModel.product.productName
        let interestAttribute: [NSAttributedString.Key : Any] = [
            NSAttributedString.Key.font : UIFont(name: AppFont.bold.rawValue, size: 17) ?? [:],
            NSAttributedString.Key.foregroundColor : UIColor(rgb: 0x0EBE5A)

        ]
        let interestSuffixAttribute: [NSAttributedString.Key : Any] = [
            NSAttributedString.Key.font : UIFont(name: AppFont.bold.rawValue, size: 14) ?? [:],
            NSAttributedString.Key.foregroundColor : UIColor(rgb: 0x0EBE5A)
        ]
        let interestModified: NSMutableAttributedString = NSMutableAttributedString(
            string: "\(viewModel.product.rate ?? 0)%",
            attributes: interestAttribute
        )
        let interestSuffixModified: NSMutableAttributedString = NSMutableAttributedString(
            string: " p.a",
            attributes: interestSuffixAttribute
        )
        
        interestModified.append(interestSuffixModified)
        
        interest.attributedText = interestModified
                
        if let code = viewModel.product.code {
            let durationSuffix: String = viewModel.timeContext.rawValue
            duration.text = "\(code.digits) \(durationSuffix)"
        }
        
        topMiddleStack.addArrangedSubviews(interest, duration)
        topStack.addArrangedSubviews(productName, topMiddleStack, topDescription)
        
        let formattedAmount: String = "\(viewModel.product.startingAmount ?? 0)".currencyFormatting()
        amountField.text = formattedAmount.replacingOccurrences(of: ",00", with: "")
        minAmount.text = "Minimum deposito \(formattedAmount)".replacingOccurrences(of: ",00", with: "")
        
        let dueDatePrefixAttribute: [NSAttributedString.Key : Any] = [
            NSAttributedString.Key.font : UIFont(name: AppFont.normal.rawValue, size: 14) ?? [:],
            NSAttributedString.Key.foregroundColor : UIColor(rgb: 0x515151)

        ]
        let dueDateAttribute: [NSAttributedString.Key : Any] = [
            NSAttributedString.Key.font : UIFont(name: AppFont.normal.rawValue, size: 14) ?? [:]
        ]
        let dueDatePrefix: NSMutableAttributedString = NSMutableAttributedString(
            string: "Jatuh Tempo:",
            attributes: dueDatePrefixAttribute
        )
        let dueDateModified: NSMutableAttributedString = NSMutableAttributedString(
            string: viewModel.calculateDueDate(),
            attributes: dueDateAttribute
        )
        
        dueDatePrefix.append(dueDateModified)
        
        dueDate.attributedText = dueDatePrefix
        
        innerMiddleStack.addArrangedSubviews(amountTitle, amountField, minAmount, amountSection, dueDate)

        interestAmount.text = "Rp \(viewModel.calculateInterest(with: viewModel.product.startingAmount ?? 0, rate: Float(viewModel.product.rate ?? 0)))"
        
        interestAmountStack.addArrangedSubviews(interestAmountTitle, interestAmount)
        middleStack.addArrangedSubviews(amountTitle, innerMiddleStack, separatorLine, interestAmountStack)
        rolloverOptionStack.addArrangedSubviews(rolloverOptionTitle, rolloverOptionAction)
        rolloverStack.addArrangedSubviews(rolloverTitle, rolloverOptionStack)
        topContentStack.addArrangedSubviews(topStack, middleStack, rolloverStack)
        
        let tncActionTitleAttribute: [NSAttributedString.Key : Any] = [
            NSAttributedString.Key.font : UIFont(name: AppFont.bold.rawValue, size: 13) ?? [:],
        ]
        let tncActionTitle: NSMutableAttributedString = NSMutableAttributedString(
            string: "<<\(viewModel.product.productName?.components(separatedBy: " ")[0] ?? "") \(viewModel.product.productName?.components(separatedBy: " ")[1] ?? "") TnC>>",
            attributes: tncActionTitleAttribute
        )
        tncAction.setAttributedTitle(tncActionTitle, for: .normal)
        tncCheckAction.layer.cornerRadius = min(tncCheckAction.bounds.size.height, tncCheckAction.bounds.size.width) / 2
        tncStack.addArrangedSubviews(tncCheckAction, tncTitle, tncAction)
        tncStack.addArrangedSubviews(tncTitle, tncAction)
        bottomStack.addArrangedSubviews(nextAction, tncStack)
        contentStack.addArrangedSubviews(topContentStack, bottomStack)
        
        view.addSubviews(contentStack)
    }
    
    private func setupConstraint() {
        NSLayoutConstraint.activate([
            rolloverOptionAction.heightAnchor.constraint(equalToConstant: 14),
            rolloverOptionAction.widthAnchor.constraint(equalToConstant: 14),
            nextAction.heightAnchor.constraint(equalToConstant: 40),
            tncCheckAction.heightAnchor.constraint(equalToConstant: 16),
            tncCheckAction.widthAnchor.constraint(equalToConstant: 16),
            amountSection.heightAnchor.constraint(equalToConstant: 60),
            contentStack.topAnchor.constraint(equalTo: view.safeTopAnchor),
            contentStack.leadingAnchor.constraint(equalTo: view.safeLeadingAnchor),
            contentStack.trailingAnchor.constraint(equalTo: view.safeTrailingAnchor),
            view.bottomAnchor.constraint(equalTo: contentStack.bottomAnchor, constant: 16)
        ])
    }
    
    private func setBackgroundColor(with stacks: UIStackView...) {
        stacks.forEach { stack in
            stack.backgroundColor = .white
        }
    }
}

extension ProductDetailViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = ""
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if let number = textField.text, number != "", Int(number) ?? 0 >= viewModel.product.startingAmount ?? 0 {
            textField.text = number.currencyFormatting().replacingOccurrences(of: ",00", with: "")
        } else {
            textField.text = "\(viewModel.product.startingAmount ?? 0)".currencyFormatting().replacingOccurrences(of: ",00", with: "")
        }
        
        interestAmount.text = "Rp \(viewModel.calculateInterest(with: Int(textField.text?.digits ?? "") ?? 0, rate: Float(viewModel.product.rate ?? 0)))"
    }
}

extension ProductDetailViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rolloverOptions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: RolloverOptionCell.reusableIdentifier, for: indexPath) as? RolloverOptionCell {
            cell.setupView(with: rolloverOptions[indexPath.row])
            cell.selectionStyle = .none
            cell.onSelectOption = {
                
                DispatchQueue.main.async {
                    
                    if let bottomSheet = self.view.viewWithTag(1) as? Sheet {
                        bottomSheet.dismiss()
                        self.navigationController?.setNavigationBarHidden(false, animated: false)
                        
                        for (index, _) in self.rolloverOptions.enumerated() {
                            
                            if index == indexPath.row {
                                self.rolloverOptions[index].setSelected(isSelected: true)
                            } else {
                                self.rolloverOptions[index].setSelected(isSelected: false)
                            }
                            
                        }
                        
                        self.rolloverOptionTitle.text = self.rolloverOptions[indexPath.row].title
                    }
                }
            }
            
            return cell
        } else {
            return UITableViewCell()
        }
    }
}

extension ProductDetailViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let bottomSheet = self.view.viewWithTag(1) as? Sheet {
            bottomSheet.dismiss()
        }
        
        for (index, _) in self.rolloverOptions.enumerated() {
            
            if index == indexPath.row {
                self.rolloverOptions[index].setSelected(isSelected: true)
            } else {
                self.rolloverOptions[index].setSelected(isSelected: false)
            }
            
        }
        
        rolloverOptionTitle.text = rolloverOptions[indexPath.row].title
    }
}

extension ProductDetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        amountInputs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AmountCell.reusableIdentifier, for: indexPath) as? AmountCell {
            cell.setupView(amount: "Rp\(amountInputs[indexPath.row])")
            
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
}

extension ProductDetailViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        //let width: CGFloat = "Rp\(amountInputs[indexPath.item])".size(withAttributes: nil).width
        
        return CGSize(width: 112, height: 28)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        amountField.text = amountInputs[indexPath.row].digits.currencyFormatting().replacingOccurrences(of: ",00", with: "")
        interestAmount.text = "Rp \(viewModel.calculateInterest(with: Int(amountInputs[indexPath.row].digits) ?? 0, rate: Float(viewModel.product.rate ?? 0)))"
    }
}
