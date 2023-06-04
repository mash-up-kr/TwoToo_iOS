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
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUI()
    }
    
    // MARK: - Layout
    
    private func setUI() {
        
    }
}

// MARK: - Trigger

// MARK: - Trigger by Parent Scene

extension SplashViewController: SplashScene {
    
}

// MARK: - Display Logic

extension SplashViewController: SplashDisplayLogic {
    
}
