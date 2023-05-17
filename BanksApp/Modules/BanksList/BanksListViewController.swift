//
//  BanksListViewController.swift
//  BanksApp
//
//  Created by René Sandoval on 16/05/23.
//
//

import UIKit

// MARK: BanksListViewController Class

final class BanksListViewController: UserInterface {
    private lazy var banksListView: BanksListView = BanksListView().withoutAutoresizingMaskConstraints

    override func setup() {
        banksListView.delegate = self
    }
    
    override func setupLayout() {
        view.embed(banksListView)
    }
}

// MARK: - BanksListViewController Interface

extension BanksListViewController: BanksListViewInterface {
    func serviceFailure(messageError: String) {
        if messageError == BAConstants.Errors.network {
            BAConfiguration.shared.app.showErrorAlert("No available internet connection found ☹️", viewController: self) {
                self.presenter.getBanks()
            }
        }
    }
    
    func banksLoaded(banks: [Bank]) {
        banksListView.setData(banks: banks)
    }
}

// MARK: - BanksListViewController Viper Components Interface

private extension BanksListViewController {
    var presenter: BanksListPresenterInterface {
        return _presenter as! BanksListPresenterInterface
    }

    var displayData: BanksListDisplayData {
        return _displayData as! BanksListDisplayData
    }
}

// MARK: - Delegate BanksListView

extension BanksListViewController: BanksListViewDelegate {
    func refreshTableView() {
        presenter.refreshBanks()
    }
}
