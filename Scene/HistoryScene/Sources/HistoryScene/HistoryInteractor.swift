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
            let challengeList = try await self.fetchHistory()
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
    func fetchHistory() async throws -> History.Model.ChallengeList {
        do {
            // TODO: - worker에서 데이터 가져오기
            // 더미 데이터 넣음
            let currentDate = Date()
            let startDate = currentDate
            let calendar = Calendar.current
            let endDate = calendar.date(byAdding: .day, value: 7, to: currentDate)!
            return [.init(id: "132",
                          order: 2,
                          name: "30분 게임하기",
                          startDate: startDate,
                          endDate: endDate,
                          myInfo: .init(id: "123",
                                        nickname: "나ㅏ",
                                        flower: .camellia,
                                        certificates: [.init(id: "ㄴㄹㅇ", certificateImageUrl: "ㄴㅇㄹ", certificateComment: "ㅍㅇㅌ", certificateTime: startDate)]),
                          partnerInfo: .init(id: "sdfdsf", nickname: "왕쟈", flower: .chrysanthemum,
                                             certificates: [.init(id: "dfsf", certificateImageUrl: "fsdsdf", certificateComment: "dfsdf", certificateTime: endDate)]))]
        } catch {
            throw error
        }
    }
}
