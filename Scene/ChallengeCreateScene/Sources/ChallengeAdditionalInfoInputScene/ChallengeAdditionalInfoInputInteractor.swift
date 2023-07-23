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

protocol ChallengeAdditionalInfoInputDataStore: AnyObject {}

final class ChallengeAdditionalInfoInputInteractor: ChallengeAdditionalInfoInputDataStore, ChallengeAdditionalInfoInputBusinessLogic {
    var cancellables: Set<AnyCancellable> = []
    
    var presenter: ChallengeAdditionalInfoInputPresentationLogic
    var router: ChallengeAdditionalInfoInputRoutingLogic
    var worker: ChallengeAdditionalInfoInputWorkerProtocol
    
    init(
        presenter: ChallengeAdditionalInfoInputPresentationLogic,
        router: ChallengeAdditionalInfoInputRoutingLogic,
        worker: ChallengeAdditionalInfoInputWorkerProtocol
    ) {
        self.presenter = presenter
        self.router = router
        self.worker = worker
    }
    
    // MARK: - DataStore
    var additionalInfoDataSource: String?
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

    // TODO: - 화면 이동 시 구현
    func didTapNextButton() async {

    }
}

// MARK: - Application Business Logic

// MARK: UseCase ()

extension ChallengeAdditionalInfoInputInteractor {
    
}
