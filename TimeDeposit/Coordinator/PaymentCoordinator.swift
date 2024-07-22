//
//  PaymentCoordinator.swift
//  TimeDeposit
//
//  Created by Kuncoro Galih Gemilang on 18/07/24.
//

import Foundation

final class PaymentCoordinator: Coordinator {
    
    var screen: Screen
    private var router: Navigation = Router.shared
    
    init(amount: String) {
        self.screen = PaymentScreen(amount: amount)
    }
    
    func startCoordinator() {
        router.show(view: screen, style: .push)
    }
}
