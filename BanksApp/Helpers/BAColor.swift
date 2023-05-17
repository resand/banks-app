//
//  BAColor.swift
//  BanksApp
//
//  Created by René Sandoval on 16/05/23.
//

import Foundation
import UIKit

public struct BAColor {
    public let light: UIColor
    public let dark: UIColor?

    public var dynamicColor: UIColor {
        if #available(iOS 13.0, *) {
            return UIColor { traitcollection in
                let darkModeEnabled = BAUserDefaults.getData(type: Bool.self, forKey: .darkModeEnabled) ?? false

                if darkModeEnabled {
                    return self.dark ?? self.light
                } else {
                    if traitcollection.userInterfaceStyle == .dark {
                        return self.dark ?? self.light
                    } else {
                        return self.light
                    }
                }
            }
        } else {
            return light
        }
    }

    public init(light: UIColor, dark: UIColor?) {
        self.light = light
        self.dark = dark
    }
}
