//
//  HomePresenter.swift
//  TwoToo
//
//  Created by 박건우 on 2023/06/04.
//  Copyright (c) 2023 TwoToo. All rights reserved.
//

import CoreKit
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
        self.viewController?.displayChallengeCreatedViewModel(
            viewModel: challenge.toChallengeCreatedViewModel()
        )
    }
    
    func presentChallengeWaiting(challenge: Home.Model.Challenge) {
        self.viewController?.displayChallengeWaitingViewModel(
            viewModel: challenge.toChallengeWaitingViewModel()
        )
    }
    
    func presentChallengeBeforeStart(challenge: Home.Model.Challenge) {
        self.viewController?.displayChallengeBeforeStartViewModel(
            viewModel: challenge.toChallengeBeforeStartViewModel()
        )
    }
    
    func presentChallengeBeforeStartDate(challenge: Home.Model.Challenge) {
        self.viewController?.displayChallengeBeforeStartDateViewModel(
            viewModel: challenge.toChallengeBeforeStartDateViewModel()
        )
    }
    
    func presentChallengeAfterStartDate(challenge: Home.Model.Challenge) {
        self.viewController?.displayChallengeAfterStartDateViewModel(
            viewModel: challenge.toChallengeAfterStartDateViewModel()
        )
    }
    
    func presentChallengeInProgress(challenge: Home.Model.Challenge) {
        self.viewController?.displayChallengeInProgressViewModel(
            viewModel: challenge.toChallengeInProgressViewModel()
        )
    }
    
    func presentBothCertificationPopup() {
        self.viewController?.displayBothCertificationViewModel(viewModel: .init(show: (.asset(.icon_all_verified)!)))
    }
    
    func dismissBothCertificationPopup() {
        self.viewController?.displayBothCertificationViewModel(viewModel: .init(dismiss: ()))
    }
    
    func presentChallengeCompleted(challenge: Home.Model.Challenge) {
        self.viewController?.displayChallengeCompletedViewModel(viewModel: challenge.toChallengeCompletedViewModel())
    }
    
    func presentCompletedPopup(challenge: Home.Model.Challenge) {
        self.viewController?.displayCompletedViewModel(viewModel: challenge.toCompletedViewModel())
    }
    
    func dismissCompletedPopup() {
        self.viewController?.displayCompletedViewModel(viewModel: .init(dismiss: ()))
    }
    
    func presentHomeError(error: Error) {
        self.viewController?.displayToast(viewModel: .init(message: "홈 조회 오류가 발생하였습니다. 앱을 재시동해주세요."))
    }
    
    func presentCompleteRequestError(error: Error) {
        self.viewController?.displayToast(viewModel: .init(message: "통신 중 오류가 발생하였습니다. 다시 시도해주세요."))
    }
    
    func presentExceededStickCountError() {
        self.viewController?.displayToast(viewModel: .init(message: "오늘의 콕 찌르기가 다 소진되었어요 ㅠㅜ"))
    }
}

// MARK: - Mapping Logic

extension Home.Model.Challenge {
    
    func toChallengeCreatedViewModel() -> Home.ViewModel.ChallengeCreatedViewModel {
        return .init(myNameText: self.myInfo.nickname, partnerNameText: self.partnerInfo.nickname)
    }
    
    func toChallengeWaitingViewModel() -> Home.ViewModel.ChallengeWaitingViewModel {
        return .init(myNameText: self.myInfo.nickname, partnerNameText: self.partnerInfo.nickname)
    }
    
    func toChallengeBeforeStartViewModel() -> Home.ViewModel.ChallengeBeforeStartViewModel {
        let partnerName = self.partnerInfo.nickname
        let title = "\(partnerName)님이 보낸 \n챌린지를 확인해주세요"
        let attributedTitle = NSMutableAttributedString(string: title)
        let range = (title as NSString).range(of: partnerName)
        attributedTitle.addAttribute(.foregroundColor, value: UIColor.mainCoral, range: range)
        return .init(
            myNameText: self.myInfo.nickname,
            partnerNameText: partnerName,
            title: attributedTitle
        )
    }
    
    func toChallengeBeforeStartDateViewModel() -> Home.ViewModel.ChallengeBeforeStartDateViewModel {
        return .init(myNameText: self.myInfo.nickname, partnerNameText: self.partnerInfo.nickname)
    }
    
    func toChallengeAfterStartDateViewModel() -> Home.ViewModel.ChallengeAfterStartDateViewModel {
        return .init(myNameText: self.myInfo.nickname, partnerNameText: self.partnerInfo.nickname)
    }
    
    func toChallengeInProgressViewModel() -> Home.ViewModel.ChallengeInProgressViewModel {
        var viewModel = Home.ViewModel.ChallengeInProgressViewModel(
            challengeInfo: .init(challengeNameText: "", dDayText: ""),
            progress: .init(
                partnerNameText: "", myNameText: "",
                partnerPercentageText: "", myPercentageText: "",
                partnerPercentageNumber: 0, myPercentageNumber: 0
            ),
            order: .init(challengeOrderText: "", partenrNameText: "", myNameText: ""),
            partnerFlower: .init(
                image: UIImage(), isCertificationCompleteHidden: false,
                isComplimentCommentHidden: false, complimentCommentText: "", partnerNameText: ""
            ),
            myFlower: .init(
                image: UIImage(), isCertificationButtonHidden: false,
                cetificationGuideText: "", isComplimentCommentHidden: false, complimentCommentText: "", myNameText: ""),
            isHeartHidden: false,
            stickText: ""
        )
        
        // 챌린지 정보 매핑
        viewModel.challengeInfo.challengeNameText = self.name ?? ""
        viewModel.challengeInfo.dDayText = self.calculateDDayText(endDate: self.endDate)
        
        // 프로그래스 매핑
        viewModel.progress.partnerNameText = self.partnerInfo.nickname
        viewModel.progress.myNameText = self.myInfo.nickname
        viewModel.progress.partnerPercentageText = self.calculatePercentageText(certCount: self.partnerInfo.certCount)
        viewModel.progress.myPercentageText = self.calculatePercentageText(certCount: self.myInfo.certCount)
        viewModel.progress.partnerPercentageNumber = self.calculatePercentageNumber(certCount: self.partnerInfo.certCount)
        viewModel.progress.myPercentageNumber = self.calculatePercentageNumber(certCount: self.myInfo.certCount)
        
        // 순서 매핑
        viewModel.order.challengeOrderText = self.calculateOrderText(order: self.order)
        viewModel.order.partenrNameText = self.partnerInfo.nickname
        viewModel.order.myNameText = self.myInfo.nickname
        
        // 상대방 꽃 매핑
        var partnerFlowerMapper: FlowerMappingWorker?
        if let partnerFlower = self.partnerInfo.flower {
            partnerFlowerMapper = FlowerMappingWorker(flowerType: partnerFlower)
        }
        viewModel.partnerFlower.image = partnerFlowerMapper?.getMateImageByStep(growStatus: self.partnerInfo.growStatus ?? .seed) ?? UIImage()
        viewModel.partnerFlower.complimentCommentText = self.partnerInfo.todayCert?.complimentComment ?? ""
        viewModel.partnerFlower.partnerNameText = self.partnerInfo.nickname
        
        // 내 꽃 매핑
        var myFlowerMapper: FlowerMappingWorker?
        if let myFlower = self.myInfo.flower {
            myFlowerMapper = FlowerMappingWorker(flowerType: myFlower)
        }
        viewModel.myFlower.image = myFlowerMapper?.getMyImageByStep(growStatus: self.myInfo.growStatus ?? .seed) ?? UIImage()
        viewModel.myFlower.cetificationGuideText = "내 씨앗을 눌러 인증 해보세요!"
        viewModel.myFlower.complimentCommentText = self.myInfo.todayCert?.complimentComment ?? ""
        viewModel.myFlower.myNameText = self.myInfo.nickname
        
        // 챌린지 진행 상태 매핑
        switch  self.status {
            case .inProgress(let inProgressStatus):
                switch inProgressStatus {
                    case .bothUncertificated:
                        viewModel.myFlower.isCertificationButtonHidden = false
                        viewModel.partnerFlower.isCertificationCompleteHidden = true
                        viewModel.myFlower.isComplimentCommentHidden = true
                        viewModel.partnerFlower.isComplimentCommentHidden = true
                        viewModel.isHeartHidden = true
                        
                    case .onlyPartnerCertificated:
                        viewModel.myFlower.isCertificationButtonHidden = false
                        viewModel.partnerFlower.isCertificationCompleteHidden = false
                        viewModel.myFlower.isComplimentCommentHidden = true
                        viewModel.partnerFlower.isComplimentCommentHidden = true
                        viewModel.isHeartHidden = true
                        
                    case .onlyMeCertificated:
                        viewModel.myFlower.isCertificationButtonHidden = true
                        viewModel.partnerFlower.isCertificationCompleteHidden = true
                        viewModel.myFlower.isComplimentCommentHidden = true
                        viewModel.partnerFlower.isComplimentCommentHidden = true
                        viewModel.isHeartHidden = true
                        
                    case .bothCertificated(_):
                        viewModel.myFlower.isCertificationButtonHidden = true
                        viewModel.partnerFlower.isCertificationCompleteHidden = true
                        viewModel.myFlower.isComplimentCommentHidden = false
                        viewModel.partnerFlower.isComplimentCommentHidden = false
                        viewModel.isHeartHidden = false
                }
            default:
                break
        }
        
        // 찌르기 텍스트
        viewModel.stickText = "콕 찌르기 (\(self.stickRemaining ?? 0)/5)"
        
        return viewModel
    }
    
    func toChallengeCompletedViewModel() -> Home.ViewModel.ChallengeCompletedViewModel {
        var viewModel = Home.ViewModel.ChallengeCompletedViewModel(
            challengeInfo: .init(challengeNameText: ""),
            progress: .init(
                partnerNameText: "", myNameText: "",
                partnerPercentageText: "", myPercentageText: "",
                partnerPercentageNumber: 0, myPercentageNumber: 0
            ),
            order: .init(challengeOrderText: "", partenrNameText: "", myNameText: ""),
            partnerFlower: .init(
                image: UIImage(), isFlowerTextHidden: false,
                flowerNameText: "", flowerDescText: "", partnerNameText: ""
            ),
            myFlower: .init(
                image: UIImage(), isFlowerTextHidden: false,
                flowerNameText: "", flowerDescText: "", myNameText: ""
            )
        )
        
        // 챌린지 정보 매핑
        viewModel.challengeInfo.challengeNameText = self.name ?? ""
        
        // 프로그래스 매핑
        viewModel.progress.partnerNameText = self.partnerInfo.nickname
        viewModel.progress.myNameText = self.myInfo.nickname
        viewModel.progress.partnerPercentageText = self.calculatePercentageText(certCount: self.partnerInfo.certCount)
        viewModel.progress.myPercentageText = self.calculatePercentageText(certCount: self.myInfo.certCount)
        viewModel.progress.partnerPercentageNumber = self.calculatePercentageNumber(certCount: self.partnerInfo.certCount)
        viewModel.progress.myPercentageNumber = self.calculatePercentageNumber(certCount: self.myInfo.certCount)
        
        // 순서 매핑
        viewModel.order.challengeOrderText = self.calculateOrderText(order: self.order)
        viewModel.order.partenrNameText = self.partnerInfo.nickname
        viewModel.order.myNameText = self.myInfo.nickname
        
        // 상대방 꽃 매핑
        var partnerFlowerMapper: FlowerMappingWorker?
        if let partnerFlower = self.partnerInfo.flower {
            partnerFlowerMapper = FlowerMappingWorker(flowerType: partnerFlower)
        }
        viewModel.partnerFlower.image = partnerFlowerMapper?.getMateImageByStep(growStatus: self.partnerInfo.growStatus ?? .seed) ?? UIImage()
        viewModel.partnerFlower.flowerNameText = partnerFlowerMapper?.getName() ?? ""
        viewModel.partnerFlower.flowerDescText = partnerFlowerMapper?.getDesc() ?? ""
        viewModel.partnerFlower.isFlowerTextHidden = !(self.partnerInfo.growStatus == .flower || self.partnerInfo.growStatus == .bloom)
        viewModel.partnerFlower.partnerNameText = self.partnerInfo.nickname
        
        // 내 꽃 매핑
        var myFlowerMapper: FlowerMappingWorker?
        if let myFlower = self.myInfo.flower {
            myFlowerMapper = FlowerMappingWorker(flowerType: myFlower)
        }
        viewModel.myFlower.image = myFlowerMapper?.getMyImageByStep(growStatus: self.myInfo.growStatus ?? .seed) ?? UIImage()
        viewModel.myFlower.flowerNameText = myFlowerMapper?.getName() ?? ""
        viewModel.myFlower.flowerDescText = myFlowerMapper?.getDesc() ?? ""
        viewModel.myFlower.isFlowerTextHidden = !(self.myInfo.growStatus == .flower || self.myInfo.growStatus == .bloom)
        viewModel.myFlower.myNameText = self.myInfo.nickname
        
        return viewModel
    }
    
    func toCompletedViewModel() -> Home.ViewModel.CompletedViewModel {
        var title: String
        var message: String
        var image: UIImage
        
        // 메세지 매핑
        if (self.partnerInfo.growStatus == .flower || self.partnerInfo.growStatus == .bloom),
           (self.myInfo.growStatus == .flower || self.myInfo.growStatus == .bloom) {
            title = "축하합니다!"
            message = "둘다 꽃을 피웠어요!\n서로의 꽃을 확인해보세요!"
            image = .asset(.icon_blossome)!
        }
        else {
            title = "수고했어요!"
            message = "챌린지가 끝났어요!\n서로의 달성률을 확인해보세요"
            image = .asset(.icon_congratulation)!
        }
        
        return .init(show: (title, message, image))
    }
}

private extension Home.Model.Challenge {
    
    func calculateDDayText(endDate: Date?) -> String {
        guard let endDate = endDate else {
            return ""
        }
        
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day], from: Date(), to: endDate)
        
        if let days = components.day {
            return "D-\(days)"
        } else {
            return ""
        }
    }
    
    func calculatePercentageText(certCount: Int?) -> String {
        guard let certCount = certCount else {
            return ""
        }
        
        if certCount < 20 {
            let percentage = (certCount * 5) // 5% 씩 증가
            return "\(percentage)%"
        } else if certCount < 22 {
            return "99%" // 20부터 99%로 유지
        } else {
            return "100%" // 22가 되면 100%로 표시
        }
    }

    func calculatePercentageNumber(certCount: Int?) -> Double {
        guard let certCount = certCount else {
            return 0.0
        }
        
        if certCount < 20 {
            return Double(certCount) * 0.05 // 5% 씩 증가
        } else if certCount < 22 {
            return 0.99 // 20부터 99%로 유지
        } else {
            return 1.0 // 22가 되면 100%로 표시
        }
    }
    
    func calculateOrderText(order: Int?) -> String {
        if let order = order {
            return "\(order)번째 챌린지 중"
        } else {
            return ""
        }
    }
}
