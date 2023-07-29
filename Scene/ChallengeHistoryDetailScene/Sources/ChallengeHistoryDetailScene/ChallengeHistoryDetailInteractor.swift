//
//  ChallengeHistoryDetailInteractor.swift
//  TwoToo
//
//  Created by 박건우 on 2023/06/04.
//  Copyright (c) 2023 TwoToo. All rights reserved.
//

import CoreKit

protocol ChallengeHistoryDetailBusinessLogic {
    /// 첫 진입
    func didLoad() async
    /// 닫기 버튼 클릭
    func didTapCloseButton() async
}

protocol ChallengeHistoryDetailDataStore: AnyObject {
    /// 챌린지 인증 정보
    var detail: ChallengeHistoryDetail.Model.ChallengeDetail { get }
}

final class ChallengeHistoryDetailInteractor: ChallengeHistoryDetailDataStore, ChallengeHistoryDetailBusinessLogic {
    
    var cancellables: Set<AnyCancellable> = []
    
    var presenter: ChallengeHistoryDetailPresentationLogic
    var router: ChallengeHistoryDetailRoutingLogic
    var worker: ChallengeHistoryDetailWorkerProtocol
    
    init(
        presenter: ChallengeHistoryDetailPresentationLogic,
        router: ChallengeHistoryDetailRoutingLogic,
        worker: ChallengeHistoryDetailWorkerProtocol,
        detail: ChallengeHistoryDetail.Model.ChallengeDetail
    ) {
        self.presenter = presenter
        self.router = router
        self.worker = worker
        self.detail = detail
    }
    
    // MARK: - DataStore
    var detail: ChallengeHistoryDetail.Model.ChallengeDetail
}

// MARK: - Interactive Business Logic

extension ChallengeHistoryDetailInteractor {
    
    /// 외부 액션 옵저빙
    func observe() {
        
    }
}

// MARK: Feature (진입)

extension ChallengeHistoryDetailInteractor {

    func didLoad() async {
        await self.presenter.presentChallengeDetail(detail: self.detail)
    }
    
}

// MARK: Feature (닫기)

extension ChallengeHistoryDetailInteractor {

    func didTapCloseButton() async {
        await self.router.dismiss()
    }
    
}


// MARK: - Application Business Logic

// MARK: UseCase ()

extension ChallengeHistoryDetailInteractor {
    
}
