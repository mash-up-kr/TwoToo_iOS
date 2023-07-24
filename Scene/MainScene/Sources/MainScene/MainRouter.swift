//
//  MainRouter.swift
//  TwoToo
//
//  Created by 박건우 on 2023/06/04.
//  Copyright (c) 2023 TwoToo. All rights reserved.
//

import HistoryScene
import HomeScene
import MyInfoScene

import CoreKit
import UIKit

@MainActor
protocol MainRoutingLogic {
    /// 탭 화면 세팅
    func setTabViewControllers()
    /// 히스토리 탭으로 이동
    func switchHistoryTab()
}

final class MainRouter {
    weak var tabBarController: MainTabBarController?
    weak var dataStore: MainDataStore?
    
    weak var historyScene: HistoryScene?
    weak var homeScene: HomeScene?
    weak var myInfoScene: MyInfoScene?
}

extension MainRouter: MainRoutingLogic {
    
    func setTabViewControllers() {
        guard let dataStore = self.dataStore,
              let source = self.tabBarController else {
            return
        }
        
        // Alloc
        
        let historyScene = HistorySceneFactory().make(with: .init())
        let homeScene = HomeSceneFactory().make(with: .init(didTriggerRouteToHistoryScene: dataStore.didTriggerRouteToHistoryScene))
        let myInfoScene = MyInfoSceneFactory().make(with: .init())
        
        self.historyScene = historyScene
        self.homeScene = homeScene
        self.myInfoScene = myInfoScene
        
        let historyViewController = historyScene.viewController
        let homeViewController = homeScene.viewController
        let myInfoViewController = myInfoScene.viewController
        
        let historyNavigationController = UINavigationController(rootViewController: historyViewController)
        let homeNavigationController = UINavigationController(rootViewController: homeViewController)
        let myInfoNavigationController = UINavigationController(rootViewController: myInfoViewController)
        
        // Configure
        
        historyViewController.hidesBottomBarWhenPushed = false
        historyNavigationController.setNavigationBarHidden(true, animated: false)
        
        homeViewController.hidesBottomBarWhenPushed = false
        homeNavigationController.setNavigationBarHidden(true, animated: false)
        
        myInfoViewController.hidesBottomBarWhenPushed = false
        myInfoNavigationController.setNavigationBarHidden(true, animated: false)
        
        // Render

        let navigationControllers = [historyNavigationController, homeNavigationController, myInfoNavigationController]
        source.setViewControllers(navigationControllers, animated: true)
        source.setTab(.history) // TODO: - 테스트 때메 바꿈
    }
    
    func switchHistoryTab() {
        self.tabBarController?.setTab(.history)
    }
}
