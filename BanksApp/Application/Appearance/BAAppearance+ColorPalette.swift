//
//  BAAppearance+ColorPalette.swift
//  BanksApp
//
//  Created by René Sandoval on 16/05/23.
//

import UIKit

extension BAAppearance {
    struct ColorPalette {
        public var splashBackground: UIColor = .mainBackground
        public var mainBackground: UIColor = .baseBackground
    }
}

private extension UIColor {
    static let mainBackground = mode(BAConstants.Colors.baseBackground, BAConstants.Colors.baseBackgroundDark)
    static let baseBackground = mode(0xFFFFFF, BAConstants.Colors.mainBackgroundDark)

    static func mode(_ light: Int, lightAlpha: CGFloat = 1.0, _ dark: Int, darkAlpha: CGFloat = 1.0) -> UIColor {
        if #available(iOS 13.0, *) {
            return UIColor { traitCollection in
                traitCollection.userInterfaceStyle == .dark
                    ? UIColor(rgb: dark).withAlphaComponent(darkAlpha)
                    : UIColor(rgb: light).withAlphaComponent(lightAlpha)
            }
        } else {
            return UIColor(rgb: light).withAlphaComponent(lightAlpha)
        }
    }
}
