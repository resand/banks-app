//
//  BAAPIError.swift
//  BanksApp
//
//  Created by René Sandoval on 16/05/23.
//

import Foundation

/// Generic error struct. It contains the message returned by the server and the reason for the error. When
/// `isUnprocessable` == false it means that the server returned an status code other than 422.
public struct BAAPIError: Error {
    /// The human readable error message from the server
    public let message: String?
    /// The error reason from the server
    public let reason: String
    /// The response status from the server
    public let status: ResponseType?

    /// Generic unknown error
    static let UnknownError = BAAPIError("unknown")
    /// Generic error
    static let GenericError = BAAPIError("Generic")

    /// Initialize a new instance of NovaAPIError.
    ///
    /// - parameter reason:     The error reason from the server
    /// - parameter message:    The error message from the server
    ///
    /// - returns: New instance of NovaAPIError.
    init(_ reason: String, message: String? = nil) {
        self.reason = reason
        self.message = message
        status = nil
    }

    /// Parses the error type from the server response and returns the instance that represents the first
    /// error.
    ///
    /// - parameter response:           The NSDictionary created from a JSON response.
    /// - parameter status:             The type defined by the status code (see the ResponseType enum for
    ///
    /// - returns: The newly created NovaAPIError instance representing the first error found.
    init?(response: NSDictionary?, status: ResponseType) {
        self.status = status

        if status == .succeed && response?["succeeded"] as? Bool ?? false {
            return nil
        }

        var errorMessage = "R.string.localizable.connectionError()"

        if let messages = response?["messages"] as? [String] {
            for message in messages {
                errorMessage = message
            }
        }

        reason = BAAPIError.GenericError.reason
        message = errorMessage
    }
}
