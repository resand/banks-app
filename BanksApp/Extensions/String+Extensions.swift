//
//  String+Extensions.swift
//  BanksApp
//
//  Created by René Sandoval on 16/05/23.
//

import Foundation

extension String {
    var first: String {
        String(prefix(1))
    }

    var uppercasedFirst: String {
        first.uppercased() + String(dropFirst())
    }

    func trim(to maximumCharacters: Int) -> String {
        "\(self[..<index(startIndex, offsetBy: maximumCharacters)])" + "..."
    }

    var isURL: Bool {
        do {
            let detector = try NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue)
            let matches = detector.matches(in: self, options: [], range: NSRange(location: 0, length: utf16.count))

            for match in matches {
                guard Range(match.range, in: self) != nil else { continue }
                return true
            }
        } catch {
            return false
        }

        return false
    }

    var isEmptyStr: Bool {
        trimmingCharacters(in: NSCharacterSet.whitespaces).isEmpty
    }
}
