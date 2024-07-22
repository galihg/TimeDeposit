//
//  ProductDetailScreen.swift
//  TimeDeposit
//
//  Created by Kuncoro Galih Gemilang on 14/07/24.
//

import UIKit

final class ProductDetailScreen: Screen {
    
    var viewController: UIViewController?
    var viewModel: ProductDetailViewModel

    init(viewModel: ProductDetailViewModel) {
        self.viewModel = viewModel
    }
    
    func make() -> UIViewController {
        let productDetailViewController: UIViewController = ProductDetailViewController(viewModel: viewModel)
        
        viewController = productDetailViewController
        
        return productDetailViewController
    }
}
