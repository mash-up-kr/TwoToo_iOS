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
    /// 진입
    func didAppear() async
    /// 설명서 버튼 클릭
    func didTapGuideButton() async
    /// Lists에 있는 목록들 클릭
    func didTapMyInfoLists(index: Int) async
    /// 회원 탈퇴 팝업의 탈퇴하기 버튼 클릭
    func didTapSignoutPopupSignOutButton() async
    /// 회원 탈퇴 팝업의 취소 버튼 클릭
    func didTapSignOutPopupCancelButton() async
    /// 회원 탈퇴 완료 확인 버튼 클릭
    func didTapSignOutCompleteConfirmButton() async
    /// 회원탈퇴 팝업의 배경 클릭
    func didTapSignOutPopupBackground() async
    /// 회원 탈퇴 완료 팝업의 배경 클릭
    func didTapSignOutCompletePopupBackground() async
    /// 닉네임 변경 버튼을 클릭
    func didTapChangeNicknameButton() async
}

protocol MyInfoDataStore: AnyObject {
    /// 로그인 화면 이동 트리거
    var didTriggerRouteToLoginScene: PassthroughSubject<Void, Never> { get }
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
        didTriggerRouteToLoginScene: PassthroughSubject<Void, Never>
    ) {
        self.presenter = presenter
        self.router = router
        self.worker = worker
        self.didTriggerRouteToLoginScene = didTriggerRouteToLoginScene
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
        /// 로그아웃
        case logout
        /// 회원탈퇴
        case singout
        
        var url: URL? {
            switch self {
            case .announcement:
                return URL(string: "https://two2too2.github.io/personal.html")
            case .userGuide:
                return URL(string: "https://two2too2.github.io/")
            case .inquery:
                return URL(string: "https://docs.google.com/forms/d/e/1FAIpQLSeUGNUGzl3MnGUAIR-rtfgYYrDYRIoKh_Ozpd4prqA1qIBKRw/viewform?usp=sf_link")
            case .creators:
                return URL(string: "https://twotoo-landing.vercel.app/makers")
            case .logout:
                return nil
            case .singout:
                return nil
            }
        }
    }
    
    var didTriggerRouteToLoginScene: PassthroughSubject<Void, Never>
}

// MARK: - Interactive Business Logic

extension MyInfoInteractor {
    
    /// 외부 액션 옵저빙
    func observe() {
    }
}

// MARK: Feature (진입)

extension MyInfoInteractor {
    
    func didAppear() async {
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
        let myInfo = MyInfoLists(rawValue: index)
        
        if myInfo == .logout {
            await self.worker.logout()
            self.didTriggerRouteToLoginScene.send(())
        }
        
        if myInfo == .singout {
            await self.presenter.presentSignOutPopup()
            return
        }
        
        guard let url = myInfo?.url else { return }
        
        await self.router.routeToMyInfoListsScene(url: url)
    }
}

// MARK: Feature (회원 탈퇴)

extension MyInfoInteractor {
    func didTapSignoutPopupSignOutButton() async {
        do {
            try await self.worker.signOut()
            await self.presenter.dismissSignOutPopup()
            await self.presenter.presentSignOutCompletePopup()
        }
        catch {
            await self.presenter.presentSignOutError(error: error)
        }
    }
    
    func didTapSignOutPopupCancelButton() async {
        await self.presenter.dismissSignOutPopup()
    }
    
    func didTapSignOutCompleteConfirmButton() async {
        await self.presenter.dismissSignOutCompletePopup()
        self.didTriggerRouteToLoginScene.send(())
    }
    
    func didTapSignOutPopupBackground() async {
        await self.presenter.dismissSignOutPopup()
    }
    
    func didTapSignOutCompletePopupBackground() async {
        await self.presenter.dismissSignOutCompletePopup()
        self.didTriggerRouteToLoginScene.send(())

    }
}

// MARK: Feature (닉네임 변경)

extension MyInfoInteractor {
    func didTapChangeNicknameButton() async {
        await self.router.routeToChangeNicknameScene()
    }
}

// MARK: - Application Business Logic

// MARK: UseCase ()

extension MyInfoInteractor {
    
}
