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
    
    /// 메인 탭바
    ///
    /// 기본 탭바 대신 사용합니다.
    lazy var mainTabBar: MainTabBarContentView = {
        let v = MainTabBarContentView()
        v.mainTabBarDelegate = self
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
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.setTabBarLayout()
    }
    
    // MARK: - Layout
    
    private func setUI() {
        self.view.backgroundColor = .clear
        
        self.view.addSubview(self.mainTabBar)
    }
    
    private func setTabBarLayout() {
        self.view.bringSubviewToFront(self.mainTabBar)

        self.mainTabBar.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(61 + UIDevice.current.safeAreaBottomHeight)
        }

        let isHideBottomPushed = (self.selectedViewController as? UINavigationController)?.topViewController?.hidesBottomBarWhenPushed

        if !(isHideBottomPushed ?? false) {
            self.mainTabBar.isHidden = false
        }
        else {
            self.mainTabBar.isHidden = true
        }
    }
    
    func setTab(_ tab: Main.ViewModel.MainTab) {
        self.selectedIndex = tab.rawValue
        self.mainTabBar.setTab(tab)
    }
}

// MARK: - Trigger

extension MainTabBarController: MainTabBarDelegate {
    
    func didSelectTab(_ tab: Main.ViewModel.MainTab) {
        self.selectedIndex = tab.rawValue
    }
}

// MARK: - Trigger by Parent Scene

extension MainTabBarController: MainScene {
    
}

// MARK: - Display Logic

extension MainTabBarController: MainDisplayLogic {
    
}
