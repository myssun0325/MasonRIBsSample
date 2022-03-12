//
//  LoggedInRouter.swift
//  MasonRIBsSample
//
//  Created by YoungsunMoon on 2022/03/12.
//

import RIBs

protocol LoggedInInteractable: Interactable, OffGameListener, TicTacToeListener {
    var router: LoggedInRouting? { get set }
    var listener: LoggedInListener? { get set }
}

protocol LoggedInViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy. Since
    // this RIB does not own its own view, this protocol is conformed to by one of this
    // RIB's ancestor RIBs' view.
    func present(viewController: ViewControllable)
    func dismiss(viewController: ViewControllable)
}

final class LoggedInRouter: Router<LoggedInInteractable>, LoggedInRouting {
    
    // MARK: - Private
    private let viewController: LoggedInViewControllable
    
    private var currentChild: ViewableRouting?
    
    private let offGameBuilder: OffGameBuildable
    private let ticTacToeBuilder: TicTacToeBuildable
    
    // TODO: Constructor inject child builder protocols to allow building children.
    init(interactor: LoggedInInteractable,
         viewController: LoggedInViewControllable,
         offGameBuilder: OffGameBuildable,
         ticTacToeBuilder: TicTacToeBuildable) {
        self.viewController = viewController
        self.offGameBuilder = offGameBuilder
        self.ticTacToeBuilder = ticTacToeBuilder
        super.init(interactor: interactor)
        interactor.router = self
    }

    func cleanupViews() {
        // TODO: Since this router does not own its view, it needs to cleanup the views
        // it may have added to the view hierarchy, when its interactor is deactivated.
        if let currentChild = currentChild {
            viewController.dismiss(viewController: currentChild.viewControllable)
        }
    }
    
    override func didLoad() {
        super.didLoad()
        attachOffGame()
    }
    
    private func attachOffGame() {
        let offGameRouter = offGameBuilder.build(withListener: interactor)
        self.currentChild = offGameRouter
        attachChild(offGameRouter)
        viewController.present(viewController: offGameRouter.viewControllable)
    }
    
    func routeToTicTacToe() {
        detachCurrentChild()
        
        let ticTacToeRouter = ticTacToeBuilder.build(withListener: interactor)
        self.currentChild = ticTacToeRouter
        attachChild(ticTacToeRouter)
        viewController.present(viewController: ticTacToeRouter.viewControllable)
    }
    
    func routeToOffGame() {
        detachCurrentChild()
        attachOffGame()
    }
    
    // MARK: - Private
    
    private func detachCurrentChild() {
        if let currentChild = currentChild {
            detachChild(currentChild)
            viewController.dismiss(viewController: currentChild.viewControllable)
        }
    }
}
