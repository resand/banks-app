//
//  BABaseView.swift
//  BanksApp
//
//  Created by René Sandoval on 16/05/23.
//

import Foundation
import UIKit

protocol BACustomizable {
    func setup()
    func setupAppearance()
    func setupLayout()
    func updateContent()
}

extension BACustomizable where Self: UIView {
    func updateContentIfNeeded() {
        if superview != nil {
            updateContent()
        }
    }
}

extension BACustomizable where Self: UIViewController {
    func updateContentIfNeeded() {
        if isViewLoaded {
            updateContent()
        }
    }
}

class BAView: UIView, BACustomizable {
    fileprivate var isInitialized: Bool = false

    override open func didMoveToSuperview() {
        super.didMoveToSuperview()
        guard !isInitialized, superview != nil else { return }

        isInitialized = true

        setup()
        setupLayout()
        setupAppearance()
        updateContent()
    }

    open func setup() { /* default empty implementation */ }
    open func setupAppearance() { setNeedsLayout() }
    open func setupLayout() { setNeedsLayout() }
    open func updateContent() { setNeedsLayout() }

    override open func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        guard #available(iOS 12, *) else { return }
        guard previousTraitCollection?.userInterfaceStyle != traitCollection.userInterfaceStyle else { return }

        TraitCollectionReloadStack.push {
            self.setupAppearance()
            self.updateContent()
        }
    }

    override open func layoutSubviews() {
        TraitCollectionReloadStack.executePendingUpdates()
        super.layoutSubviews()
    }
}

enum TraitCollectionReloadStack {
    private static var stack: [() -> Void] = []

    static func executePendingUpdates() {
        guard !stack.isEmpty else { return }
        let existingUpdates = stack
        stack.removeAll()
        existingUpdates.reversed().forEach { $0() }
    }

    static func push(_ closure: @escaping () -> Void) {
        stack.append(closure)
    }
}
