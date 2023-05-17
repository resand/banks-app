//
//  BAConstants.swift
//  BanksApp
//
//  Created by René Sandoval on 16/05/23.
//

import Foundation

enum BAConstants {
    enum Errors {
        static let network = "NETWORK_ERROR"
    }

    enum Animations {
        static let loader = "loader"
        static let splash = ["splash"]
    }

    enum Colors {
        static let baseBackground = 0xEEF2F8
        static let baseBackgroundDark = 0x1B1A21
        static let mainBackground = 0x480F54
        static let mainBackgroundDark = 0x1B1A21
    }

    enum Database {
        enum Sorts {
            static let name = NSSortDescriptor(key: "bankName", ascending: false)
        }
    }
}
