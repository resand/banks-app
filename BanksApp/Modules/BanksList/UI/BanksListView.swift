//
//  BanksListView.swift
//  BanksApp
//
//  Created by René Sandoval on 17/05/23.
//

import UIKit

final class BanksListView: BAView {
    private var tableViewBanks: UITableView = UITableView().withoutAutoresizingMaskConstraints
    private let refreshControl = UIRefreshControl().withoutAutoresizingMaskConstraints

    private var banks: [Bank] = []

    weak var delegate: BanksListViewDelegate?

    public func setData(banks: [Bank]) {
        self.banks.removeAll()
        self.banks = banks

        tableViewBanks.reloadData()

        if refreshControl.isRefreshing {
            refreshControl.endRefreshing()
        }

        [tableViewBanks].forEach { $0?.isHidden = false }

        BAAnimation { self.layoutIfNeeded() }
    }

    override func setup() {
        setupTableViewBanks()
    }

    override func setupAppearance() {
        backgroundColor = .white
    }

    override func setupLayout() {
        addSubview(tableViewBanks)
        tableViewBanks.addSubview(refreshControl)

        NSLayoutConstraint.activate([
            tableViewBanks.topAnchor.pin(equalTo: topAnchor, constant: 20),
            tableViewBanks.leadingAnchor.pin(equalTo: leadingAnchor, constant: 20),
            tableViewBanks.trailingAnchor.pin(equalTo: trailingAnchor, constant: -20),
            tableViewBanks.bottomAnchor.pin(equalTo: safeBottomAnchor),
        ])
    }
}

// MARK: Private methods

extension BanksListView {
    @objc private func refresh() {
        delegate?.refreshTableView()
    }
}

// MARK: Setup Views

extension BanksListView {
    private func setupTableViewBanks() {
        tableViewBanks.isHidden = true
        tableViewBanks.separatorStyle = .none
        tableViewBanks.register(BankTableViewCell.self, forCellReuseIdentifier: BankTableViewCell.id)
        tableViewBanks.showsHorizontalScrollIndicator = false
        tableViewBanks.showsVerticalScrollIndicator = false
        tableViewBanks.dataSource = self
        tableViewBanks.delegate = self

        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
    }
}

// MARK: UITableView

extension BanksListView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return banks.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BankTableViewCell.id, for: indexPath) as? BankTableViewCell else {
            fatalError("Could not cast BankTableViewCell")
        }

        cell.setup(bank: banks[indexPath.row])
        return cell
    }
}

extension BanksListView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}

// MARK: - Delegate Contacts

protocol BanksListViewDelegate: AnyObject {
    func refreshTableView()
}
