//
//  BAAPIRoute.swift
//  BanksApp
//
//  Created by René Sandoval on 16/05/23.
//

import Foundation

enum BAAPIRoute {
    /// Base API URL to create requests from
    static var baseURL = URL(staticString: "https://dev.obtenmas.com")
    static let apiURL: String = "/catom/api/challenge"

    case banksList
}

extension BAAPIRoute: Routable {
    /// The URL string of the combined URL
    var url: URL {
        let path: String = {
            switch self {
            case .banksList:
                return "\(BAAPIRoute.apiURL)/banks"
            }
        }()

        return URL(string: path, relativeTo: BAAPIRoute.baseURL)!
    }

    /// A dictionary of key, values to append to the HTTP request headers. Authentication should be included.
    var extraHTTPHeaders: [String: String] {
        var extraHeaders: [String: String] = [:]
        extraHeaders["Content-Type"] = "application/json"

        return extraHeaders
    }
}
