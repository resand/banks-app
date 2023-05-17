//
//  BAConfiguration.swift
//  BanksApp
//
//  Created by René Sandoval on 16/05/23.
//

final class BAConfiguration {
    static var shared = BAConfiguration()

    // MARK: Global Variables

    let app: BAAppProtocol = BAApp()
    var logLevel: BALogLevel = .info
}
