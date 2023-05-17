//
//  BAAppearance+Fonts.swift
//  BanksApp
//
//  Created by René Sandoval on 16/05/23.
//

import UIKit.UIFont

extension BAAppearance {
    struct Fonts {
        public var title = UIFont.preferredFont(forTextStyle: .title1).bold
        public var headline = UIFont.preferredFont(forTextStyle: .headline)
        public var headlineBold = UIFont.preferredFont(forTextStyle: .headline).bold
    }
}
