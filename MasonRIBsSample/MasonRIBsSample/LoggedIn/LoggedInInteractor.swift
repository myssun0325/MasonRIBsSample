//
//  LoggedInInteractor.swift
//  MasonRIBsSample
//
//  Created by YoungsunMoon on 2022/03/12.
//

import RIBs
import RxSwift

protocol LoggedInRouting: Routing {
    func routeToTicTacToe()
    func routeToOffGame()
    func cleanupViews()
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol LoggedInListener: AnyObject {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
}

final class LoggedInInteractor: Interactor, LoggedInInteractable {

    weak var router: LoggedInRouting?
    weak var listener: LoggedInListener?

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    override init() {}

    override func didBecomeActive() {
        super.didBecomeActive()
        // TODO: Implement business logic here.
    }

    override func willResignActive() {
        super.willResignActive()
        // TODO: Pause any business logic.

        router?.cleanupViews()
    }
    
    func startTicTacToe() {
        router?.routeToTicTacToe()
    }
    
    func gameDidEnd() {
        router?.routeToOffGame()
    }
}
