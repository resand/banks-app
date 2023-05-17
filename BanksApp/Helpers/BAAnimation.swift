//
//  BAAnimation.swift
//  BanksApp
//
//  Created by René Sandoval on 17/05/23.
//

import UIKit

func BAAnimation(
    duration: TimeInterval = 0.6,
    delay: TimeInterval = 0,
    _ actions: @escaping () -> Void,
    completion: ((Bool) -> Void)? = nil
) {
    BAAnimation(
        duration: duration,
        delay: delay,
        isAnimated: true,
        actions,
        completion: completion
    )
}

func BAAnimation(
    duration: TimeInterval = 0.6,
    delay: TimeInterval = 0,
    isAnimated: Bool = true,
    _ actions: @escaping () -> Void,
    completion: ((Bool) -> Void)? = nil
) {
    guard isAnimated, !UIAccessibility.isReduceMotionEnabled else {
        actions()
        completion?(true)
        return
    }

    UIView.animate(
        withDuration: duration,
        delay: delay,
        usingSpringWithDamping: 0.8,
        initialSpringVelocity: 4,
        options: .curveEaseInOut,
        animations: actions,
        completion: completion
    )
}
