//
//  BanksListInteractor.swift
//  BanksApp
//
//  Created by René Sandoval on 16/05/23.
//
//

import Foundation

// MARK: - BanksListInteractor Class

final class BanksListInteractor: Interactor {
}

// MARK: - BanksListInteractor Interface

extension BanksListInteractor: BanksListInteractorInterface {
}

// MARK: - Interactor Viper Components Interface

private extension BanksListInteractor {
    var presenter: BanksListPresenterInterface {
        return _presenter as! BanksListPresenterInterface
    }
}
