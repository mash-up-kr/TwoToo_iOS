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

protocol ChallengeConfirmDataStore: AnyObject {
    /// 챌린지명
    var challengeName: String { get }
    /// 챌린지 시작일
    var challengeStartDate: String { get }
    /// 챌린지 마김일
    var challengeEndDate: String { get }
    /// 챌린지 규칙
    var challengeRule: String? { get }
    /// 챌린지 ID
    var challengeID: String? { get }
    /// 챌린지 진입점
    var didEnterStatusDataSource: String { get }
}

final class ChallengeConfirmInteractor: ChallengeConfirmDataStore, ChallengeConfirmBusinessLogic {
    var cancellables: Set<AnyCancellable> = []
    
    var presenter: ChallengeConfirmPresentationLogic
    var router: ChallengeConfirmRoutingLogic
    var worker: ChallengeConfirmWorkerProtocol
    
    init(
        presenter: ChallengeConfirmPresentationLogic,
        router: ChallengeConfirmRoutingLogic,
        worker: ChallengeConfirmWorkerProtocol,
        challengeName: String,
        challengeStartDate: String,
        challengeEndDate: String,
        challengeRule: String?,
        challengeID: String?,
        didEnterStatus: String
    ) {
        self.presenter = presenter
        self.router = router
        self.worker = worker
        self.challengeName = challengeName
        self.challengeStartDate = challengeStartDate
        self.challengeEndDate = challengeEndDate
        self.challengeRule = challengeRule
        self.challengeID = challengeID
        self.didEnterStatusDataSource = didEnterStatus
    }
    
    // MARK: - DataStore
    
    var challengeName: String
    var challengeStartDate: String
    var challengeEndDate: String
    var challengeRule: String?
    var challengeID: String?
    var didEnterStatusDataSource: String
    
    enum FlowerSelectStatus: String {
        case create = "create"
        case view = "view"
        case accept = "accept"
    }
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
        let chanllengeConfirmStatus = FlowerSelectStatus(rawValue: didEnterStatusDataSource)

        didEnterStatusDataSource = chanllengeConfirmStatus?.rawValue ?? "create"
        
        switch chanllengeConfirmStatus {
        case .create:
            await self.presenter.presentChallengeConfirmView(
                status: .create,
                model: .init(title: challengeName, startDate: challengeStartDate, endDate: challengeEndDate, rule: challengeRule))
        case .view:
            await self.presenter.presentChallengeConfirmView(
                status: .confirm,
                model: .init(title: challengeName, startDate: challengeStartDate, endDate: challengeEndDate, rule: challengeRule))
        case .accept:
            await self.presenter.presentChallengeConfirmView(
                status: .accept,
                model: .init(title: challengeName, startDate: challengeStartDate, endDate: challengeEndDate, rule: challengeRule))
        default:
            await self.presenter.presentChallengeConfirmView(
                status: .create,
                model: .init(title: challengeName, startDate: challengeStartDate, endDate: challengeEndDate, rule: challengeRule))
        }
    }

    func didTapNextButton() async {
        await self.router.routeToFlowerSelectScene()
    }
}

// MARK: - Application Business Logic

// MARK: UseCase ()

extension ChallengeConfirmInteractor {
    
}
