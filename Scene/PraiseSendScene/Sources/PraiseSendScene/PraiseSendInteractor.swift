//
//  PraiseSendInteractor.swift
//  TwoToo
//
//  Created by 박건우 on 2023/06/04.
//  Copyright (c) 2023 TwoToo. All rights reserved.
//

import CoreKit

protocol PraiseSendBusinessLogic {
    /// 칭찬 문구 입력
    func didEnterPraiseComment(comment: String) async
    /// 보내기 버튼 클릭
    func didTapSendButton() async
}

protocol PraiseSendDataStore: AnyObject {
    /// 칭찬 문구
    var praiseComment: String { get set }
}

final class PraiseSendInteractor: PraiseSendDataStore, PraiseSendBusinessLogic {
    var cancellables: Set<AnyCancellable> = []
    
    var presenter: PraiseSendPresentationLogic
    var router: PraiseSendRoutingLogic
    var worker: PraiseSendWorkerProtocol
    
    init(
        presenter: PraiseSendPresentationLogic,
        router: PraiseSendRoutingLogic,
        worker: PraiseSendWorkerProtocol
    ) {
        self.presenter = presenter
        self.router = router
        self.worker = worker
    }
    
    // MARK: - DataStore
    
    var praiseComment: String = ""
    
    private func updatePraiseComment(praiseComment: String) async {
        self.praiseComment = praiseComment
    }
}

// MARK: - Interactive Business Logic

extension PraiseSendInteractor {
    
    /// 외부 액션 옵저빙
    func observe() {
        
    }
}

// MARK: Feature (칭찬 문구 작성)

extension PraiseSendInteractor {
    
    func didEnterPraiseComment(comment: String) async {
        
    }
}

// MARK: Feature (칭찬하기)

extension PraiseSendInteractor {
    
    func didTapSendButton() async {
        
    }
}

// MARK: - Application Business Logic

// MARK: UseCase ()

extension PraiseSendInteractor {
    
}
