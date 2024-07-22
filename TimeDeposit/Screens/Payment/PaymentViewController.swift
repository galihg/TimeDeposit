//
//  PaymentViewController.swift
//  TimeDeposit
//
//  Created by Kuncoro Galih Gemilang on 14/07/24.
//

import UIKit

final class PaymentViewController: UIViewController {
    
    struct PaymentSection {
        let title: String
        var isOpened: Bool
        let options: [PaymentOptionCell.PaymentOption]
        var icons: [UIImage]
        
        init(title: String, isOpened: Bool = false, options: [PaymentOptionCell.PaymentOption], icons: [UIImage]) {
            self.title = title
            self.isOpened = isOpened
            self.options = options
            self.icons = icons
        }
    }
    
    private var paymentSections: [PaymentSection] = [PaymentSection]()
    
    private lazy var topStack: UIStackView = {
        let stack: UIStackView = UIStackView.construct()
        stack.axis = .vertical
        stack.alignment = .center
        stack.spacing = 16
        stack.backgroundColor = UIColor(patternImage: UIImage(named: "countdownBanner") ?? UIImage())
        stack.layoutMargins = UIEdgeInsets(top: 24, left: 16, bottom: 24, right: 16)
        stack.isLayoutMarginsRelativeArrangement = true
        
        return stack
    }()
    
    private lazy var countDown: UILabel = {
        let label: UILabel = UILabel.construct()
        label.font = UIFont(name: AppFont.normal.rawValue, size: 14)
        label.textColor = .brown
        label.layer.cornerRadius = 8
        label.layer.borderColor = UIColor.brown.cgColor
        label.layer.borderWidth = 1
        
        return label
    }()
    
    private lazy var paymentTable: UITableView = {
        let table: UITableView = UITableView.construct()
        table.separatorStyle = .singleLine
        table.estimatedRowHeight = 60
        table.bounces = false
        table.dataSource = self
        table.delegate = self
        table.showsVerticalScrollIndicator = false
        table.separatorColor = .lightGray
        table.register(PaymentOptionCell.self, forCellReuseIdentifier: PaymentOptionCell.reusableIdentifier)
        table.layer.cornerRadius = 8
        
        return table
    }()
    
    private lazy var amountTitle: UILabel = {
        let label: UILabel = UILabel.construct()
        label.font = UIFont(name: AppFont.bold.rawValue, size: 20)
        label.textColor = .brown
        
        return label
    }()
    
    private lazy var secureStack: UIStackView = {
        let stack: UIStackView = UIStackView.construct()
        stack.axis = .horizontal
        stack.spacing = 8
        
        return stack
    }()
    
    private lazy var secureTitle: UILabel = {
        let label: UILabel = UILabel.construct()
        label.font = UIFont(name: AppFont.bold.rawValue, size: 15)
        label.text = "Transaksimu aman dan terjaga"
        
        return label
    }()
    
    private lazy var secureIcon: UIImageView = {
        let icon: UIImageView = UIImageView.construct()
        icon.image = UIImage(named: "secureIcon")
        icon.contentMode = .scaleAspectFit
        
        return icon
    }()
    
    private lazy var paymentTitle: UILabel = {
        let label: UILabel = UILabel.construct()
        label.font = UIFont(name: AppFont.normal.rawValue, size: 14)
        label.text = "Metode Pembayaran"
        label.textColor = UIColor(rgb: 0x515151)
        
        return label
    }()
    
    private lazy var recommendationTitle: UILabel = {
        let label: UILabel = UILabel.construct()
        label.font = UIFont(name: AppFont.normal.rawValue, size: 14)
        label.text = " Rekomendasi "
        label.textColor = UIColor(rgb: 0xFFD400)
        label.layer.borderColor = UIColor(rgb: 0xFFD400).cgColor
        label.layer.cornerRadius = 4
        label.layer.borderWidth = 1
        
        return label
    }()
    
    private lazy var paymentStack: UIStackView = {
        let stack: UIStackView = UIStackView.construct()
        stack.axis = .horizontal
        stack.alignment = .leading
        stack.spacing = 8
        
        return stack
    }()
    
    private lazy var savingsStack: UIStackView = {
        let stack: UIStackView = UIStackView.construct()
        stack.axis = .horizontal
        stack.distribution = .equalSpacing
        
        return stack
    }()
    
    private lazy var middleStack: UIStackView = {
        let stack: UIStackView = UIStackView.construct()
        stack.axis = .vertical
        stack.spacing = 16
        stack.layer.cornerRadius = 8
        
        stack.backgroundColor = UIColor(patternImage: UIImage(named: "paymentBanner") ?? UIImage())
        stack.layoutMargins = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        stack.isLayoutMarginsRelativeArrangement = true
        
        return stack
    }()
    
    private lazy var savingsContent: UIStackView = {
        let stack: UIStackView = UIStackView.construct()
        stack.axis = .vertical
        stack.spacing = 8
        stack.distribution = .fillProportionally
        
        return stack
    }()
    
    private lazy var savingsTitle: UILabel = {
        let label: UILabel = UILabel.construct()
        label.font = UIFont(name: AppFont.bold.rawValue, size: 15)
        label.text = "Tabungan Reguler (4952)"
        
        return label
    }()
    
    private lazy var savingsSubtitle: UILabel = {
        let label: UILabel = UILabel.construct()
        label.font = UIFont(name: AppFont.normal.rawValue, size: 12)
        label.textColor = UIColor(rgb: 0x515151)
        label.text = "Saldo Aktif:Rp150.000,01"
        
        return label
    }()
    
    private lazy var paymentAction: UIButton = {
        let button: UIButton = UIButton.construct()
        button.setTitle("Bayar", for: .normal)
        button.titleLabel?.font = UIFont(name: AppFont.bold.rawValue, size: 15)
        button.setTitleColor(.brown, for: .normal)
        button.backgroundColor = UIColor(rgb: 0xFFD400)
        button.layer.cornerRadius = 16
        
        return button
    }()
    
    private lazy var otherPaymentTitle: UILabel = {
        let label: UILabel = UILabel.construct()
        label.font = UIFont(name: AppFont.bold.rawValue, size: 15)
        label.text = "Metode Pembayaran Lain"
        
        return label
    }()
    
    private let amount: String
    private var timer: Timer?
    private var totalTime = 86400
    
    init(with amount: String) {
        self.amount = amount
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .lightGray.withAlphaComponent(0.1)
        title = "Pembayaran"
        paymentSections = [
            PaymentSection(
                title: "Virtual Account",
                options: [
                    PaymentOptionCell.PaymentOption(title: "BCA Virtual Account", logo: UIImage(named: "bcaLogo") ?? UIImage()),
                    PaymentOptionCell.PaymentOption(title: "BRI Virtual Account", logo: UIImage(named: "briLogo") ?? UIImage()),
                    PaymentOptionCell.PaymentOption(title: "BNI Virtual Account", logo: UIImage(named: "bniLogo") ?? UIImage()),
                    PaymentOptionCell.PaymentOption(title: "Danamon Virtual Account", logo: UIImage(named: "danamonLogo") ?? UIImage()),
                    PaymentOptionCell.PaymentOption(title: "Permata Virtual Account", logo: UIImage(named: "permataLogo") ?? UIImage()),
                    PaymentOptionCell.PaymentOption(title: "CIMB Virtual Account", logo: UIImage(named: "cimbLogo") ?? UIImage())
            ],
                icons: [
                    UIImage(named: "walletIcon") ?? UIImage(),
                    UIImage(named: "arrowDown") ?? UIImage()
                ]
            )
        ]
        setupUI()
        setupConstraint()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        paymentTable.heightConstraint?.constant = CGFloat(paymentTable.contentSize.height)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        startTimer()
    }
    
    private func setupUI() {
        amountTitle.text = "\(amount)"
        
        secureStack.addArrangedSubviews(secureIcon, secureTitle)
        topStack.addArrangedSubviews(countDown, amountTitle, secureStack)
        paymentStack.addArrangedSubviews(paymentTitle, recommendationTitle, UIView())
        savingsContent.addArrangedSubviews(savingsTitle, savingsSubtitle)
        savingsStack.addArrangedSubviews(savingsContent, paymentAction)
        middleStack.addArrangedSubviews(paymentStack, savingsStack)
        view.addSubviews(topStack, middleStack, otherPaymentTitle, paymentTable)
    }
    
    private func setupConstraint() {
        NSLayoutConstraint.activate([
            secureIcon.heightAnchor.constraint(equalToConstant: 16),
            secureIcon.widthAnchor.constraint(equalToConstant: 16),
            savingsTitle.heightAnchor.constraint(equalToConstant: 16),
            savingsSubtitle.heightAnchor.constraint(equalToConstant: 12),
            paymentAction.heightAnchor.constraint(equalToConstant: 32),
            paymentAction.widthAnchor.constraint(equalToConstant: 64),
            topStack.topAnchor.constraint(equalTo: view.safeTopAnchor),
            topStack.leadingAnchor.constraint(equalTo: view.safeLeadingAnchor),
            topStack.trailingAnchor.constraint(equalTo: view.safeTrailingAnchor),
            middleStack.topAnchor.constraint(equalTo: topStack.bottomAnchor, constant: 16),
            middleStack.leadingAnchor.constraint(equalTo: view.safeLeadingAnchor, constant: 8),
            middleStack.trailingAnchor.constraint(equalTo: view.safeTrailingAnchor, constant: -8),
            otherPaymentTitle.topAnchor.constraint(equalTo: middleStack.bottomAnchor, constant: 16),
            otherPaymentTitle.leadingAnchor.constraint(equalTo: view.safeLeadingAnchor, constant: 16),
            otherPaymentTitle.trailingAnchor.constraint(equalTo: view.safeTrailingAnchor, constant: -16),
            paymentTable.topAnchor.constraint(equalTo: otherPaymentTitle.bottomAnchor, constant: 8),
            paymentTable.leadingAnchor.constraint(equalTo: view.safeLeadingAnchor, constant: 16),
            paymentTable.trailingAnchor.constraint(equalTo: view.safeTrailingAnchor, constant: -16),
            paymentTable.heightAnchor.constraint(equalToConstant: 700)
        ])
    }
    
    @objc func updateTimer() {
        countDown.text = "  Berakhir dalam \(timeFormatted(totalTime))  "
        
        if totalTime != 0 {
            totalTime -= 1
        } else {
            if let timer = self.timer {
                timer.invalidate()
                self.timer = nil
            }
        }
    }

    private func startTimer() {
       timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }

    private func timeFormatted(_ totalSeconds: Int) -> String {
        let seconds: Int = totalSeconds % 60
        let minutes: Int = (totalSeconds / 60) % 60
        let hours: Int = (totalSeconds / 3600) % 60
        
        return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    }
}

extension PaymentViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return paymentSections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let paymentSection: PaymentSection = paymentSections[section]
        
        return paymentSection.isOpened ? paymentSection.options.count + 1 : 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            tableView.register(PaymentSectionHeaderCell.self, forCellReuseIdentifier: PaymentSectionHeaderCell.reusableIdentifier)
            let cell = tableView.dequeueReusableCell(
                withIdentifier: PaymentSectionHeaderCell.reusableIdentifier,
                for: indexPath
            ) as? PaymentSectionHeaderCell
            
            cell?.setupView(section: paymentSections[indexPath.section])
            cell?.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: .greatestFiniteMagnitude)
            
            return cell ?? UITableViewCell()
        } else if indexPath.row == 1 {
            tableView.register(UITableViewCell.self, forCellReuseIdentifier: "descriptionCell")
            let cell = tableView.dequeueReusableCell(
                withIdentifier: "descriptionCell",
                for: indexPath
            )
            cell.textLabel?.text = "Kamu bisa bayar dengan kode virtual account dari salah satu bank di bawah. Jika nominal pembayaran lebih besar dari limit transfer satu kali bank yang dipilih, kamu dapat melakukan beberapa kali top up saldo ke Tabungan Reguler atau ke rekening Tabungan NOW kamu dan melanjutkan pembayaran menggunakan saldomu setelahnya."
            cell.textLabel?.font = UIFont(name: AppFont.normal.rawValue, size: 12)
            cell.textLabel?.textColor = UIColor(rgb: 0x515151)
            cell.textLabel?.numberOfLines = 0
            cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: .greatestFiniteMagnitude)

            return cell
        } else {
            let cell = tableView.dequeueReusableCell(
                withIdentifier: PaymentOptionCell.reusableIdentifier,
                for: indexPath
            ) as? PaymentOptionCell
            cell?.setupView(with: PaymentOptionCell.PaymentOption(title: paymentSections[indexPath.section].options[indexPath.row - 1].title, logo: paymentSections[indexPath.section].options[indexPath.row - 1].logo))
            
            return cell ?? UITableViewCell()
        }
    }
}

extension PaymentViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        paymentSections[indexPath.section].isOpened = !paymentSections[indexPath.section].isOpened
        
        if !paymentSections[indexPath.section].isOpened {
            paymentSections[indexPath.section].icons[1] = UIImage(named: "arrowDown") ?? UIImage()
        } else {
            paymentSections[indexPath.section].icons[1] = UIImage(named: "arrowUp") ?? UIImage()
        }
        
        tableView.reloadSections([indexPath.section], with: .none)
    }
}
