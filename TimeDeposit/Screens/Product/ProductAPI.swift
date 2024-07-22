//
//  NewsAPI.swift
//  NewsReader
//
//  Created by Kuncoro Galih Gemilang on 12/06/24.
//

import Foundation

enum ProductAPI: APIData {
    
    case getProducts
    
    var path: String {
        switch self {
        case .getProducts:
            return "interview/deposits/list"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        default:
            return .get
        }
    }
    
    var parameters: RequestParams {
        switch self {
        case .getProducts:
            return RequestParams(urlParameters: nil, bodyParameters: nil)
        }
    }
    
    var headers: [String : String]? {
        return nil
    }
    
    var dataType: ResponseDataType {
        switch self {
        case .getProducts:
            return .Data
        }
    }
}
