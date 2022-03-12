//
//  OffGameViewController.swift
//  MasonRIBsSample
//
//  Created by YoungsunMoon on 2022/03/12.
//

import RIBs
import SnapKit
import RxSwift
import RxCocoa
import UIKit

protocol OffGamePresentableListener: AnyObject {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
    func startGame()
}

final class OffGameViewController: UIViewController, OffGamePresentable, OffGameViewControllable {

    weak var listener: OffGamePresentableListener?
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var uiviewController: UIViewController {
        return self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.yellow
        buildStartButton()
    }

    // MARK: - Private
    
    private let disposeBag = DisposeBag()

    private func buildStartButton() {
        let startButton = UIButton()
        view.addSubview(startButton)
        startButton.snp.makeConstraints { (maker: ConstraintMaker) in
            maker.center.equalTo(self.view.snp.center)
            maker.leading.trailing.equalTo(self.view).inset(40)
            maker.height.equalTo(100)
        }
        startButton.setTitle("Start Game", for: .normal)
        startButton.setTitleColor(UIColor.white, for: .normal)
        startButton.backgroundColor = UIColor.black
        
        startButton.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.listener?.startGame()
            }).disposed(by: disposeBag)
    }
}

