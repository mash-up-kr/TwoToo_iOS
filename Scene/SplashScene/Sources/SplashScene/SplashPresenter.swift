//
//  SplashPresenter.swift
//  TwoToo
//
//  Created by 박건우 on 2023/06/03.
//  Copyright (c) 2023 TwoToo. All rights reserved.
//

import UIKit

@MainActor
protocol SplashPresentationLogic {
    // 강제 업데이트 팝업을 보여준다.
    func presentUpdatePopup()
}

final class SplashPresenter {
    weak var viewController: SplashDisplayLogic?
    
}

// MARK: - Presentation Logic

extension SplashPresenter: SplashPresentationLogic {
    func presentUpdatePopup() {
        let viewModel = Splash.ViewModel.UpdatePopup(title: "업데이트 알림", iconImage: .asset(.update_icon)!, description: "앱을 업데이트 하고\n더욱 안정된 투투를 만나보세요 :)", buttonTitle: ["업데이트"])
        
        self.viewController?.displayUpdatePopup(viewModel: viewModel)
    }
}
