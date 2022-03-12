//
//  AppComponent.swift
//  MasonRIBsSample
//
//  Created by YoungsunMoon on 2022/03/01.
//

import RIBs

final class AppComponent: Component<EmptyDependency>, AppRootDependency {
    
    init() {
        super.init(dependency: EmptyComponent())
    }
}
