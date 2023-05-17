//
//  BAUserDefaults.swift
//  BanksApp
//
//  Created by René Sandoval on 16/05/23.
//

import Foundation

final class BAUserDefaults {
    static func setData(value: some Any, key: BAUserDefaultKeys) {
        let defaults = UserDefaults.standard
        defaults.set(value, forKey: key.rawValue)
    }

    static func getData<T>(type: T.Type, forKey: BAUserDefaultKeys) -> T? {
        let defaults = UserDefaults.standard
        let value = defaults.object(forKey: forKey.rawValue) as? T
        return value
    }

    static func removeData(key: BAUserDefaultKeys) {
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: key.rawValue)
    }
}
