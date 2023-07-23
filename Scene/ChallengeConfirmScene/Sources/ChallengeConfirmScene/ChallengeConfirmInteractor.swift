//
//  ChallengeConfirmInteractor.swift
//  TwoToo
//
//  Created by 박건우 on 2023/06/04.
//  Copyright (c) 2023 TwoToo. All rights reserved.
//

import CoreKit

protocol ChallengeConfirmBusinessLogic {
    /// 첫 진입
    func didAppear() async
    /// 다음 버튼 클릭
    func didTapNextButton() async
}

protocol ChallengeConfirmDataStore: AnyObject {}

final class ChallengeConfirmInteractor: ChallengeConfirmDataStore, ChallengeConfirmBusinessLogic {
    var cancellables: Set<AnyCancellable> = []
    
    var presenter: ChallengeConfirmPresentationLogic
    var router: ChallengeConfirmRoutingLogic
    var worker: ChallengeConfirmWorkerProtocol
    
    init(
        presenter: ChallengeConfirmPresentationLogic,
        router: ChallengeConfirmRoutingLogic,
        worker: ChallengeConfirmWorkerProtocol
    ) {
        self.presenter = presenter
        self.router = router
        self.worker = worker
    }
    
    // MARK: - DataStore
    
}

// MARK: - Interactive Business Logic

extension ChallengeConfirmInteractor {
    
    /// 외부 액션 옵저빙
    func observe() {
        
    }
}

// MARK: Feature (진입)

extension ChallengeConfirmInteractor {
    func didAppear() async {
        do {
            let chanllengeConfirmStatus = try await self.worker.fetchChallengeConfirmInfo()

            switch chanllengeConfirmStatus {
            case .create:
                await self.presenter.presentChallengeConfirmView(status: .create)
            case .confirm:
                await self.presenter.presentChallengeConfirmView(status: .confirm)
            case .accept:
                await self.presenter.presentChallengeConfirmView(status: .accept)
            }
        }
        catch  {
            await self.presenter.presentChallengeConfirmViewError(error: error)
        }
    }

    // TODO: - 다음 버튼 눌렀을 떄 화면전환 구현 필요
    func didTapNextButton() async {

    }
}

// MARK: - Application Business Logic

// MARK: UseCase ()

extension ChallengeConfirmInteractor {
    
}
