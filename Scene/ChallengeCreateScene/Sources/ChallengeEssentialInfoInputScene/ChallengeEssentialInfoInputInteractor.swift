//
//  ChallengeEssentialInfoInputInteractor.swift
//  TwoToo
//
//  Created by 박건우 on 2023/06/04.
//  Copyright (c) 2023 TwoToo. All rights reserved.
//

import CoreKit

protocol ChallengeEssentialInfoInputBusinessLogic {
    /// 첫 진입
    func didLoad() async
    /// 챌린지 이름 문구 입력
    func didEnterChallengeNameComment(comment: String) async
    /// 챌린지 추천 버튼 클릭
    func didTapChallengeRecommendationButton() async
    /// 시작일 데이터 피커 클릭
    func didTapStartDatePicker() async
    /// 시작일 선택
    func didTapStartDate(startDate: String) async
    /// 종료일 데이터 피커 클릭
    func didTapEndDatePicker() async
    /// 종료일 선택
    func didTapEndDate(startDate: String) async
    /// 챌린지 이름 데이터 입력됨
    func didUpdateChallengeName() async
    /// 시작일 데이터 입력됨
    func didUpdateStartDate() async
    /// 종료일 데이터 입력됨
    func didUpdateEndDate() async
    /// 다음 버튼 활성화
    func didUpdateNextButton() async
    /// 다음 버튼 클릭
    func didTapNextButton(
        name: ChallengeEssentialInfoInput.ViewModel.Name,
        date: ChallengeEssentialInfoInput.ViewModel.Date) async
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
        worker: ChallengeEssentialInfoInputWorkerProtocol,
        didTriggerNextButton : PassthroughSubject<[String: String], Never>
    ) {
        self.presenter = presenter
        self.router = router
        self.worker = worker
        self.didTriggerNextButton = didTriggerNextButton
    }
    
    // MARK: - DataStore

    var didTriggerNextButton: PassthroughSubject<[String: String], Never>
    
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
//        await self.presenter.
    }
}

// MARK: Feature (챌린지 이름 설정)

extension ChallengeEssentialInfoInputInteractor {
    func didEnterChallengeNameComment(comment: String) async {

    }

    func didTapChallengeRecommendationButton() async {

    }
}

// MARK: Feature (기간 설정)

extension ChallengeEssentialInfoInputInteractor {
    func didTapStartDatePicker() async {

    }

    func didTapStartDate(startDate: String) async {

    }

    func didTapEndDatePicker() async {

    }

    func didTapEndDate(startDate: String) async {

    }
}

// MARK: Feature (페이지 이동)

extension ChallengeEssentialInfoInputInteractor {
    func didUpdateChallengeName() async {

    }

    func didUpdateStartDate() async {

    }

    func didUpdateEndDate() async {

    }

    func didUpdateNextButton() async {

    }

    func didTapNextButton(
        name: ChallengeEssentialInfoInput.ViewModel.Name,
        date: ChallengeEssentialInfoInput.ViewModel.Date
    ) async {
        self.didTriggerNextButton.send(
            [name.title : name.text, date.startTitle : date.startDate, date.endTitle : date.endDate]
        )

        /// 다음 화면으로 이동

    }
}

// MARK: - Application Business Logic

// MARK: UseCase ()

extension ChallengeEssentialInfoInputInteractor {
    
}
