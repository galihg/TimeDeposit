//
//  WealthScreen.swift
//  TimeDeposit
//
//  Created by Kuncoro Galih Gemilang on 12/07/24.
//

import UIKit

final class ProductScreen: Screen {
    
    var viewController: UIViewController?
    var viewModel: ProductViewModel

    init(viewModel: ProductViewModel) {
        self.viewModel = viewModel
    }
    
    func make() -> UIViewController {
        let productViewController: UIViewController = ProductViewController(viewModel: viewModel)
        
        viewController = productViewController
        
        return productViewController
    }
}
