//
//  MyInfoPresenter.swift
//  TwoToo
//
//  Created by 박건우 on 2023/06/04.
//  Copyright (c) 2023 TwoToo. All rights reserved.
//

import UIKit

@MainActor
protocol MyInfoPresentationLogic {
    /// 마이 페이지 화면을 보여준다.
    func presentMyInfo(model: MyInfo.Model.MyInfo)
    /// 마이 페이지 오류를 보여준다.
    func presentMyInfoError(error: Error)
    /// 설명서 화면을 보여준다.
    func presentInstructions()
    /// 공지사항 화면을 보여준다.
    func presentAnnouncement()
    /// 이용 가이드 화면을 보여준다.
    func presentUserGuide()
    /// 투투에 문의하기 화면을 보여준다.
    func presentInquery()
    /// 만든이들 화면을 보여준다.
    func presentCreators()
}

final class MyInfoPresenter {
    weak var viewController: MyInfoDisplayLogic?
    
}

// MARK: - Presentation Logic

extension MyInfoPresenter: MyInfoPresentationLogic {
    func presentMyInfo(model: MyInfo.Model.MyInfo) {
        
        let myInfoItems: MyInfo.ViewModel.MyInfo =
            .init(items: [
                .init(title: "공지사항"),
                .init(title: "이용 가이드"),
                .init(title: "투투에 문의하기"),
                .init(title: "만든이들")
            ])
        
        self.viewController?.displayMyInfo(viewModel: myInfoItems)
    }

    func presentInstructions() {
        
    }
    
    func presentAnnouncement() {
        
    }
    
    func presentUserGuide() {
        
    }
    
    func presentInquery() {
        
    }
    
    func presentCreators() {
        
    }
    
    func presentMyInfoError(error: Error) {
        
    }
}
