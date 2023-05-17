//
//  BAAppearance.swift
//  BanksApp
//
//  Created by René Sandoval on 16/05/23.
//

import Foundation

/// An object containing visual configuration for whole application.
struct BAAppearance {
    /// A color pallete to provide basic set of colors for the Views.
    ///
    /// By providing different object or changing individual colors, you can change the look of the views.
    public var colorPalette = ColorPalette()

    /// A set of fonts to be used in the Views.
    ///
    /// By providing different object or changing individual fonts, you can change the look of the views.
    public var fonts = Fonts()

    public init() {}
}

// MARK: - BAAppearance + shared

extension BAAppearance {
    static var shared: BAAppearance = BAAppearance()
}
