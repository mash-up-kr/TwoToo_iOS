//
//  MyInfoPresenter.swift
//  TwoToo
//
//  Created by 박건우 on 2023/06/04.
//  Copyright (c) 2023 TwoToo. All rights reserved.
//

import CoreKit
import UIKit

@MainActor
protocol MyInfoPresentationLogic {
    /// 마이 페이지 화면을 보여준다.
    func presentMyInfo(model: MyInfo.Model.Data)
    /// 마이 페이지 오류를 보여준다.
    func presentMyInfoError(error: Error)
    
    /// 회원 탈퇴하기 팝업을 보여준다
    func presentSignOutPopup()
    /// 회원 탈퇴하기 팝업을 제거한다.
    func dismissSignOutPopup()
    /// 회원 탈퇴 완료 팝업을 보여준다.
    func presentSignOutCompletePopup()
    /// 회원 탈퇴  완료 팝업을 제거한다.
    func dismissSignOutCompletePopup()
    /// 회원 탈퇴 오류를 보여준다.
    func presentSignOutError(error: Error)
}

final class MyInfoPresenter {
    weak var viewController: MyInfoDisplayLogic?
    
}

// MARK: - Presentation Logic

extension MyInfoPresenter: MyInfoPresentationLogic {
    func presentMyInfo(model: MyInfo.Model.Data) {
        
        let myInfoItems: MyInfo.ViewModel.Lists =
            .init(items: [
                .init(title: "공지사항"),
                .init(title: "이용 가이드"),
                .init(title: "투투에 문의하기"),
                .init(title: "만든이들"),
                .init(title: "로그아웃"),
                .init(title: "회원탈퇴")
            ])
        
        let totalCount = "\(model.challengeTotalCount ?? "0")번째 꽃 피우는중"
        
        self.viewController?.displayLists(viewModel: myInfoItems)
        self.viewController?.displayMyInfo(viewModel: .init(myNickname: model.myNickname, partnerNickname: model.partnerNickname, challengeTotalCount: totalCount))
    }
    
    func presentMyInfoError(error: Error) {
        self.viewController?.displayToast(viewModel: .init(message: error.localizedDescription))
    }
    
    func presentSignOutPopup() {
        self.viewController?.displaySignOutPopup(viewModel: .init(show: .asset(.icon_delete)))
    }
    
    func dismissSignOutPopup() {
        self.viewController?.displaySignOutPopup(viewModel: .init(dismiss: ()))
    }
    
    func presentSignOutCompletePopup() {
        self.viewController?.displaySignOutCompletePopup(viewModel: .init(show: .asset(.icon_delete)))
    }
    
    func dismissSignOutCompletePopup() {
        self.viewController?.displaySignOutCompletePopup(viewModel: .init(dismiss: ()))
    }
    
    func presentSignOutError(error: Error) {
        self.viewController?.displayToast(viewModel: .init(message: error.localizedDescription))
    }
    
    func presentChangeNicknameView() {
        
    }
}
