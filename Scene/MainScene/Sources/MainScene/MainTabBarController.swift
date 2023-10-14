//
//  MainTabBarController.swift
//  TwoToo
//
//  Created by 박건우 on 2023/06/04.
//  Copyright (c) 2023 TwoToo. All rights reserved.
//

import CoreKit
import UIKit

protocol MainDisplayLogic: AnyObject {
}

final class MainTabBarController: UITabBarController {
    var interactor: MainBusinessLogic
    
    init(interactor: MainBusinessLogic) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
        let tabBar = MainTabBar()
        self.setValue(tabBar, forKey: "tabBar")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI
    
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
    }
    
    func setTab(_ tab: Main.ViewModel.MainTab) {
        self.selectedIndex = tab.rawValue
    }
}

// MARK: - Trigger by Parent Scene

extension MainTabBarController: MainScene {
    
}

// MARK: - Display Logic

extension MainTabBarController: MainDisplayLogic {
    
}
