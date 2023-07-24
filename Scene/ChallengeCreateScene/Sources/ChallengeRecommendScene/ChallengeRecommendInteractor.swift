//
//  ChallengeRecommendInteractor.swift
//  TwoToo
//
//  Created by 박건우 on 2023/06/04.
//  Copyright (c) 2023 TwoToo. All rights reserved.
//

import CoreKit

protocol ChallengeRecommendBusinessLogic {
    /// 첫 진입
    func didLoad() async
    /// 추천 챌린지 선택
    func didSelectRecommendChallenge(challengeName: String) async
}

protocol ChallengeRecommendDataStore: AnyObject {
    /// 챌린지 이름 선택 트리거
    var didTriggerSelectChallengeName: PassthroughSubject<String, Never> { get }
}

final class ChallengeRecommendInteractor: ChallengeRecommendDataStore, ChallengeRecommendBusinessLogic {
    var cancellables: Set<AnyCancellable> = []
    
    var presenter: ChallengeRecommendPresentationLogic
    var router: ChallengeRecommendRoutingLogic
    var worker: ChallengeRecommendWorkerProtocol
    
    init(
        presenter: ChallengeRecommendPresentationLogic,
        router: ChallengeRecommendRoutingLogic,
        worker: ChallengeRecommendWorkerProtocol,
        didTriggerSelectChallengeName: PassthroughSubject<String, Never>
    ) {
        self.presenter = presenter
        self.router = router
        self.worker = worker
        self.didTriggerSelectChallengeName = didTriggerSelectChallengeName
    }
    
    // MARK: - DataStore
    
    var didTriggerSelectChallengeName: PassthroughSubject<String, Never>
}

// MARK: - Interactive Business Logic

extension ChallengeRecommendInteractor {
    
    /// 외부 액션 옵저빙
    func observe() {
        
    }
}

// MARK: Feature (진입)

extension ChallengeRecommendInteractor {
    
    func didLoad() async {
        await self.presenter.presentRecommendChallenges()
    }
}

// MARK: Feature (추천 챌린지 선택)

extension ChallengeRecommendInteractor {
    
    func didSelectRecommendChallenge(challengeName: String) async {
        self.didTriggerSelectChallengeName.send(challengeName)
        await self.router.dismiss()
    }
}

// MARK: - Application Business Logic

// MARK: UseCase ()

extension ChallengeRecommendInteractor {
    
}
