//
//  URL+StaticString.swift
//  BanksApp
//
//  Created by René Sandoval on 16/05/23.
//

import Foundation.NSURL

extension URL {
    /// Creates a URL from a static string.
    ///
    /// - warning: Only pass valid URLs, or else this will trap at runtime.
    ///
    /// - parameter staticString: valid URL string.
    init(staticString: StaticString) {
        // swiftlint:disable:next force_unwrapping
        self.init(string: String(describing: staticString))!
    }
}
