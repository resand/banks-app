//
//  BankTableViewCell.swift
//  BanksApp
//
//  Created by René Sandoval on 17/05/23.
//

import UIKit

class BankTableViewCell: UITableViewCell {
    static let id = "BankTableViewCell"

    lazy var bankImageView: UIImageView = UIImageView().withoutAutoresizingMaskConstraints
    lazy var bankNameLabel: UILabel = UILabel().withoutAutoresizingMaskConstraints
    lazy var bankDescriptionLabel: UILabel = UILabel().withoutAutoresizingMaskConstraints

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        selectionStyle = .none
        backgroundColor = .clear

        contentView.backgroundColor = .white
        backgroundColor = .white
        setupLayoutViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5))
        contentView.roundCorners()

        contentView.layer.shadowColor = UIColor.darkText.withAlphaComponent(0.8).cgColor
        contentView.layer.shadowOffset = CGSize(width: 0, height: 1.5)
        contentView.layer.shadowOpacity = 0.5
        contentView.layer.shadowRadius = 4.0
        contentView.layer.masksToBounds = false
        contentView.layer.cornerRadius = 12.5
    }

    func setupLayoutViews() {
        [bankImageView, bankNameLabel, bankDescriptionLabel].forEach(contentView.addSubview)

        NSLayoutConstraint.activate([
            bankImageView.topAnchor.pin(equalTo: contentView.topAnchor, constant: 7.5),
            bankImageView.centerXAnchor.pin(equalTo: contentView.centerXAnchor),
            bankImageView.widthAnchor.pin(equalToConstant: 80),
            bankImageView.heightAnchor.pin(equalToConstant: 80),

            bankNameLabel.topAnchor.pin(equalTo: bankImageView.bottomAnchor, constant: 10),
            bankNameLabel.centerXAnchor.pin(equalTo: contentView.centerXAnchor, constant: -9),
            bankNameLabel.leadingAnchor.pin(equalTo: contentView.leadingAnchor, constant: 10),
            bankNameLabel.trailingAnchor.pin(equalTo: contentView.trailingAnchor, constant: -10),
            bankNameLabel.widthAnchor.pin(equalToConstant: frame.size.width - 170),

            bankDescriptionLabel.topAnchor.pin(equalTo: bankNameLabel.bottomAnchor, constant: 5),
            bankDescriptionLabel.centerXAnchor.pin(equalTo: contentView.centerXAnchor, constant: 9),
            bankDescriptionLabel.leadingAnchor.pin(equalTo: contentView.leadingAnchor, constant: 10),
            bankDescriptionLabel.trailingAnchor.pin(equalTo: contentView.trailingAnchor, constant: -10),
            bankDescriptionLabel.widthAnchor.pin(equalToConstant: 25),
        ])
    }

    func setup(bank: Bank) {
        bankImageView.setImage(with: bank.bankImage ?? "")
        bankImageView.contentMode = .scaleAspectFill

        bankNameLabel.text = bank.bankName
        bankNameLabel.textColor = .darkText
        bankNameLabel.textAlignment = .center
        bankNameLabel.font = BAAppearance.shared.fonts.title
        bankNameLabel.frame.size = bankNameLabel.intrinsicContentSize

        bankDescriptionLabel.numberOfLines = 0
        bankDescriptionLabel.text = bank.bankDescription
        bankDescriptionLabel.textColor = .darkText
        bankDescriptionLabel.textAlignment = .center
        bankDescriptionLabel.font = BAAppearance.shared.fonts.headline
        bankDescriptionLabel.frame.size = bankDescriptionLabel.intrinsicContentSize
    }
}
