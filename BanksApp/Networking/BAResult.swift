//
//  BAResult.swift
//  BanksApp
//
//  Created by René Sandoval on 16/05/23.
//

extension Result {
    /// Create a result with the possible value, or error.
    ///
    /// - parameter value: The value to use with the successful case if it exists.
    /// - parameter error: The error closure to use as the failure case if the value doesn't exist.
    init(value: Success?, failWith error: @autoclosure () -> Failure) {
        if let value {
            self = .success(value)
        } else {
            self = .failure(error())
        }
    }

    /// The value if the result is `success`, otherwise nil.
    public var value: Success? {
        switch self {
        case let .success(value):
            return value
        case .failure:
            return nil
        }
    }

    /// The error if the value is `failure`, otherwise nil.
    public var error: Failure? {
        switch self {
        case .success:
            return nil
        case let .failure(error):
            return error
        }
    }
}
