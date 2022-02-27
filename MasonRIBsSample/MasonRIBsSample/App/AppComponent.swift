//
//  AppComponent.swift
//  MasonRIBsSample
//
//  Created by YoungsunMoon on 2022/02/28.
//

import RIBs

final class AppComponent: Component<EmptyDependency>, AppRootDependency {
    
    init() {
        super.init(dependency: EmptyComponent())
    }
}
