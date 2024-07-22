//
//  WealthCoordinator.swift
//  TimeDeposit
//
//  Created by Kuncoro Galih Gemilang on 13/07/24.
//

import Foundation

final class ProductCoordinator: Coordinator {
    
    var screen: Screen = ProductScreen(viewModel: ProductViewModel())
    private var router: Navigation = Router.shared
    
    func startCoordinator() {
        router.show(view: screen, style: .push)
        
        if let viewController = screen.viewController as? ProductViewController {
            viewController.onOpenProduct = { product in
                self.screen = ProductDetailScreen(viewModel: ProductDetailViewModel(product: product))
                
                DispatchQueue.main.async {
                    Router.shared.show(view: self.screen, style: .push)
                    self.observeProductDetail()
                }
            }
        }
    }
    
    private func observeProductDetail() {
        
        if let viewController = screen.viewController as? ProductDetailViewController {
            viewController.onOpenPayment = { amount in
                
                DispatchQueue.main.async {
                    PaymentCoordinator(amount: amount).startCoordinator()
                }
            }
        }
    }
}
