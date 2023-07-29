//
//  MyInfoInteractor.swift
//  TwoToo
//
//  Created by 박건우 on 2023/06/04.
//  Copyright (c) 2023 TwoToo. All rights reserved.
//

import CoreKit

protocol MyInfoBusinessLogic {
    /// 첫 진입
    func didLoad() async
    /// 설명서 버튼 클릭
    func didTapGuideButton() async
    /// Lists에 있는 목록들 클릭
    func didTapLists(index: Int) async
}

protocol MyInfoDataStore: AnyObject {
    /// 화면 진입 트리거
       var didTriggerAppear: PassthroughSubject<Void, Never> { get }
}

final class MyInfoInteractor: MyInfoDataStore, MyInfoBusinessLogic {

    var cancellables: Set<AnyCancellable> = []
    
    var presenter: MyInfoPresentationLogic
    var router: MyInfoRoutingLogic
    var worker: MyInfoWorkerProtocol
    
    init(
        presenter: MyInfoPresentationLogic,
        router: MyInfoRoutingLogic,
        worker: MyInfoWorkerProtocol,
        didTriggerAppear: PassthroughSubject<Void, Never>
    ) {
        self.presenter = presenter
        self.router = router
        self.worker = worker
        self.didTriggerAppear = didTriggerAppear
    }
    
    // MARK: - DataStore
    
    /// 화면 진입 트리거
    var didTriggerAppear: PassthroughSubject<Void, Never> = .init()
}

// MARK: - Interactive Business Logic

extension MyInfoInteractor {
    
    /// 외부 액션 옵저빙
    func observe() {
        self.didTriggerAppear
            .sink { [weak self] in
                guard let self = self else { return }
                
                Task {
                    await self.didLoad()
                }
            }
            .store(in: &self.cancellables)
    }
}

// MARK: Feature (첫 진입)

extension MyInfoInteractor {

    func didLoad() async {
        do {
            let mypageInfo = try await self.worker.fetchMypageInfo()
            
            await self.presenter.presentMyInfo(model: .init(myNickname: mypageInfo.myNickname, partnerNickname: mypageInfo.partnerNickname, challengeTotalCount: mypageInfo.challengeTotalCount))
        }
        catch  {
            await self.presenter.presentMyInfoError(error: error)
        }
    }
}

// MARK: Feature (페이지 이동)

extension MyInfoInteractor {
    func didTapGuideButton() async {
        await self.router.routeToGuideScene()
    }

    func didTapLists(index: Int) async {

        switch index {
        case 0:
            await self.router.routeToAnnouncementScene()
        case 1:
            await self.router.routeToUserGuideScene()
        case 2:
            await self.router.routeToInqueryScene()
        case 3:
            await self.router.routeToCreatorsScene()
        default:
            await self.router.routeToAnnouncementScene()
        }
    }
}

// MARK: - Application Business Logic

// MARK: UseCase ()

extension MyInfoInteractor {
    
}
