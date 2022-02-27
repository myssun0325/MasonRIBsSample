//
//  AppRootViewController.swift
//  MasonRIBsSample
//
//  Created by YoungsunMoon on 2022/02/28.
//

import RIBs
import RxSwift
import UIKit

protocol AppRootPresentableListener: AnyObject {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
}

final class AppRootViewController: UIViewController, AppRootPresentable, AppRootViewControllable {

    weak var listener: AppRootPresentableListener?
}
