//
//  FlowerSelectInteractor.swift
//  TwoToo
//
//  Created by 박건우 on 2023/06/04.
//  Copyright (c) 2023 TwoToo. All rights reserved.
//

import CoreKit
import Foundation

protocol FlowerSelectBusinessLogic {
    /// 첫진입
    func didLoad() async
    /// 꽃 선택
    func didTapFlower(flowerIndex: Int?) async
    /// 챌린지 버튼 클릭
    func didTapButton() async
}

protocol FlowerSelectDataStore: AnyObject {
    /// 챌린지 생성완료 화면 이동 트리거
    var didTriggerChallengeCreateScene: PassthroughSubject<Void, Never> { get }
    /// 홈 화면 이동 트리거
    var didTriggerRouteToHomeScene: PassthroughSubject<Void, Never> { get }
    /// 챌린지명
    var nameDataSource: String? { get }
    /// 챌린지 시작일
    var startDateDataSource: String? { get }
    /// 챌린지 마감일
    var endDateDataSource: String? { get }
    /// 챌린지 규칙
    var additionalInfoDataSource: String? { get }
    /// 챌린지 ID
    var challengeID: String? { get }

    /// 진입점 상태
    var enterSceneStatus: String { get }
    /// 선택된 꽃
    var selectedFlower: String { get }
}

final class FlowerSelectInteractor: FlowerSelectDataStore, FlowerSelectBusinessLogic {

    var cancellables: Set<AnyCancellable> = []
    
    var presenter: FlowerSelectPresentationLogic
    var router: FlowerSelectRoutingLogic
    var worker: FlowerSelectWorkerProtocol
    
    init(
        presenter: FlowerSelectPresentationLogic,
        router: FlowerSelectRoutingLogic,
        worker: FlowerSelectWorkerProtocol,
        didTriggerChallengeCreateScene: PassthroughSubject<Void, Never>,
        didTriggerRouteToHomeScene: PassthroughSubject<Void, Never>,
        enterSceneStatus: String,
        nameDataSource: String?,
        startDateDataSource: String?,
        endDateDataSource: String?,
        additionalInfoDataSource: String?,
        challengeID: String?
    ) {
        self.presenter = presenter
        self.router = router
        self.worker = worker
        self.didTriggerChallengeCreateScene = didTriggerChallengeCreateScene
        self.didTriggerRouteToHomeScene = didTriggerRouteToHomeScene
        self.enterSceneStatus = enterSceneStatus
        self.nameDataSource = nameDataSource
        self.startDateDataSource = startDateDataSource
        self.endDateDataSource = endDateDataSource
        self.additionalInfoDataSource = additionalInfoDataSource
        self.challengeID = challengeID
    }
    
    // MARK: - DataStore

    var didTriggerChallengeCreateScene: PassthroughSubject<Void, Never>

    var didTriggerRouteToHomeScene: PassthroughSubject<Void, Never>
    
    var enterSceneStatus: String
    var selectedFlower: String = ""
    var nameDataSource: String?
    var startDateDataSource: String?
    var endDateDataSource: String?
    var additionalInfoDataSource: String?
    var challengeID: String?
    
    enum EnterSceneStatus: String {
        case create = "create"
        case accept = "accept"
    }
}

// MARK: - Interactive Business Logic

extension FlowerSelectInteractor {
    
    /// 외부 액션 옵저빙
    func observe() {
        
    }
}

// MARK: Feature (진입)

extension FlowerSelectInteractor {
    func didLoad() async {
        let status = EnterSceneStatus(rawValue: self.enterSceneStatus)

        enterSceneStatus = status?.rawValue ?? "create"

        switch status {
        case .create:
            await self.presenter.presentCreateScene(model: .init(isHidden: true, title: .create))
            await self.presenter.presentFlowers()
        case .accept:
            await self.presenter.presentAceeptScene(model: .init(isHidden: true, title: .accpet))
            await self.presenter.presentFlowers()
        case .none:
            await self.presenter.presentCreateScene(model: .init(isHidden: true, title: .create))
            await self.presenter.presentFlowers()
        }
    }
}

// MARK: Feature (꽃선택)
extension FlowerSelectInteractor {
    func didTapFlower(flowerIndex: Int?) async {

        guard let flower = Flower(rawValue: flowerIndex ?? 0) else { return }

        selectedFlower = flower.name

        await self.presenter.selectFlower(model: .init(indexPath: flowerIndex))
    }
}

// MARK: Feature (챌린지 생성, 시작)
extension FlowerSelectInteractor {
    func didTapButton() async {

        do {
            if self.enterSceneStatus == "accept" {
                guard let challengeID = self.challengeID else {
                    return
                }
                try await self.worker.requestChallengeApprove(challengeID: challengeID, user1Flower: self.selectedFlower.uppercased())
                await self.router.routeToRootScene()
            }
            else {
                guard let startData = self.startDateDataSource?.fullStringDate(.yearMonthDay).dateToString(.iso) else { return }
                
                try await self.worker.requestChallengeCreate(name: self.nameDataSource ?? "", description: self.additionalInfoDataSource ?? "", user2Flower: self.selectedFlower.uppercased(), startDate: startData)
                await self.router.routeToChallengeCreateFinishScene()
            }
        }
        catch {
            await self.presenter.presentStartChallengeError(error: error)
        }
    }
}

// MARK: - Application Business Logic

// MARK: UseCase ()

extension FlowerSelectInteractor {
    
}
