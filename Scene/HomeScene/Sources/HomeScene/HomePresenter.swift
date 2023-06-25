//
//  HomePresenter.swift
//  TwoToo
//
//  Created by 박건우 on 2023/06/04.
//  Copyright (c) 2023 TwoToo. All rights reserved.
//

import UIKit

@MainActor
protocol HomePresentationLogic {
    /// 챌린지 생성전 화면을 보여준다.
    func presentChallengeCreated(challenge: Home.Model.Challenge)
    /// 챌린지 대기중 화면을 보여준다.
    func presentChallengeWaiting(challenge: Home.Model.Challenge)
    /// 챌린지 시작 전 화면을 보여준다.
    func presentChallengeBeforeStart(challenge: Home.Model.Challenge)
    /// 챌린지 시작일 전 화면을 보여준다.
    func presentChallengeBeforeStartDate(challenge: Home.Model.Challenge)
    /// 챌린지 시작일 초과 화면을 보여준다.
    func presentChallengeAfterStartDate(challenge: Home.Model.Challenge)
    /// 챌린지 진행중 화면을 보여준다.
    func presentChallengeInProgress(challenge: Home.Model.Challenge)
    /// 둘다 인증 팝업을 보여준다.
    func presentBothCertificationPopup()
    /// 둘다 인증 팝업을 닫는다.
    func dismissBothCertificationPopup()
    /// 챌린지 완료 화면을 보여준다.
    func presentChallengeCompleted(challenge: Home.Model.Challenge)
    /// 챌린지 완료 팝업을 보여준다.
    func presentCompletedPopup(challenge: Home.Model.Challenge)
    /// 챌린지 완료 팝업을 닫는다.
    func dismissCompletedPopup()
    /// 홈 오류를 보여준다.
    func presentHomeError(error: Error)
    /// 완료 요청 오류를 보여준다.
    func presentCompleteRequestError(error: Error)
    /// 찌르기 횟수 초과 오류를 보여준다.
    func presentExceededStickCountError()
}

final class HomePresenter {
    weak var viewController: HomeDisplayLogic?
    
}

// MARK: - Presentation Logic

extension HomePresenter: HomePresentationLogic {
    
    func presentChallengeCreated(challenge: Home.Model.Challenge) {
        
    }
    
    func presentChallengeWaiting(challenge: Home.Model.Challenge) {
        
    }
    
    func presentChallengeBeforeStart(challenge: Home.Model.Challenge) {
        
    }
    
    func presentChallengeBeforeStartDate(challenge: Home.Model.Challenge) {
        
    }
    
    func presentChallengeAfterStartDate(challenge: Home.Model.Challenge) {
        
    }
    
    func presentChallengeInProgress(challenge: Home.Model.Challenge) {
        
    }
    
    func presentBothCertificationPopup() {
        
    }
    
    func dismissBothCertificationPopup() {
        
    }
    
    func presentChallengeCompleted(challenge: Home.Model.Challenge) {
        
    }
    
    func presentCompletedPopup(challenge: Home.Model.Challenge) {
        
    }
    
    func dismissCompletedPopup() {
        
    }
    
    func presentHomeError(error: Error) {
        
    }
    
    func presentCompleteRequestError(error: Error) {
        
    }
    
    func presentExceededStickCountError() {
        
    }
}

// MARK: - Mapping Logic

extension Home.Model.Challenge {
    
    func toChallengeCreatedViewModel() -> Home.ViewModel.ChallengeCreatedViewModel {
        return .init(myNameText: self.myInfo.nickname, partnerNameText: self.partnerInfo.nickname)
    }
}
