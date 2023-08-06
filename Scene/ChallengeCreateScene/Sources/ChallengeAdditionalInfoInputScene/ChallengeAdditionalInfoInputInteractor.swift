//
//  ChallengeAdditionalInfoInputInteractor.swift
//  TwoToo
//
//  Created by 박건우 on 2023/06/04.
//  Copyright (c) 2023 TwoToo. All rights reserved.
//

import CoreKit

protocol ChallengeAdditionalInfoInputBusinessLogic {
    /// 챌린지 추가 정보 입력
    func didEnterChallengeAdditionalInfo(commet: String) async
    /// 다음 버튼 클릭
    func didTapNextButton() async
}

protocol ChallengeAdditionalInfoInputDataStore: AnyObject {
    /// 챌린지명
    var nameDataSource: String? { get }
    /// 챌린지 시작일
    var startDateDataSource: String? { get }
    /// 챌린지 마감일
    var endDateDataSource: String? { get }
    /// 챌린지 규칙
    var additionalInfoDataSource: String? { get }
    /// 진입점 상태
    var didEnterStatus: String? { get }
}

final class ChallengeAdditionalInfoInputInteractor: ChallengeAdditionalInfoInputDataStore, ChallengeAdditionalInfoInputBusinessLogic {

    var cancellables: Set<AnyCancellable> = []
    
    var presenter: ChallengeAdditionalInfoInputPresentationLogic
    var router: ChallengeAdditionalInfoInputRoutingLogic
    var worker: ChallengeAdditionalInfoInputWorkerProtocol
    
    init(
        presenter: ChallengeAdditionalInfoInputPresentationLogic,
        router: ChallengeAdditionalInfoInputRoutingLogic,
        worker: ChallengeAdditionalInfoInputWorkerProtocol,
        nameDataSource: String,
        startDateDataSource: String,
        endDateDataSource: String
    ) {
        self.presenter = presenter
        self.router = router
        self.worker = worker
        self.nameDataSource = nameDataSource
        self.startDateDataSource = startDateDataSource
        self.endDateDataSource = endDateDataSource
    }
    
    // MARK: - DataStore

    /// 챌린지 추가 입력(규칙 등)  문구
    var additionalInfoDataSource: String?

    var nameDataSource: String?
    var startDateDataSource: String?
    var endDateDataSource: String?
    var didEnterStatus: String? = "create"
}

// MARK: - Interactive Business Logic

extension ChallengeAdditionalInfoInputInteractor {
    
    /// 외부 액션 옵저빙
    func observe() {
        
    }
}

// MARK: Feature (챌린지 추가정보 설정)

extension ChallengeAdditionalInfoInputInteractor {
    func didEnterChallengeAdditionalInfo(commet: String) async {
        self.additionalInfoDataSource = commet
    }
}

// MARK: Feature (페이지 이동)

extension ChallengeAdditionalInfoInputInteractor {

    func didTapNextButton() async {
        await self.router.routeToChallengeConfirmScene()
    }
}

// MARK: - Application Business Logic

// MARK: UseCase ()

extension ChallengeAdditionalInfoInputInteractor {
    
}
