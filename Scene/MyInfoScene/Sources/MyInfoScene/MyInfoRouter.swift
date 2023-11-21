//
//  MyInfoRouter.swift
//  TwoToo
//
//  Created by 박건우 on 2023/06/04.
//  Copyright (c) 2023 TwoToo. All rights reserved.
//

import UIKit
import SafariServices
import ChangeNicknameScene

@MainActor
protocol MyInfoRoutingLogic {
    /// 마이페이지 내 공지사항, 이용가이드, 투투에 문의하기, 만든이들 화면으로 이동한다.
    func routeToMyInfoListsScene(url: URL)
    /// 닉네임 변경 화면으로 이동한다.
    func routeToChangeNicknameScene()
}

final class MyInfoRouter {
    weak var viewController: MyInfoViewController?
    weak var dataStore: MyInfoDataStore?
}

extension MyInfoRouter: MyInfoRoutingLogic {
    /// 사파리 웹뷰로 보여준다.
    func routeToMyInfoListsScene(url: URL) {
        
        let safariViewController = SFSafariViewController(url: url)
        
        self.viewController?.present(safariViewController, animated: true, completion: nil)
    }
    
    func routeToChangeNicknameScene() {
        let changeNicknameScene = ChangeNicknameSceneFactory().make(with: .init()).viewController
        changeNicknameScene.hidesBottomBarWhenPushed = true
        self.viewController?.navigationController?.pushViewController(changeNicknameScene, animated: true)
    }
}
