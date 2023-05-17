//
//  BankListResponseModel.swift
//  BanksApp
//
//  Created by René Sandoval on 17/05/23.
//

import Foundation

struct BankResponseModel {
    let bankName: String
    let bankDescription: String
    let bankImage: String
}

extension BankResponseModel: JSONMappable {
    init?(json: NSDictionary) {
        guard let bankName = json["bankName"] as? String,
              let bankDescription = json["description"] as? String,
              let bankImage = json["url"] as? String else {
            return nil
        }

        self.bankName = bankName
        self.bankDescription = bankDescription
        self.bankImage = bankImage
    }
}
