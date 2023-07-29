//
//  HomeInteractor.swift
//  TwoToo
//
//  Created by 박건우 on 2023/06/04.
//  Copyright (c) 2023 TwoToo. All rights reserved.
//

import CoreKit
import Foundation

protocol HomeBusinessLogic {
    /// 진입
    func didAppear() async
    /// 챌린지 시작하기 버튼 클릭
    func didTapChallengeStartButton() async
    /// 챌린지 확인하기 버튼 클릭
    func didTapChallengeConfirmButton() async
    /// 챌린지 완료 팝업의 배경 클릭
    func didTapChallengeCompletedPopupBackground() async
    /// 챌린지 완료 팝업의 확인 버튼 클릭
    func didTapChallengeCompletedPopupConfirmButton() async
    /// 챌린지 완료하기 버튼 클릭
    func didTapChallengeCompleteButton() async
    /// 둘다 인증 팝업의 배경 클릭
    func didTapBothCertificationPopupBackground() async
    /// 둘다 인증 팝업의 괜찮아요(no) 버튼 클릭
    func didTapBothCertificationPopupNoOption() async
    /// 둘다 인증 팝업의 칭찬하기(yes) 버튼 클릭
    func didTapBothCertificationPopupYesOption() async
    /// 내 칭찬 문구 클릭
    func didTapMyComplimentCommnet() async
    /// 내 꽃 클릭
    func didTapMyFlower() async
    /// 찌르기 버튼 클릭
    func didTapStickButton() async
    /// 챌린지 정보 클릭
    func didTapChallengeInfo() async
    /// 설명서 버튼 클릭하
    func didTapGuideButton() async
}

protocol HomeDataStore: AnyObject {
    /// 히스토리 화면 이동 트리거
    /// - Parameters:
    ///     - 업데이트 여부 `Bool`
    var didTriggerRouteToHistoryScene: PassthroughSubject<Bool, Never> { get }
    /// 화면 진입 트리거
    var didTriggerAppear: PassthroughSubject<Void, Never> { get }
    /// 챌린지
    var challenge: Home.Model.Challenge? { get set }
}

final class HomeInteractor: HomeDataStore, HomeBusinessLogic {
    var cancellables: Set<AnyCancellable> = []
    
    var presenter: HomePresentationLogic
    var router: HomeRoutingLogic
    var worker: HomeWorkerProtocol
    
    init(
        presenter: HomePresentationLogic,
        router: HomeRoutingLogic,
        worker: HomeWorkerProtocol,
        didTriggerRouteToHistoryScene: PassthroughSubject<Bool, Never>
    ) {
        self.presenter = presenter
        self.router = router
        self.worker = worker
        self.didTriggerRouteToHistoryScene = didTriggerRouteToHistoryScene
        
        self.observe()
    }
    
    // MARK: - DataStore
    
    var didTriggerRouteToHistoryScene: PassthroughSubject<Bool, Never>
    
    var didTriggerAppear: PassthroughSubject<Void, Never> = .init()
    
    var challenge: Home.Model.Challenge?
}

// MARK: - Interactive Business Logic

extension HomeInteractor {
    
    /// 외부 액션 옵저빙
    func observe() {
        
        self.didTriggerAppear
            .sink { [weak self] in
                guard let self = self else {
                    return
                }
                Task {
                    await self.didAppear()
                }
            }
            .store(in: &self.cancellables)
    }
}

// MARK: Feature (진입)

extension HomeInteractor {
    
    func didAppear() async {
        do {
            let homeInfo = try await self.worker.fetchHomeInfo()
            let challenge = homeInfo.challenge
            self.challenge = challenge
            
            switch challenge.status {
                case .created:
                    await self.presenter.presentChallengeCreated(challenge: challenge)
                    
                case .waiting:
                    await self.presenter.presentChallengeWaiting(challenge: challenge)
                    
                case .beforeStart:
                    await self.presenter.presentChallengeBeforeStart(challenge: challenge)
                    
                case .beforeStartDate:
                    await self.presenter.presentChallengeBeforeStartDate(challenge: challenge)
                    
                case .afterStartDate:
                    await self.presenter.presentChallengeAfterStartDate(challenge: challenge)
                    
                case let .inProgress(inProgress):
                    await self.presenter.presentChallengeInProgress(challenge: challenge)
                    
                    if inProgress == .bothCertificated(.uncomfirmed) {
                        await self.presenter.presentBothCertificationPopup()
                    }
                    
                case let .completed(completed):
                    await self.presenter.presentChallengeCompleted(challenge: challenge)
                    
                    if completed == .uncomfirmed {
                        await self.presenter.presentCompletedPopup(challenge: challenge)
                    }
            }
        }
        catch {
            await self.presenter.presentHomeError(error: error)
        }
    }
}

// MARK: Feature (챌린지 생성)

extension HomeInteractor {
    
    func didTapChallengeStartButton() async {
        guard let challenge = self.challenge else {
            return
        }
        switch challenge.status {
            case .created, .afterStartDate:
                await self.router.routeToChallengeEssentialInfoInputScene()
                
            default:
                break
        }
    }
    
    func didTapChallengeConfirmButton() async {
        guard let challenge = self.challenge else {
            return
        }
        switch challenge.status {
            case .waiting, .beforeStartDate:
                await self.router.routeToChallengeConfirmScene(entryPoint: "view")
                
            case .beforeStart:
                await self.router.routeToChallengeConfirmScene(entryPoint: "accept")
                
            default:
                break
        }
    }
}

// MARK: Feature (완료)

extension HomeInteractor {
    
    func didTapChallengeCompletedPopupBackground() async {
        self.worker.challengeCompletedConfirmed = true
        await self.presenter.dismissCompletedPopup()
    }
    
    func didTapChallengeCompletedPopupConfirmButton() async {
        self.worker.challengeCompletedConfirmed = true
        await self.presenter.dismissCompletedPopup()
    }
    
    func didTapChallengeCompleteButton() async {
        guard let challenge = self.challenge,
              let challengeID = challenge.id else {
            return
        }
        do {
            try await self.worker.requestChallengeComplete(challengeID: challengeID)
            self.didTriggerRouteToHistoryScene.send(true)
        }
        catch {
            await self.presenter.presentCompleteRequestError(error: error)
        }
    }
}

// MARK: Feature (칭찬)

extension HomeInteractor {
    
    func didTapBothCertificationPopupBackground() async {
        await self.presenter.dismissBothCertificationPopup()
    }
    
    func didTapBothCertificationPopupNoOption() async {
        await self.presenter.dismissBothCertificationPopup()
    }
    
    func didTapBothCertificationPopupYesOption() async {
        self.worker.bothCertificationConfirmed = true
        await self.presenter.dismissBothCertificationPopup()
        await self.router.routeToPraiseSendScene()
    }
    
    func didTapMyComplimentCommnet() async {
        if self.challenge?.myInfo.todayCert?.complimentComment?.isEmpty ?? true {
            await self.router.routeToPraiseSendScene()
        }
    }
}

// MARK: Feature (인증)

extension HomeInteractor {
    
    func didTapMyFlower() async {
        if self.challenge?.myInfo.todayCert == nil {
            await self.router.routeToChallengeCertificateScene()
        }
    }
}

// MARK: Feature (찌르기)

extension HomeInteractor {
    
    func didTapStickButton() async {
        guard let stickRemaining = self.challenge?.stickRemaining else {
            return
        }
        if stickRemaining > 0 {
            await self.router.routeToNudgeSendScene()
        }
        else {
            await self.presenter.presentExceededStickCountError()
        }
    }
}

// MARK: Feature (챌린지 히스토리)

extension HomeInteractor {
    
    func didTapChallengeInfo() async {
        await self.router.routeToChallengeHistoryScene()
    }
}

// MARK: Feature (설명서)

extension HomeInteractor {
    
    func didTapGuideButton() async {
        await self.router.routeToGuideScene()
    }
}

// MARK: - Application Business Logic

// MARK: UseCase ()

extension HomeInteractor {
    
}
