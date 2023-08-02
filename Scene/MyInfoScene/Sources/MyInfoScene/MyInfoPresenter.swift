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
    func presentMyInfo(model: MyInfo.Model.Data)
    /// 마이 페이지 오류를 보여준다.
    func presentMyInfoError(error: Error)
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
                .init(title: "로그아웃")
            ])

        let totalCount = "\(model.challengeTotalCount ?? "0")번째 꽃 피우는중"

        self.viewController?.displayLists(viewModel: myInfoItems)
        self.viewController?.displayMyInfo(viewModel: .init(myNickname: model.myNickname, partnerNickname: model.partnerNickname, challengeTotalCount: totalCount))
    }
    
    func presentMyInfoError(error: Error) {
        self.viewController?.displayToast(viewModel: .init(message: error.localizedDescription))
    }
}
