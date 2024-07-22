//
//  Wealth.swift
//  TimeDeposit
//
//  Created by Kuncoro Galih Gemilang on 12/07/24.
//

struct TimeDeposit<T: Codable>: Codable {
    let data: T?
}

struct ProductBase: Codable {
    let productList: [Product]?
    let productGroupName: String?
}

struct Product: Codable {
    let rate: Int?
    let code: String?
    let marketingPoints: [String]?
    let productName: String?
    let startingAmount: Int?
    let isPopular: Bool?
}
