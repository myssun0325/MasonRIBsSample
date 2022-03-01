//
//  AppRootRouter.swift
//  MasonRIBsSample
//
//  Created by YoungsunMoon on 2022/02/28.
//

import RIBs

protocol AppRootInteractable: Interactable, LoggedOutListener {
    var router: AppRootRouting? { get set }
    var listener: AppRootListener? { get set }
}

protocol AppRootViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
    func present(viewController: ViewControllable)
}

final class AppRootRouter: LaunchRouter<AppRootInteractable, AppRootViewControllable>, AppRootRouting {
    
    private let loggedOutBuildable: LoggedOutBuildable
    
    // TODO: Constructor inject child builder protocols to allow building children.
    init(interactor: AppRootInteractable,
         viewController: AppRootViewControllable,
         loggedOutBuilder: LoggedOutBuildable) {
        self.loggedOutBuildable = loggedOutBuilder
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
    
    override func didLoad() {
        super.didLoad()
        let loggedOutRouter = loggedOutBuildable.build(withListener: self.interactor)
        attachChild(loggedOutRouter)
        viewController.present(viewController: loggedOutRouter.viewControllable)
    }
}
