//
//  BanksListRouter.swift
//  BanksApp
//
//  Created by René Sandoval on 16/05/23.
//
//

import Foundation

// MARK: - BanksListRouter class

final class BanksListRouter: Router {
}

// MARK: - BanksListRouter Interface

extension BanksListRouter: BanksListRouterInterface {
}

// MARK: - BanksList Viper Components

private extension BanksListRouter {
    var presenter: BanksListPresenterInterface {
        return _presenter as! BanksListPresenterInterface
    }
}
