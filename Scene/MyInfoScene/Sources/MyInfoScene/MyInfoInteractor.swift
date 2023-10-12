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
    /// 회원 탈퇴 팝업의 탈퇴하기 버튼 클릭
    func didTapSignoutPopupSignOutButton() async
    /// 회원 탈퇴 팝업의 취소 버튼 클릭
    func didTapSignOutPopupCancelButton() async
    /// 회원 탈퇴 완료 확인 버튼 클릭
    func didTapSignOutCompleteConfirmButton() async
    /// 회원 탈퇴 취소 팝업의 탈퇴 취소 버튼 클릭
    func didTapCancelSignOutCancelButton() async
    /// 회원 탈퇴 취소 팝업의 아니요 버튼 클릭
    func didTapSignOutCancelCompleteNobutton() async
    /// 회원 탈퇴 취소 완료의 확인 버튼 클릭
    func didTapSignOutCancelCompleteConfirmButton() async
    /// 회원탈퇴 팝업의 배경 클릭
    func didTapSignOutPopupBackground() async
    /// 회원 탈퇴 완료 팝업의 배경 클릭
    func didTapSignOutCompletePopupBackground() async
    /// 회원 탈퇴 취소하기 팝업의 배경 클릭
    func didTapSignOutCancelPopupBackground() async
    /// 회원 탈퇴 취소 완료 팝업의 배경 클릭
    func didTapSignOutCancelCompletePopupBackground() async
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
                return URL(string: "https://two2too2.github.io/creater.html")
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
        let myInfo = MyInfoLists(rawValue: index)
        
        if myInfo == .logout {
            await self.worker.logout()
            self.didTriggerRouteToLoginScene.send(())
        }

        if myInfo == .singout {
            let socailLoginType = self.worker.fetchSocialLoginType()

            if socailLoginType == .appleLogin {
                try? await self.worker.retryAppleLogin()

                let isSingOutRequired = self.worker.fetchAppleSignOutStatus()
                // true면 회원탈퇴 신청한 상태 false면 회원탈퇴 신청전 상태
                if isSingOutRequired {
                    await self.presenter.presentSignOutCancelPopup()
                } else {
                    await self.presenter.presentSignOutPopup()
                }
            }
            else if socailLoginType == .kakaoLogin {
                let isSingOutRequired = self.worker.fetchKakaoSignOutStatus()
                // true면 회원탈퇴 신청한 상태 false면 회원탈퇴 신청전 상태
                if isSingOutRequired {
                    await self.presenter.presentSignOutCancelPopup()

                } else {
                    await self.presenter.presentSignOutPopup()
                }
            }
        }
        
        guard let url = myInfo?.url else { return }
     
        await self.router.routeToMyInfoListsScene(url: url)
    }
}

// MARK: Feature (회원 탈퇴)

extension MyInfoInteractor {
    func didTapSignoutPopupSignOutButton() async {
        await self.presenter.dismissSignOutPopup()
        await self.presenter.presentSignOutCompletePopup()
    }

    func didTapSignOutPopupCancelButton() async {
        await self.presenter.dismissSignOutPopup()
    }

    func didTapSignOutCompleteConfirmButton() async {
        await self.presenter.dismissSignOutCompletePopup()
        self.worker.setSignoutStatus(required: true, socialType: self.worker.fetchSocialLoginType())
    }

    func didTapCancelSignOutCancelButton() async {
        await self.presenter.dismissSignOutCancelPopup()
        await self.presenter.presentSignOutCancelCompletePopup()
    }

    func didTapSignOutCancelCompleteNobutton() async {
        await self.presenter.dismissSignOutCancelPopup()
    }

    func didTapSignOutCancelCompleteConfirmButton() async {
        await self.presenter.dismissSignOutCancelCompletePopup()
        self.worker.setSignoutStatus(required: false, socialType: self.worker.fetchSocialLoginType())
    }

    func didTapSignOutPopupBackground() async {
        await self.presenter.dismissSignOutPopup()
    }

    func didTapSignOutCompletePopupBackground() async {
        await self.presenter.dismissSignOutCompletePopup()
        self.worker.setSignoutStatus(required: true, socialType: self.worker.fetchSocialLoginType())
    }

    func didTapSignOutCancelPopupBackground() async {
        await self.presenter.dismissSignOutCancelPopup()
    }

    func didTapSignOutCancelCompletePopupBackground() async {
        await self.presenter.dismissSignOutCancelCompletePopup()
        self.worker.setSignoutStatus(required: false, socialType: self.worker.fetchSocialLoginType())
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
