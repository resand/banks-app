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
    private var banks: [BankResponseModel] = []
}

// MARK: - BanksListInteractor Interface

extension BanksListInteractor: BanksListInteractorInterface {
    func getBanks() {
        let banks: [Bank] = BAORM.getAll(entityClass: Bank.self, sortDescriptors: [BAConstants.Database.Sorts.name])

        if banks.isEmpty {
            banksRequest()
        } else {
            presenter.banksLoaded(banks: banks)

            guard BAConfiguration.shared.logLevel == .debug else { return }
            logInfo("CoreData items: Banks")
            banks.forEach { print($0.bankName ?? "") }
        }
    }

    func refreshBanks() {
        BAORM.resetAll()
        getBanks()
    }

    private func banksRequest() {
        checkConnection {
            BAAPI.banks { [self] result in
                if result.error != nil {
                    presenter.requestError(message: result.error?.message ?? "")
                }

                banks = result.value ?? []

                logInfo("Requests banks completed ✅")
                self.banks.forEach {
                    let bank = BAORM.newObject(entityClass: Bank.self)
                    bank.bankName = $0.bankName
                    bank.bankDescription = $0.bankDescription
                    bank.bankImage = $0.bankImage
                    BAORM.saveObject()
                }
                self.getBanks()
            }
        } ifOffline: { [self] in
            presenter.requestError(message: BAConstants.Errors.network)
        }
    }
}

// MARK: - Interactor Viper Components Interface

private extension BanksListInteractor {
    var presenter: BanksListPresenterInterface {
        return _presenter as! BanksListPresenterInterface
    }
}
