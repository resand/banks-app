//
//  UserInterface.swift
//  Viperit
//
//  Created by Ferran on 11/09/2016.
//  Copyright © 2016 Ferran Abelló. All rights reserved.
//

import UIKit

public protocol UserInterfaceProtocol: AnyObject {
    var _presenter: PresenterProtocol! { get set }
    var _displayData: DisplayData? { get set }
    var viewController: UIViewController { get }
    func viewDidLoad()
    func viewWillAppear(_ animated: Bool)
    func viewDidAppear(_ animated: Bool)
    func viewWillDisappear(_ animated: Bool)
    func viewDidDisappear(_ animated: Bool)
}

public extension UserInterfaceProtocol {
    var viewController: UIViewController {
        return self as! UIViewController
    }
}

// MARK: - Default implementation for UIViewController

open class UserInterface: UIViewController, UserInterfaceProtocol, BACustomizable {
    public var _presenter: PresenterProtocol!
    public var _displayData: DisplayData?

    override open var next: UIResponder? {
        // When `self` is being added to the parent controller, the default `next` implementation returns nil
        // unless the `self.view` is added as a subview to `parent.view`. But `self.viewDidLoad` is
        // called before the transition finishes so the subviews are created from `Components.default`.
        // To prevent responder chain from being cutoff during `ViewController` lifecycle we fallback to parent.
        super.next ?? parent
    }

    open func setup() { /* default empty implementation */ }
    open func setupAppearance() { view.setNeedsLayout() }
    open func setupLayout() { view.setNeedsLayout() }
    open func updateContent() { view.setNeedsLayout() }

    override open func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupLayout()
        setupAppearance()
        updateContent()

        _presenter.viewHasLoaded()
    }

    override open func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        _presenter.viewIsAboutToAppear()
    }

    override open func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        _presenter.viewHasAppeared()
    }

    override open func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        _presenter.viewIsAboutToDisappear()
    }

    override open func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        _presenter.viewHasDisappeared()
    }

    override open func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        guard previousTraitCollection?.userInterfaceStyle != traitCollection.userInterfaceStyle else { return }

        TraitCollectionReloadStack.push {
            self.setupAppearance()
            self.updateContent()
        }
    }

    override open func viewWillLayoutSubviews() {
        TraitCollectionReloadStack.executePendingUpdates()
        super.viewWillLayoutSubviews()
    }
}
