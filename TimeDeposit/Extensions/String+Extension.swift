//
//  String+Extension.swift
//  TimeDeposit
//
//  Created by Kuncoro Galih Gemilang on 14/07/24.
//

import Foundation

extension String {
    var digits: String {
        return components(separatedBy: CharacterSet.decimalDigits.inverted)
            .joined()
    }
}

extension String
{
    static let customNumberFormatter = NumberFormatter()
    
    var doubleValue: Double? {
        String.customNumberFormatter.decimalSeparator = "."
        
        if let result =  String.customNumberFormatter.number(from: self) {
            return result.doubleValue
        } else {
            String.customNumberFormatter.decimalSeparator = ","
            
            if let result = String.customNumberFormatter.number(from: self) {
                return result.doubleValue
            }
        }
        
        return nil
    }
    
    func currencyFormatting() -> String {
        
        if let value = Double(self) {
            let formatter = NumberFormatter()
            formatter.numberStyle = .currency
            formatter.maximumFractionDigits = 2
            formatter.minimumFractionDigits = 2
            
            if let str = formatter.string(for: value) {
                return str
            }
        }
        
        return ""
    }
}
