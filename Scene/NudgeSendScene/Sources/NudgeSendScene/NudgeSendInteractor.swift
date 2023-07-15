//
//  NudgeSendInteractor.swift
//  TwoToo
//
//  Created by 박건우 on 2023/06/04.
//  Copyright (c) 2023 TwoToo. All rights reserved.
//

import CoreKit

protocol NudgeSendBusinessLogic {
    /// 첫 진입
    func didLoad() async
    /// 찌르기 문구 입력
    func didEnterNudgeComment(comment: String) async
    /// 보내기 버튼 클릭
    func didTapSendButton() async
}

protocol NudgeSendDataStore: AnyObject {
    /// 찌르기 문구
    var nudgeComment: String { get set }
    /// 남은 찌르기 횟수
    var remainingNudgeCount: Int { get }
}

final class NudgeSendInteractor: NudgeSendDataStore, NudgeSendBusinessLogic {
    var cancellables: Set<AnyCancellable> = []
    
    var presenter: NudgeSendPresentationLogic
    var router: NudgeSendRoutingLogic
    var worker: NudgeSendWorkerProtocol
    
    init(
        presenter: NudgeSendPresentationLogic,
        router: NudgeSendRoutingLogic,
        worker: NudgeSendWorkerProtocol,
        remainingNudgeCount: Int
    ) {
        self.presenter = presenter
        self.router = router
        self.worker = worker
        self.remainingNudgeCount = remainingNudgeCount
    }
    
    // MARK: - DataStore
    
    var nudgeComment: String = ""
    
    private func updateNudgeComment(nudgeComment: String) async {
        self.nudgeComment = nudgeComment
    }
    
    var remainingNudgeCount: Int
}

// MARK: - Interactive Business Logic

extension NudgeSendInteractor {
    
    /// 외부 액션 옵저빙
    func observe() {
        
    }
}

// MARK: Feature (진입)

extension NudgeSendInteractor {
    
    func didLoad() async {
        
    }
}

// MARK: Feature (찌르기 문구 작성)

extension NudgeSendInteractor {
    
    func didEnterNudgeComment(comment: String) async {
        
    }
}

// MARK: Feature (찌르기)

extension NudgeSendInteractor {
    
    func didTapSendButton() async {
        
    }
}

// MARK: - Application Business Logic

// MARK: UseCase ()

extension NudgeSendInteractor {
    
}
