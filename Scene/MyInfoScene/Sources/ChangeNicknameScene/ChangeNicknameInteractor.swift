//
//  ChangeNicknameInteractor.swift
//  TwoToo
//
//  Created by Eddy on 2023/10/12.
//  Copyright (c) 2023 TwoToo. All rights reserved.
//

import CoreKit

protocol ChangeNicknameBusinessLogic {
    /// 닉네임 문구 입력
    func didEnterMyNickname(name: String) async
    /// 확인 버튼 클릭
    func didTapChangeButton() async
    /// 변경 버튼 enable
    func didUpdateChangeButton() async
}

protocol ChangeNicknameDataStore: AnyObject {}

final class ChangeNicknameInteractor: ChangeNicknameDataStore, ChangeNicknameBusinessLogic {
    var cancellables: Set<AnyCancellable> = []
    
    var presenter: ChangeNicknamePresentationLogic
    var router: ChangeNicknameRoutingLogic
    var worker: ChangeNicknameWorkerProtocol
    
    init(
        presenter: ChangeNicknamePresentationLogic,
        router: ChangeNicknameRoutingLogic,
        worker: ChangeNicknameWorkerProtocol
    ) {
        self.presenter = presenter
        self.router = router
        self.worker = worker
    }
    
    // MARK: - DataStore
    
    var nicknameDataSource: String?
}

// MARK: - Interactive Business Logic

extension ChangeNicknameInteractor {
    
    /// 외부 액션 옵저빙
    func observe() {
        
    }
}

// MARK: Feature (닉네임 변경)

extension ChangeNicknameInteractor {
    func didEnterMyNickname(name: String) async {
        self.nicknameDataSource = name
        await self.didUpdateChangeButton()
    }
    
    func didTapChangeButton() async {
        do {
            try await self.worker.requestChangeNickname(name: self.nicknameDataSource ?? "")
            await self.presenter.presentChangeNicknameSucess(text: "닉네임이 변경되었습니다")
            await self.router.dismiss()
        }
        catch {
            await self.presenter.presentChangeNicknameError(error: error)
            await self.router.dismiss()
        }
    }
    
    func didUpdateChangeButton() async {
        if self.nicknameDataSource != "" {
            await self.presenter.presentEnabled(changeButton: .init(isEnabled: true))
        }
        else {
            await self.presenter.presentEnabled(changeButton: .init(isEnabled: false))
        }
    }
}

// MARK: - Application Business Logic

// MARK: UseCase ()

extension ChangeNicknameInteractor {
    
}
