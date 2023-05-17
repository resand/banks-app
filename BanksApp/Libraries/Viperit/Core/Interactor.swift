//
//  Interactor.swift
//  Viperit
//
//  Created by Ferran on 11/09/2016.
//  Copyright © 2016 Ferran Abelló. All rights reserved.
//

public protocol InteractorProtocol: ViperitComponent {
    var _presenter: PresenterProtocol! { get set }
}

open class Interactor: InteractorProtocol {
    var reachability: Reachability?
    public weak var _presenter: PresenterProtocol!

    public required init() { }

    func checkConnection(ifOnline: (() -> Void)?, ifOffline: (() -> Void)?) {
        reachability = Reachability(hostname: "google.com")

        reachability?.whenReachable = { _ in
            ifOnline?()
        }

        reachability?.whenUnreachable = { _ in
            ifOffline?()
        }

        do {
            try reachability?.startNotifier()
        } catch {
            ifOffline?()
        }
    }
}
