//
//  BAApp.swift
//  BanksApp
//
//  Created by René Sandoval on 16/05/23.
//

import Foundation
import UIKit

protocol BAAppProtocol {
    func bundleId() -> String
    func getName() -> String
    func getVersion() -> String
    func getVersionName() -> String
    func showErrorAlert(_ message: String, viewController: UIViewController, errorHandler: @escaping () -> Void)
}

final class BAApp: BAAppProtocol {
    private lazy var alertError: UIAlertController = UIAlertController()

    func bundleId() -> String {
        guard let bundleId = Bundle.main.bundleIdentifier else {
            logWarn("No bundle identifier found")
            return "no_id"
        }

        return bundleId
    }

    func getName() -> String {
        guard let version = Bundle.main.infoDictionary?["CFBundleDisplayName"] as? String else {
            return "NO_NAME_FOUND"
        }
        return version
    }

    func getVersion() -> String {
        guard let version = Bundle.main.infoDictionary?["CFBundleVersion"] as? String else {
            return "NO_VERSION_FOUND"
        }
        return version
    }

    func getVersionName() -> String {
        guard let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String else {
            return "NO_VERSION_FOUND"
        }
        return version
    }

    func showErrorAlert(_ message: String, viewController: UIViewController, errorHandler: @escaping () -> Void) {
        alertError = UIAlertController(title: "Information", message: message, preferredStyle: .alert)

        let actionCancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let actionError = UIAlertAction(title: "Ok", style: .default) { _ in
            errorHandler()
        }

        alertError.addAction(actionCancel)
        alertError.addAction(actionError)

        viewController.present(alertError, animated: true, completion: nil)
    }
}
