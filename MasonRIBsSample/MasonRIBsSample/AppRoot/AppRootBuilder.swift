//
//  AppRootBuilder.swift
//  MasonRIBsSample
//
//  Created by YoungsunMoon on 2022/03/01.
//

import RIBs

protocol AppRootDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class AppRootComponent: Component<AppRootDependency> {

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
    // @mason
    let rootViewController: AppRootViewController
    
    init(dependency: AppRootDependency,
         rootViewController: AppRootViewController) {
        self.rootViewController = rootViewController
        super.init(dependency: dependency)
    }
}

extension AppRootComponent: LoggedOutDependency { }

extension AppRootComponent: LoggedInDependency {
    var loggedInViewController: LoggedInViewControllable {
        return rootViewController
    }
}

// MARK: - Builder

protocol AppRootBuildable: Buildable {
    func build() -> LaunchRouting
}

final class AppRootBuilder: Builder<AppRootDependency>, AppRootBuildable {

    override init(dependency: AppRootDependency) {
        super.init(dependency: dependency)
    }

    func build() -> LaunchRouting {
        let viewController = AppRootViewController()
        let component = AppRootComponent(dependency: dependency,
                                         rootViewController: viewController)
        let interactor = AppRootInteractor(presenter: viewController)
        
        let loggedOutBuilder = LoggedOutBuilder(dependency: component)
        let loggedInBuilder = LoggedInBuilder(dependency: component)
        return AppRootRouter(interactor: interactor,
                             viewController: viewController,
                             loggedOutBuilder: loggedOutBuilder,
                             loggedInBuilder: loggedInBuilder)
    }
}
