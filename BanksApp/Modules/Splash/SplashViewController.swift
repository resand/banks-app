//
//  SplashViewController.swift
//  BanksApp
//
//  Created by René Sandoval on 16/05/23.
//

import UIKit

class SplashViewController: UIViewController {
    var logoSplashLottie: LottieAnimationView?
    var window: UIWindow?

    init(window: UIWindow?) {
        self.window = window
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        logoSplashLottie?.play()
        DispatchQueue.main.asyncAfter(deadline: .now() + 6) {
            let module = BAModules.banksList.build()
            module.router.show(inWindow: self.window, embedInNavController: true, setupData: nil, makeKeyAndVisible: true)
        }
    }

    func setupView() {
        logoSplashLottie = LottieAnimationView(name: BAConstants.Animations.splash.randomElement() ?? "", configuration: LottieConfiguration(renderingEngine: .automatic))
        logoSplashLottie?.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        logoSplashLottie?.contentMode = .scaleAspectFit
        logoSplashLottie?.loopMode = .loop
        logoSplashLottie?.backgroundBehavior = .pauseAndRestore
        logoSplashLottie?.backgroundColor = BAAppearance.shared.colorPalette.splashBackground
        view.addSubview(logoSplashLottie!)
    }
}
