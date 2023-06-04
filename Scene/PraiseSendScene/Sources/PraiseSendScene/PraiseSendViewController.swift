//
//  PraiseSendViewController.swift
//  TwoToo
//
//  Created by 박건우 on 2023/06/04.
//  Copyright (c) 2023 TwoToo. All rights reserved.
//

import CoreKit
import UIKit

protocol PraiseSendDisplayLogic: AnyObject {}

final class PraiseSendViewController: UIViewController {
    var interactor: PraiseSendBusinessLogic
    
    init(interactor: PraiseSendBusinessLogic) {
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

extension PraiseSendViewController: PraiseSendScene {
    
}

// MARK: - Display Logic

extension PraiseSendViewController: PraiseSendDisplayLogic {
    
}
