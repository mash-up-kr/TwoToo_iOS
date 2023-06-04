//
//  InvitationWaitViewController.swift
//  TwoToo
//
//  Created by 박건우 on 2023/06/04.
//  Copyright (c) 2023 TwoToo. All rights reserved.
//

import CoreKit
import UIKit

protocol InvitationWaitDisplayLogic: AnyObject {}

final class InvitationWaitViewController: UIViewController {
    var interactor: InvitationWaitBusinessLogic
    
    init(interactor: InvitationWaitBusinessLogic) {
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

extension InvitationWaitViewController: InvitationWaitScene {
    
}

// MARK: - Display Logic

extension InvitationWaitViewController: InvitationWaitDisplayLogic {
    
}
