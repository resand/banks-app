//
//  BAEnums.swift
//  BanksApp
//
//  Created by René Sandoval on 16/05/23.
//

enum BALogLevel: Int {
    case none = 0
    case error = 1
    case info = 2
    case debug = 3
}

enum YRShadowLocation: String {
    case bottom
    case top
}

enum BAUserDefaultKeys: String, CaseIterable {
    case darkModeEnabled
}
