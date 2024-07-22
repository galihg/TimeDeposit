//
//  PaymentScreen.swift
//  TimeDeposit
//
//  Created by Kuncoro Galih Gemilang on 14/07/24.
//

import UIKit

final class PaymentScreen: Screen {
    
    var viewController: UIViewController?
    
    let amount: String
    
    init(amount: String) {
        self.amount = amount
    }
    
    func make() -> UIViewController {
        let paymentViewController: UIViewController = PaymentViewController(with: amount)
        
        viewController = paymentViewController
        
        return paymentViewController
    }
}
