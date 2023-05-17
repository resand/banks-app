//
//  UIViewController+Extensions.swift
//  BanksApp
//
//  Created by René Sandoval on 16/05/23.
//

import UIKit

extension UIViewController {
    @objc func startLoading() {
        startLoadingAnimation()
    }

    private func startLoadingAnimation() {
        if view.viewWithTag(1000) == nil {
            if let tabBarController {
                tabBarController.tabBar.isVisible = false
            }

            let animationBackgroundView = UIView().withoutAutoresizingMaskConstraints
            animationBackgroundView.backgroundColor = .black.withAlphaComponent(0.6)
            animationBackgroundView.tag = 1000
            view.embed(animationBackgroundView)

            let animationView: LottieAnimationView = LottieAnimationView().withoutAutoresizingMaskConstraints
            let animation = LottieAnimation.named(BAConstants.Animations.loader)
            animationView.animation = animation
            animationView.contentMode = .scaleToFill
            animationView.loopMode = .loop
            animationView.backgroundBehavior = .pauseAndRestore
            animationView.play()

            animationView.heightAnchor.pin(equalToConstant: 500).isActive = true
            animationView.widthAnchor.pin(equalToConstant: 500).isActive = true

            animationBackgroundView.addSubview(animationView)
            animationView.pin(anchors: [.centerX, .centerY], to: view)
        }
    }

    @objc func stopLoading() {
        if let tabBarController {
            tabBarController.tabBar.isVisible.toggle()
        }

        if let animationBackgroundView = view.viewWithTag(1000) {
            animationBackgroundView.removeFromSuperview()
        }
    }
}
