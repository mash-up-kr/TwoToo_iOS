//
//  SplashViewController.swift
//  TwoToo
//
//  Created by 박건우 on 2023/06/03.
//  Copyright (c) 2023 TwoToo. All rights reserved.
//

import CoreKit
import UIKit

protocol SplashDisplayLogic: AnyObject {}

final class SplashViewController: UIViewController {
    var interactor: SplashBusinessLogic
    
    init(interactor: SplashBusinessLogic) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI
    
    lazy var contentView: UIStackView = {
        let v = UIStackView()
        v.axis = .vertical
        v.spacing = 28
        v.addArrangedSubview(self.appIconImageView)
        v.addArrangedSubview(self.appLogoImageView)
        return v
    }()
    
    lazy var appIconImageView: UIImageView = {
        let v = UIImageView()
        v.image = .asset(.app_icon)!
        return v
    }()
    
    lazy var appLogoImageView: UIImageView = {
        let v = UIImageView()
        v.image = .asset(.app_logo)!
        return v
    }()
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUI()
        
        Task {
            await self.interactor.didLoad()
        }
    }
    
    // MARK: - Layout
    
    private func setUI() {
        self.view.setBackgroundDefault()
        
        self.view.addSubview(self.contentView)
        
        self.contentView.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        self.appIconImageView.snp.makeConstraints { make in
            make.width.equalTo(122)
            make.height.equalTo(117)
        }
        self.appLogoImageView.snp.makeConstraints { make in
            make.width.equalTo(135)
            make.height.equalTo(23)
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
