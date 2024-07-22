//
//  Screen.swift
//  TimeDeposit
//
//  Created by Kuncoro Galih Gemilang on 12/07/24.
//

import UIKit

protocol Screen {
    var viewController: UIViewController? { get }
    
    func make() -> UIViewController
}
