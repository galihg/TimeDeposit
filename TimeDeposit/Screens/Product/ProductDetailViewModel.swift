//
//  ProductDetailViewModel.swift
//  TimeDeposit
//
//  Created by Kuncoro Galih Gemilang on 14/07/24.
//

import Foundation

final class ProductDetailViewModel {
    
    enum TimeContext: String {
        case day = "hari"
        case month = "bulan"
        case year = "tahun"
    }
    
    let product: Product
    let timeContext: TimeContext
    
    init(product: Product) {
        self.product = product
        
        if let code = product.code {

            if code.contains("M") {
                timeContext = .month
            } else if code.contains("D") {
                timeContext = .day
            } else {
                timeContext = .year
            }
        } else {
            timeContext = .month
        }
    }
    
    func calculateInterest(with amount: Int, rate: Float) -> String {
        return String(format:"%.2f", rate/100 * Float(amount) / 12).replacingOccurrences(of: ".", with: ",")
    }
    
    func calculateDueDate() -> String {
        
        if let code = product.code {
            let component: Calendar.Component
            
            switch timeContext {
            case .day:
                component = .day
            case .month:
                component = .month
            case .year:
                component = .year
            }
            
            let formatter: DateFormatter = DateFormatter()
            formatter.dateFormat = "dd/MM/yyyy"
            return formatter.string(
                from: Date().noon().adding(
                    component,
                    value: Int(code.digits) ?? 0
                )
            )
        } else {
            return ""
        }
    }
}
