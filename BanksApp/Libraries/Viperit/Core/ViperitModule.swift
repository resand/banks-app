//
//  ViperitModule.swift
//  Viperit
//
//  Created by Ferran Abelló on 14/06/2017.
//  Copyright © 2017 Ferran Abelló. All rights reserved.
//

import UIKit

// MARK: - Module View Types

enum ViperitViewType {
    case storyboard
    case nib
    case code
}

// MARK: - Viperit Module Protocol

protocol ViperitModule {
    var viewType: ViperitViewType { get }
    var viewName: String { get }
    func build(bundle: Bundle, deviceType: UIUserInterfaceIdiom?) -> ModuleVPK
}

extension ViperitModule where Self: RawRepresentable, Self.RawValue == String {
    var viewType: ViperitViewType {
        return .code
    }

    var viewName: String {
        return rawValue
    }

    func build(bundle: Bundle = Bundle.main, deviceType: UIUserInterfaceIdiom? = nil) -> ModuleVPK {
        return ModuleVPK.build(self, bundle: bundle, deviceType: deviceType)
    }
}

private extension ViperitModule where Self: RawRepresentable, Self.RawValue == String {
    func allocateViperComponents(bundle: Bundle) -> (interactor: InteractorProtocol, presenter: PresenterProtocol, router: RouterProtocol, displayData: DisplayData?) {
        // Get class types
        let interactorClass = classForViperComponent(.interactor, bundle: bundle) as! InteractorProtocol.Type
        let presenterClass = classForViperComponent(.presenter, bundle: bundle) as! PresenterProtocol.Type
        let routerClass = classForViperComponent(.router, bundle: bundle) as! RouterProtocol.Type
        let displayDataClass = classForViperComponent(.displayData, bundle: bundle) as? DisplayData.Type

        // Allocate VIPER components
        let interactor = interactorClass.init()
        let presenter = presenterClass.init()
        let router = routerClass.init()
        let displayData = displayDataClass?.init()

        return (interactor, presenter, router, displayData)
    }
}
