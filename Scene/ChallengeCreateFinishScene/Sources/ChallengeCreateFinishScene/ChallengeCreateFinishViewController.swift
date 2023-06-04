//
//  ChallengeCreateFinishViewController.swift
//  TwoToo
//
//  Created by 박건우 on 2023/06/04.
//  Copyright (c) 2023 TwoToo. All rights reserved.
//

import CoreKit
import UIKit

protocol ChallengeCreateFinishDisplayLogic: AnyObject {}

final class ChallengeCreateFinishViewController: UIViewController {
    var interactor: ChallengeCreateFinishBusinessLogic
    
    init(interactor: ChallengeCreateFinishBusinessLogic) {
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

extension ChallengeCreateFinishViewController: ChallengeCreateFinishScene {
    
}

// MARK: - Display Logic

extension ChallengeCreateFinishViewController: ChallengeCreateFinishDisplayLogic {
    
}
