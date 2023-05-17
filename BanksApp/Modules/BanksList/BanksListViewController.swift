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
    override func setup() {
        view.backgroundColor = .systemGreen
    }
    
    override func setupAppearance() {
        
    }
    
    override func setupLayout() {
        
    }
}

// MARK: - BanksListViewController Interface

extension BanksListViewController: BanksListViewInterface {
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
