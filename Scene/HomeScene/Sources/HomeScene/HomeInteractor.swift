//
//  HomeInteractor.swift
//  TwoToo
//
//  Created by 박건우 on 2023/06/04.
//  Copyright (c) 2023 TwoToo. All rights reserved.
//

import CoreKit

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
    }
    
    // MARK: - DataStore
    
    var didTriggerRouteToHistoryScene: PassthroughSubject<Bool, Never>
    
    var challenge: Home.Model.Challenge?
}

// MARK: - Interactive Business Logic

extension HomeInteractor {
    
    /// 외부 액션 옵저빙
    func observe() {
        
    }
}

// MARK: Feature (진입)

extension HomeInteractor {
    
    func didAppear() async {
        
    }
}

// MARK: Feature (챌린지 생성)

extension HomeInteractor {
    
    func didTapChallengeStartButton() async {
        
    }
    
    func didTapChallengeConfirmButton() async {
        
    }
}

// MARK: Feature (완료)

extension HomeInteractor {
    
    func didTapChallengeCompletedPopupBackground() async {
        
    }
    
    func didTapChallengeCompletedPopupConfirmButton() async {
        
    }
    
    func didTapChallengeCompleteButton() async {
        
    }
}

// MARK: Feature (칭찬)

extension HomeInteractor {
    
    func didTapBothCertificationPopupBackground() async {
        
    }
    
    func didTapBothCertificationPopupNoOption() async {
        
    }
    
    func didTapBothCertificationPopupYesOption() async {
        
    }
    
    func didTapMyComplimentCommnet() async {
        
    }
}

// MARK: Feature (인증)

extension HomeInteractor {
    
    func didTapMyFlower() async {
        
    }
}

// MARK: Feature (찌르기)

extension HomeInteractor {
    
    func didTapStickButton() async {
        
    }
}

// MARK: Feature (챌린지 히스토리)

extension HomeInteractor {
    
    func didTapChallengeInfo() async {
        
    }
}

// MARK: Feature (설명서)

extension HomeInteractor {
    
    func didTapGuideButton() async {
        
    }
}

// MARK: - Application Business Logic

// MARK: UseCase ()

extension HomeInteractor {
    
}
