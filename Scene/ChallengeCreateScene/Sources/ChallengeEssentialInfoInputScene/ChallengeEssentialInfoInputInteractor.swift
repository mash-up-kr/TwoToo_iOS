//
//  ChallengeEssentialInfoInputInteractor.swift
//  TwoToo
//
//  Created by 박건우 on 2023/06/04.
//  Copyright (c) 2023 TwoToo. All rights reserved.
//

import CoreKit
import Foundation

protocol ChallengeEssentialInfoInputBusinessLogic {
    /// 첫 진입
    func didLoad() async
    /// 챌린지 이름 문구 입력
    func didEnterChallengeNameComment(comment: String) async
    /// 챌린지 추천 버튼 클릭
    func didTapChallengeRecommendationButton() async
    /// 시작일 선택
    func didTapStartDate(startDate: Date) async
    /// 종료일 선택
    func didTapEndDate(endDate: Date) async
    /// 챌린지 이름 데이터 입력됨
    func didUpdateChallengeName() async
    /// 시작일 데이터 입력됨
    func didUpdateStartDate() async
    /// 종료일 데이터 입력됨
    func didUpdateEndDate() async
    /// 다음 버튼 클릭
    func didTapNextButton() async
}

protocol ChallengeEssentialInfoInputDataStore: AnyObject {}

final class ChallengeEssentialInfoInputInteractor: ChallengeEssentialInfoInputDataStore, ChallengeEssentialInfoInputBusinessLogic {
    var cancellables: Set<AnyCancellable> = []
    
    var presenter: ChallengeEssentialInfoInputPresentationLogic
    var router: ChallengeEssentialInfoInputRoutingLogic
    var worker: ChallengeEssentialInfoInputWorkerProtocol
    
    init(
        presenter: ChallengeEssentialInfoInputPresentationLogic,
        router: ChallengeEssentialInfoInputRoutingLogic,
        worker: ChallengeEssentialInfoInputWorkerProtocol
    ) {
        self.presenter = presenter
        self.router = router
        self.worker = worker
    }
    
    // MARK: - DataStore

    var nameDataSource: String?
    var startDateDataSource: String?
    var endDateDataSource: String?
}

// MARK: - Interactive Business Logic

extension ChallengeEssentialInfoInputInteractor {
    
    /// 외부 액션 옵저빙
    func observe() {
        
    }
}

// MARK: Feature (진입)

extension ChallengeEssentialInfoInputInteractor {
    func didLoad() async {
        await self.presenter.presentDisabledNext()
    }
}

// MARK: Feature (챌린지 이름 설정)

extension ChallengeEssentialInfoInputInteractor {
    func didEnterChallengeNameComment(comment: String) async {
        nameDataSource = comment
    }

    func didTapChallengeRecommendationButton() async {

    }
}

// MARK: Feature (기간 설정)

extension ChallengeEssentialInfoInputInteractor {
    func didTapStartDate(startDate: Date) async {
        let endDateData = startDate + (86400 * 22)

        self.startDateDataSource = startDate.fullDateString(.yearMonthDay)
        self.endDateDataSource = endDateData.fullDateString(.yearMonthDay)
    }

    func didTapEndDate(endDate: Date) async {
        let startDateData = endDate + (86400 * 22)

        self.endDateDataSource = endDate.fullDateString(.yearMonthDay)

        self.startDateDataSource = startDateData.fullDateString(.yearMonthDay)
    }
}

// MARK: Feature (페이지 이동)

extension ChallengeEssentialInfoInputInteractor {
    func didUpdateChallengeName() async {
        // 값 있는지 확인
        // dataSource 활용
    }

    func didUpdateStartDate() async {
        // 값 있는지 확인
    }

    func didUpdateEndDate() async {
        // 값 있는지 확인
    }

    func didUpdateNextButton() async {
        /// enable 되도록 해야함
    }

    func didTapNextButton() async {
        /// 다음 화면으로 이동
    }
}

// MARK: - Application Business Logic

// MARK: UseCase ()

extension ChallengeEssentialInfoInputInteractor {
    
}
