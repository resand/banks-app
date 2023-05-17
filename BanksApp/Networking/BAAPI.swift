//
//  BAAPI.swift
//  BanksApp
//
//  Created by René Sandoval on 17/05/23.
//

import CoreLocation

private let BARequestTimeout = 20.0

/// Main abstraction for requests to the API
enum BAAPI {
    /// This is the client in charge of handling all network operations.
    static let client: BAHTTPClient = {
        var configuration = URLSessionConfiguration.ephemeral
        configuration.timeoutIntervalForRequest = BARequestTimeout

        return BAHTTPClient(configuration: configuration)
    }()
}

extension BAAPI {
    static func banks(completion: @escaping (Result<[BankResponseModel], BAAPIError>) -> Void) {
        client.request(.get, BAAPIRoute.banksList) { responseObject, status in
            let responseError = responseObject as? NSDictionary
            let response = responseObject as? NSArray
            let error = BAAPIError(response: responseError, status: status) ?? .UnknownError
            let banks = response?.count ?? 0 >= 1 ? [BankResponseModel](json: response) : [BankResponseModel]()
            completion(Result(value: banks, failWith: error))
        }
    }
}
