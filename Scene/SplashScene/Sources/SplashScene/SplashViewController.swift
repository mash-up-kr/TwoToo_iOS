//
//  SplashViewController.swift
//  TwoToo
//
//  Created by 박건우 on 2023/06/03.
//  Copyright (c) 2023 TwoToo. All rights reserved.
//

import CoreKit
import UIKit
import DesignSystem

protocol SplashDisplayLogic: AnyObject {}

final class SplashViewController: UIViewController {
    var interactor: SplashBusinessLogic

    private lazy var titleLabel: UILabel = {
        let v = UILabel()
        v.text = "Twotoo"
        v.font = .h1
        v.textColor = .mainPink

        return v
    }()
    
    init(interactor: SplashBusinessLogic) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUI()
    }
    
    // MARK: - Layout
    
    private func setUI() {
        self.view.backgroundColor = .second02
        self.view.addSubview(self.titleLabel)

        self.titleLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}

// MARK: - Trigger

// MARK: - Trigger by Parent Scene

extension SplashViewController: SplashScene {
    
}

// MARK: - Display Logic

extension SplashViewController: SplashDisplayLogic {
    
}
