//
//  HistoryInteractor.swift
//  TwoToo
//
//  Created by 박건우 on 2023/06/04.
//  Copyright (c) 2023 TwoToo. All rights reserved.
//

import Foundation

protocol HistoryBusinessLogic {
    /// 첫 진입
    func didLoad() async
    /// 챌린지 히스토리 클릭
    func didTapChallengeHistory(index: Int) async
    /// 설명서 클릭
    func didTapManualButton() async
}

protocol HistoryDataStore: AnyObject {
    var challengeList: History.Model.ChallengeList { get set }
}

final class HistoryInteractor: HistoryDataStore, HistoryBusinessLogic {

    var presenter: HistoryPresentationLogic
    var router: HistoryRoutingLogic
    var worker: HistoryWorkerProtocol
    
    init(
        presenter: HistoryPresentationLogic,
        router: HistoryRoutingLogic,
        worker: HistoryWorkerProtocol
    ) {
        self.presenter = presenter
        self.router = router
        self.worker = worker
    }
    
    // MARK: - DataStore
    var challengeList: History.Model.ChallengeList = []

}

// MARK: - Interactive Business Logic

extension HistoryInteractor {
    /// 외부 액션 옵저빙
    func observe() {
        
    }
}

// MARK: Feature (진입)
extension HistoryInteractor {
    func didLoad() async {
        do {
            // TODO: - 워커에서 데이터 받아 challengeList에 저장하기
            if challengeList.isEmpty {
                await self.presenter.presentEmpty()
            } else {
                await self.presenter.presentHistoryChallengeList(model: challengeList)
            }
        } catch {
            await self.presenter.presentHistoryError(model: error)
        }
    }
}

// MARK: Feature (챌린지 히스토리 이동)
extension HistoryInteractor {
    func didTapChallengeHistory(index: Int) async {
        let model = self.challengeList[index]
        await self.router.routeToChallengeHistoryScene(model: model)
    }
}

// MARK: Feature (설명서 이동)

extension HistoryInteractor {
    func didTapManualButton() async {
        await self.router.routeToManualScene()
    }
}
// MARK: - Application Business Logic

// MARK: UseCase ()

extension HistoryInteractor {
}
