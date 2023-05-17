//
//  BanksListInterface.swift
//  BanksApp
//
//  Created by René Sandoval on 16/05/23.
//
//

// MARK: - BanksListRouter Interface

protocol BanksListRouterInterface: RouterProtocol {
}

// MARK: - BanksListView Interface

protocol BanksListViewInterface: UserInterfaceProtocol {
    func startLoading()
    func stopLoading()
    func serviceFailure(messageError: String)
    func banksLoaded(banks: [Bank])
}

// MARK: - BanksListPresenter Interface

protocol BanksListPresenterInterface: PresenterProtocol {
    func requestError(message: String)
    func banksLoaded(banks: [Bank])
    
    func getBanks()
    func refreshBanks()
}

// MARK: - BanksListInteractor Interface

protocol BanksListInteractorInterface: InteractorProtocol {
    func getBanks()
    func refreshBanks()
}
