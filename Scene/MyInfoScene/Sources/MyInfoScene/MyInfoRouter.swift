//
//  MyInfoRouter.swift
//  TwoToo
//
//  Created by 박건우 on 2023/06/04.
//  Copyright (c) 2023 TwoToo. All rights reserved.
//

import UIKit

@MainActor
protocol MyInfoRoutingLogic {
    /// 설명서 화면으로 이동한다.
    func routeToGuideScene()
    /// 공지사항 화면으로 이동한다.
    func routeToAnnouncementScene()
    /// 이용 가이드 화면으로 이동한다.
    func routeToUserGuideScene()
    /// 문의하기 화면으로 이동한다.
    func routeToInqueryScene()
    /// 만든이들 화면으로 이동한다.
    func routeToCreatorsScene()
}

final class MyInfoRouter {
    weak var viewController: MyInfoViewController?
    weak var dataStore: MyInfoDataStore?
}

extension MyInfoRouter: MyInfoRoutingLogic {
    func routeToGuideScene() {

    }

    func routeToAnnouncementScene() {

    }

    func routeToUserGuideScene() {

    }

    func routeToInqueryScene() {

    }

    func routeToCreatorsScene() {

    }
}
