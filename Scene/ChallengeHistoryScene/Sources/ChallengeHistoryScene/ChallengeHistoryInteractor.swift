//
//  ChallengeHistoryInteractor.swift
//  TwoToo
//
//  Created by 박건우 on 2023/06/04.
//  Copyright (c) 2023 TwoToo. All rights reserved.
//

import CoreKit

protocol ChallengeHistoryBusinessLogic {
    /// 첫 진입
    func didLoad() async
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
    /// 챌린지 상세
    var challenge: ChallengeHistory.Model.Challenge { get }
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
        challenge: ChallengeHistory.Model.Challenge
    ) {
        self.presenter = presenter
        self.router = router
        self.worker = worker
        self.challenge = challenge
    }
    
    // MARK: - DataStore
    
    var challenge: ChallengeHistory.Model.Challenge
}

// MARK: - Interactive Business Logic

extension ChallengeHistoryInteractor {
    
    /// 외부 액션 옵저빙
    func observe() {
        
    }
}

// MARK: Feature (진입)

extension ChallengeHistoryInteractor {
    
    func didLoad() async {
        
    }
}

// MARK: Feature (인증)

extension ChallengeHistoryInteractor {
    
    func didTapCertificate() async {
        
    }
}

// MARK: Feature (인증 상세)

extension ChallengeHistoryInteractor {
    
    func didSelectCertificate(certificateID: String) async {
        
    }
}

// MARK: Feature (챌린지 그만두기)

extension ChallengeHistoryInteractor {
    
    func didTapOptionButton() async {
        
    }
    
    func didTapOptionPopupQuitButton() async {
        
    }
    
    func didTapQuitPopupCancelButton() async {
        
    }
    
    func didTapQuitPopupBackground() async {
        
    }
    
    func didTapQuitPopupQuitButton() async {
        
    }
}

// MARK: Feature (뒤로가기)

extension ChallengeHistoryInteractor {
    
    func didTapBackButton() async {
        
    }
}

// MARK: - Application Business Logic

// MARK: UseCase ()

extension ChallengeHistoryInteractor {
    
}
