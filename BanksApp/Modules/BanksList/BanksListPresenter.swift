//
//  BanksListPresenter.swift
//  BanksApp
//
//  Created by René Sandoval on 16/05/23.
//
//

import Foundation

// MARK: - BanksListPresenter Class

final class BanksListPresenter: Presenter {
    
}

// MARK: - BanksListPresenter Interface

extension BanksListPresenter: BanksListPresenterInterface {
}

// MARK: - BanksList Viper Components

private extension BanksListPresenter {
    var view: BanksListViewInterface {
        return _view as! BanksListViewInterface
    }

    var interactor: BanksListInteractorInterface {
        return _interactor as! BanksListInteractorInterface
    }

    var router: BanksListRouterInterface {
        return _router as! BanksListRouterInterface
    }
}
