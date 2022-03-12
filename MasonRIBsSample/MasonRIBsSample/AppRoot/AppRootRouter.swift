//
//  AppRootRouter.swift
//  MasonRIBsSample
//
//  Created by YoungsunMoon on 2022/03/01.
//

import RIBs

protocol AppRootInteractable: Interactable, LoggedOutListener, LoggedInListener {
    var router: AppRootRouting? { get set }
    var listener: AppRootListener? { get set }
}

protocol AppRootViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
    func present(viewController: ViewControllable)
    func dismiss(viewController: ViewControllable)
}

final class AppRootRouter: LaunchRouter<AppRootInteractable, AppRootViewControllable>, AppRootRouting {
    
    // MARK: - Private
    
    private let loggedOutBuilder: LoggedOutBuildable
    private var loggedOutRouter: ViewableRouting?
    
    private let loggedInBuilder: LoggedInBuildable
    
    // TODO: Constructor inject child builder protocols to allow building children.
    init(interactor: AppRootInteractable,
         viewController: AppRootViewControllable,
         loggedOutBuilder: LoggedOutBuildable,
         loggedInBuilder: LoggedInBuildable) {
        self.loggedOutBuilder = loggedOutBuilder
        self.loggedInBuilder = loggedInBuilder
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
    
    override func didLoad() {
        super.didLoad()
        
        routeToLoggedOut()
    }
    
    private func routeToLoggedOut() {
        let loggedOutRouter = loggedOutBuilder.build(withListener: interactor)
        self.loggedOutRouter = loggedOutRouter
        attachChild(loggedOutRouter)
        viewController.present(viewController: loggedOutRouter.viewControllable)
    }
    
    // MARK: - AppRootRouting
    
    func routeToLoggedIn(withPlayer1Name player1Name: String, player2Name: String) {
        // Detach LoggedOut RIB.
        if let loggedOutRouter = self.loggedOutRouter {
            detachChild(loggedOutRouter)
            viewController.dismiss(viewController: loggedOutRouter.viewControllable)
            self.loggedOutRouter = nil
        }
        
        let loggedIn = loggedInBuilder.build(withListener: interactor)
        attachChild(loggedIn)
    }
}
