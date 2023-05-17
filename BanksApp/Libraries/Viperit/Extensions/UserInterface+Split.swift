//
//  UserInterface+Split.swift
//  Viperit
//
//  Created by Ferran on 01/04/2019.
//  Copyright © 2019 Ferran Abelló. All rights reserved.
//

import UIKit

// MARK: - Default implementation for UISplitViewController

open class SplitUserInterface: UISplitViewController, UserInterfaceProtocol {
    public var _presenter: PresenterProtocol!
    public var _displayData: DisplayData?

    override open func viewDidLoad() {
        super.viewDidLoad()
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
}
