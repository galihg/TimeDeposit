//
//  Date+Extension.swift
//  TimeDeposit
//
//  Created by Kuncoro Galih Gemilang on 15/07/24.
//

import Foundation

extension Date {
    
    func noon(using calendar: Calendar = .current) -> Date {
        calendar.date(bySettingHour: 12, minute: 0, second: 0, of: self)!
    }
    
    func day(using calendar: Calendar = .current) -> Int {
        calendar.component(.day, from: self)
    }
    
    func adding(_ component: Calendar.Component, value: Int, using calendar: Calendar = .current) -> Date {
        calendar.date(byAdding: component, value: value, to: self)!
    }
    
    func monthSymbol(using calendar: Calendar = .current) -> String {
        calendar.monthSymbols[calendar.component(.month, from: self)-1]
    }
}
