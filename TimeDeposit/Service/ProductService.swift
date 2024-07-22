//
//  ProductService.swift
//  TimeDeposit
//
//  Created by Kuncoro Galih Gemilang on 12/07/24.
//

import Foundation

protocol ProductServiceable {
    func fetchProducts(completionHandler: @escaping ([ProductBase]) -> Void)
}

final class ProductService: ProductServiceable {
    
    private let apiClient: APIClientProtocol
    
    init(apiClient: APIClientProtocol = APIClient()) {
        self.apiClient = apiClient
    }
    
    func fetchProducts(completionHandler: @escaping ([ProductBase]) -> Void) {
        apiClient.fetch(request: ProductAPI.getProducts, basePath: "https://60c18a34-89cf-4554-b241-cd3cdfcc93ff.mock.pstmn.io/", keyDecodingStrategy: .useDefaultKeys, completionHandler: { (response: Result<TimeDeposit<[ProductBase]>, NetworkError>) in
            
            switch response {
            case .success(let result):
                
                if let products = result.data {
                    completionHandler(products)
                } else {
                    print(NetworkError.noResponseData)
                }
            case .failure(let error):
                print(error)
            }
        })
    }
}
