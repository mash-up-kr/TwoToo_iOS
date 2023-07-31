//
//  MyInfoInteractor.swift
//  TwoToo
//
//  Created by 박건우 on 2023/06/04.
//  Copyright (c) 2023 TwoToo. All rights reserved.
//

import CoreKit
import Foundation

protocol MyInfoBusinessLogic {
    /// 첫 진입
    func didLoad() async
    /// 설명서 버튼 클릭
    func didTapGuideButton() async
    /// Lists에 있는 목록들 클릭
    func didTapMyInfoLists(index: Int) async
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
    
    enum MyInfoLists: Int {
        /// 공지사항
        case announcement
        /// 이용 가이드 및 설명서
        case userGuide
        /// 투투에 문의하기
        case inquery
        /// 만든이들
        case creators
        
        var url: URL? {
            switch self {
            case .announcement:
                return URL(string: "https://two2too2.github.io/personal.html")
            case .userGuide:
                return URL(string: "https://two2too2.github.io/")
            case .inquery:
                return URL(string: "https://docs.google.com/forms/d/e/1FAIpQLSeUGNUGzl3MnGUAIR-rtfgYYrDYRIoKh_Ozpd4prqA1qIBKRw/viewform?usp=sf_link")
            case .creators:
                return URL(string: "https://two2too2.github.io/creater.html")
            }
        }
    }
    
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
    /// 설명서 버튼 클릭했을 때
    func didTapGuideButton() async {
        guard let url = MyInfoLists.userGuide.url else { return }
        
        await self.router.routeToMyInfoListsScene(url: url)
    }

    /// 공지사항, 이용가이드, 투투에 문의하기, 만든이들 클릭했을 때
    func didTapMyInfoLists(index: Int) async {
        guard let url = MyInfoLists(rawValue: index)?.url else { return }
     
        await self.router.routeToMyInfoListsScene(url: url)
    }
}

// MARK: - Application Business Logic

// MARK: UseCase ()

extension MyInfoInteractor {
    
}
