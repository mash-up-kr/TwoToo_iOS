//
//  FlowerSelectPresenter.swift
//  TwoToo
//
//  Created by 박건우 on 2023/06/04.
//  Copyright (c) 2023 TwoToo. All rights reserved.
//

import UIKit
import Worker

@MainActor
protocol FlowerSelectPresentationLogic {
    /// 챌린지 수락ver 꽃 화면을 보여준다.
    func presentAceeptScene(model: FlowerSelect.Model.CreateChallengeButton)
    /// 챌린지 생성ver 꽃 화면을 보여준다.
    func presentCreateScene(model: FlowerSelect.Model.CreateChallengeButton)
    /// 꽃 리스트를 보여준다.
    func presentFlowers()
    /// 꽃 선택을 한다.
    func selectFlower(model: FlowerSelect.Model.FlowerSelect)
    /// 챌린지 생성 실패 오류를 보여준다.
    func presentCreateChallengeError(error: Error)
    /// 챌린지 시작 실패 오류를 보여준다.
    func presentStartChallengeError(error: Error)
    /// 챌린지 시작 성공 토스를 보여준다.
    func presentStartChallengeSuccess(text: String)
}

final class FlowerSelectPresenter {
    weak var viewController: FlowerSelectDisplayLogic?
    
}

// MARK: - Presentation Logic

extension FlowerSelectPresenter: FlowerSelectPresentationLogic {
    func presentCreateScene(model: FlowerSelect.Model.CreateChallengeButton) {
        self.viewController?.displayCrateView(viewModel: .init(isHidden: model.isHidden, title: model.title.rawValue))
    }
    
    func presentAceeptScene(model: FlowerSelect.Model.CreateChallengeButton) {
        self.viewController?.displayAccpetView(viewModel: .init(isHidden: model.isHidden, title: model.title.rawValue))
    }
    
    func presentFlowers() {
        
        let worker = Flower.allCases.map {
            FlowerMappingWorker(flowerType: $0)
        }
        

        self.viewController?.displayFlowerSelectView(viewModel: .init(flowers: worker))
    }
    
    func selectFlower(model: FlowerSelect.Model.FlowerSelect) {
        self.viewController?.displayFlowerSelect(viewModel: .init(indexPath: model.indexPath))
    }

    func presentCreateChallengeError(error: Error) {
        self.viewController?.displayCreateChallengeFailToast(viewModel: .init(message: error.localizedDescription))
    }

    func presentStartChallengeError(error: Error) {
        self.viewController?.displayStartChallengeFailToast(viewModel: .init(message: error.localizedDescription))
    }

    func presentStartChallengeSuccess(text: String) {
        self.viewController?.displayStartChallengeSuccessToast(viewModel: .init(message: text))
    }
}
