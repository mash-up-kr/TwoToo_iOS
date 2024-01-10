//
//  ChallengeHistoryInteractor.swift
//  TwoToo
//
//  Created by 박건우 on 2023/06/04.
//  Copyright (c) 2023 TwoToo. All rights reserved.
//

import CoreKit

protocol ChallengeHistoryBusinessLogic {
    /// 진입
    func didAppear() async
    /// 인증하기 버튼 클릭
    func didTapCertificate() async
    /// 인증 선택
    func didSelectCertificate(certificateID: String) async
    /// 옵션 버튼 클릭
    func didTapOptionButton() async
    /// 옵션 팝업의 챌린지 그만두기 버튼 클릭
    func didTapOptionPopupQuitButton() async
    /// 챌린지 그만두기 팝업의 취소 버튼 클릭
    func didTapQuitPopupCancelButton() async
    /// 챌린지 그만두기 팝업의 배경 클릭
    func didTapQuitPopupBackground() async
    /// 챌린지 그만두기 팝업의 그만두기 버튼 클릭
    func didTapQuitPopupQuitButton() async
    /// 뒤로가기 버튼 클릭
    func didTapBackButton() async
}

protocol ChallengeHistoryDataStore: AnyObject {
    /// 챌린지 ID
    var challengeID: String { get }
    /// 챌린지 상세
    var challenge: ChallengeHistory.Model.Challenge? { get }
    /// 내 닉네임
    var myNickname: String? { get }
    /// 파트너 닉네임
    var partnerNickname: String? { get }
}

final class ChallengeHistoryInteractor: ChallengeHistoryDataStore, ChallengeHistoryBusinessLogic {
    var cancellables: Set<AnyCancellable> = []
    
    var presenter: ChallengeHistoryPresentationLogic
    var router: ChallengeHistoryRoutingLogic
    var worker: ChallengeHistoryWorkerProtocol
    
    init(
        presenter: ChallengeHistoryPresentationLogic,
        router: ChallengeHistoryRoutingLogic,
        worker: ChallengeHistoryWorkerProtocol,
        challengeID: String
    ) {
        self.presenter = presenter
        self.router = router
        self.worker = worker
        self.challengeID = challengeID
    }
    
    // MARK: - DataStore
    
    var challengeID: String
    
    var challenge: ChallengeHistory.Model.Challenge?
    
    var myNickname: String? {
        self.worker.myNickname
    }
    
    var partnerNickname: String? {
        self.worker.partnerNickname
    }
}

// MARK: - Interactive Business Logic

extension ChallengeHistoryInteractor {
    
    /// 외부 액션 옵저빙
    func observe() {
        
    }
}

// MARK: Feature (진입)

extension ChallengeHistoryInteractor {
    
    func didAppear() async {
        do {
            let challenge = try await self.worker.requestChallengeDetailInquiry(challengeID: self.challengeID)
            self.challenge = challenge
            await self.presenter.presentChallenge(challenge: challenge)
        }
        catch {
            //
        }
    }
}

// MARK: Feature (인증)

extension ChallengeHistoryInteractor {
    
    func didTapCertificate() async {
        await self.router.routeToChallengeCertificateScene()
    }
}

// MARK: Feature (인증 상세)

extension ChallengeHistoryInteractor {
    
    func didSelectCertificate(certificateID: String) async {
        guard let challenge = self.challenge else {
            return
        }
        
        let myCertificate = challenge.myInfo.certificates
            .filter {
                $0.id == certificateID
            }.first
        let partnerCertificate = challenge.partnerInfo.certificates
            .filter {
                $0.id == certificateID
            }.first
        
        if let myCertificate = myCertificate {
            await self.router.routeToChallengeHistoryDetailScene(title: challenge.name,
                                                                 certificate: myCertificate,
                                                                 nickname: self.worker.myNickname ?? "",
                                                                 partnerNickname: self.worker.partnerNickname ?? "", isMyHistoryDetail: true)
        }
        else if let partnerCertificate = partnerCertificate {
            await self.router.routeToChallengeHistoryDetailScene(title: challenge.name,
                                                                 certificate: partnerCertificate,
                                                                 nickname: self.worker.partnerNickname ?? "",
                                                                 partnerNickname: self.worker.myNickname ?? "", isMyHistoryDetail: false)
        }
    }
}

// MARK: Feature (챌린지 그만두기)

extension ChallengeHistoryInteractor {
    
    func didTapOptionButton() async {
        await self.presenter.presentOptionPopup()
    }
    
    func didTapOptionPopupQuitButton() async {
        await self.presenter.presentQuitPopup()
    }
    
    func didTapQuitPopupCancelButton() async {
        await self.presenter.dismissQuitPopup()
    }
    
    func didTapQuitPopupBackground() async {
        await self.presenter.dismissQuitPopup()
    }
    
    func didTapQuitPopupQuitButton() async {
        do {
            try await self.worker.requestChallengeQuit(challengeID: self.challengeID)
            await self.presenter.presentChallengeQuitSuccess()
            await self.router.dismiss()
        }
        catch {
            await self.presenter.presentChallengeQuitError(error: error)
        }
    }
}

// MARK: Feature (뒤로가기)

extension ChallengeHistoryInteractor {
    
    func didTapBackButton() async {
        await self.router.dismiss()
    }
}

// MARK: - Application Business Logic

// MARK: UseCase ()

extension ChallengeHistoryInteractor {
    
}
