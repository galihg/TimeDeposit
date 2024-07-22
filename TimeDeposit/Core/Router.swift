//
//  Router.swift
//  TimeDeposit
//
//  Created by Kuncoro Galih Gemilang on 12/07/24.
//

import UIKit

enum ShowStyle {
    case push
    case present
}

protocol Navigation {
    var navigationController: UINavigationController { get set }
    
    func show(view: Screen, style: ShowStyle)
}

final class Router: Navigation {
    
    static let shared = Router()

    var navigationController: UINavigationController = UINavigationController()
        
    func show(view: Screen, style: ShowStyle) {
        
        switch style {
        case .push:
            navigationController.pushViewController(view.make(), animated: false)
        case .present:
            navigationController.present(view.make(), animated: true)
        }
    }
}
