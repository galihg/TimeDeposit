//
//  WealthViewModel.swift
//  TimeDeposit
//
//  Created by Kuncoro Galih Gemilang on 12/07/24.
//

import Foundation

final class ProductViewModel {
    
    enum ProductType: String {
        case flexible = "Flexible"
        case fixed = "Fixed Income"
    }
    
    let service: ProductServiceable
    
    var products: [ProductBase] = []
    var currentProducts: Array<Product> = []
    private var loadCounter: Int = 0
    private var maxLoad: Int = 3
    
    init(service: ProductServiceable = ProductService()) {
        self.service = service
    }
    
    func getProducts(completion: (() -> Void)?) {
        service.fetchProducts { [weak self] list in
            self?.products.append(contentsOf: list)
            completion?()
        }
    }
    
    func loadProducts(groupName: String) {
        
        if let productsContent = products.filter({ $0.productGroupName == groupName })[0].productList {
            
            if productsContent.count - currentProducts.count < maxLoad {
                currentProducts.append(contentsOf: productsContent[range: loadCounter..<loadCounter + productsContent.count - currentProducts.count])
            } else {
                currentProducts.append(contentsOf: productsContent[range: loadCounter..<loadCounter + maxLoad])
                loadCounter += maxLoad
            }
        }
    }

    func changeProduct(groupName: String) {
        loadCounter = 0
        currentProducts = []
        
        if let productsContent = products.filter({ $0.productGroupName == groupName })[0].productList {
            currentProducts = productsContent[range: loadCounter..<maxLoad]
            loadCounter += maxLoad
        }
    }
    
    func reloadNextContent(currentIndex: Int, groupName: String) -> Bool {
        
        if currentIndex == currentProducts.count - 2, let productsContent = products.filter({ $0.productGroupName == groupName })[0].productList, currentProducts.count < productsContent.count {
            return true
        } else {
            return false
        }
    }
}
