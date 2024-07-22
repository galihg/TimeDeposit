//
//  Array+Extension.swift
//  TimeDeposit
//
//  Created by Kuncoro Galih Gemilang on 17/07/24.
//

import Foundation

extension Array {

    subscript (range r: ClosedRange<Int>) -> Array {
        return Array(self[r])
    }
    
    subscript (range r: Range<Int>) -> Array {
        return Array(self[r])
    }
}
