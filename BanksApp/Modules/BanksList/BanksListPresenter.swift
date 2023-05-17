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
    override func viewHasLoaded() {
        getBanks()
    }
}

// MARK: - BanksListPresenter Interface

extension BanksListPresenter: BanksListPresenterInterface {
    func banksLoaded(banks: [Bank]) {
        view.stopLoading()
        view.banksLoaded(banks: banks)
    }
    
    func getBanks() {
        view.startLoading()
        interactor.getBanks()
    }
    
    func refreshBanks() {
        view.startLoading()
        interactor.refreshBanks()
    }
    
    func requestError(message: String) {
        view.serviceFailure(messageError: message)
    }
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
