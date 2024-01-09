//
//  ChallengeHistoryPresenter.swift
//  TwoToo
//
//  Created by 박건우 on 2023/06/04.
//  Copyright (c) 2023 TwoToo. All rights reserved.
//

import UIKit
import Util

@MainActor
protocol ChallengeHistoryPresentationLogic {
    /// 챌린지 상세를 보여준다.
    func presentChallenge(challenge: ChallengeHistory.Model.Challenge)
    /// 옵션 팝업을 보여준다.
    func presentOptionPopup()
    /// 챌린지 그만두기 팝업을 보여준다.
    func presentQuitPopup()
    /// 챌린지 그만두기 팝업을 제거한다.
    func dismissQuitPopup()
    /// 챌린지 그만두기 성공을 보여준다.
    func presentChallengeQuitSuccess()
    /// 챌린지 그만두기 오류를 보여준다.
    func presentChallengeQuitError(error: Error)
}

final class ChallengeHistoryPresenter {
    weak var viewController: ChallengeHistoryDisplayLogic?
    /// 챌린지가 완료된 상태인지 체크
    private var isCompleted: Bool = false
}

// MARK: - Presentation Logic

extension ChallengeHistoryPresenter: ChallengeHistoryPresentationLogic {
    
    func presentChallenge(challenge: ChallengeHistory.Model.Challenge) {
        let viewModel = self.map(model: challenge)
        self.viewController?.displayChallenge(viewModel: viewModel)
    }
    
    func presentOptionPopup() {
        let title = self.isCompleted ? "챌린지 삭제하기" : "챌린지 그만두기"
        self.viewController?.displayOptionPopup(title: title)
    }
    
    func presentQuitPopup() {
        var title: String = "챌린지 그만두기"
        var description: String = "기존의 챌린지는 삭제 됩니다."
        var warningText: String = "*(경고) 그만두기 시 양쪽 모두에게\n삭제 및 종료 됩니다!"
        var buttonTitles: [String] = ["취소", "그만두기"]
        if self.isCompleted {
            title = "챌린지 삭제하기"
            description = "완료한 챌린지는 삭제됩니다."
            warningText = "*(경고) 삭제하기 시 양쪽 모두에게 삭제됩니다!*"
            buttonTitles = ["취소", "삭제하기"]
        }
        
        let viewModel = ChallengeHistory.ViewModel.QuitPopup(title: title,
                                                             iconImage: .asset(.icon_delete)!,
                                                             description: description, 
                                                             warningText: warningText,
                                                             buttonTitles: buttonTitles)
        self.viewController?.displayQuitPopup(viewModel: viewModel)
    }
    
    func dismissQuitPopup() {
        self.viewController?.dismissQuitPopup()
    }
    
    func presentChallengeQuitSuccess() {
        let message = self.isCompleted ? "완료된 챌린지를 삭제했어요." : "기존 챌린지를 삭제했어요. 새로운 챌린지를 도전하세요!"
        self.viewController?.displayToast(message: message)
    }
    
    func presentChallengeQuitError(error: Error) {
        self.viewController?.displayToast(message: error.localizedDescription)
    }
}

extension ChallengeHistoryPresenter {
    
    /// Model -> ViewModel
    private func map(model: ChallengeHistory.Model.Challenge)
    -> ChallengeHistory.ViewModel.Challenge {
        return .init(id: model.id,
                     name: model.name,
                     dDayText: self.makedDayText(start: Date(),
                                                 end: model.endDate,
                                                 isFinished: model.isFinished),
                     additionalInfo: model.additionalInfo, 
                     progress: self.mappingProgress(partnerInfo: model.partnerInfo, myInfo: model.myInfo),
                     myNickname: model.myInfo.nickname,
                     partnerNickname: model.partnerInfo.nickname,
                     cellInfo: self.makeCellInfoList(start: model.startDate,
                                                     end: model.endDate,
                                                     myList: model.myInfo.certificates,
                                                     partnerList: model.partnerInfo.certificates))
    }
    
    private func mappingProgress(partnerInfo: ChallengeHistory.Model.User, myInfo: ChallengeHistory.Model.User) -> ChallengeHistory.ViewModel.ProgressViewModel {
        return .init(partnerNameText: partnerInfo.nickname,
                     myNameText: myInfo.nickname,
                     partnerPercentageText: self.calculatePercentageText(certCount: partnerInfo.certCount),
                     myPercentageText: self.calculatePercentageText(certCount: myInfo.certCount),
                     partnerPercentageNumber: self.calculatePercentageNumber(certCount: partnerInfo.certCount),
                     myPercentageNumber: self.calculatePercentageNumber(certCount: myInfo.certCount))
    }
    /// cell 뷰모델 리스트 생성
    private func makeCellInfoList(start: Date,
                                  end: Date,
                                  myList: ChallengeHistory.Model.CertificateList,
                                  partnerList: ChallengeHistory.Model.CertificateList)
    -> ChallengeHistory.ViewModel.CellInfoList {
        
        let today = Date()
        var current = start
        let end = end
        
        var cellInfoList: ChallengeHistory.ViewModel.CellInfoList = []
        
        while current <= end {
            
            if current > today { break } // 오늘 날짜 이후의 값은 제거
            
            var my: ChallengeHistory.ViewModel.CertificatePhotoViewModel?
            if let myModel = myList.first(where: {
                current.dateToString(.yearMonthDay) == $0.certificateTime.dateToString(.yearMonthDay)
            }) {
                my = .init(
                    certificateID: myModel.id,
                    user: .user,
                    photoURL: URL(string: myModel.certificateImageUrl),
                    timeText: myModel.certificateTime.dateToString(.hourMinute)
                )
            }
            
            var partner: ChallengeHistory.ViewModel.CertificatePhotoViewModel?
            if let partnerModel = partnerList.first(where: {
                current.dateToString(.yearMonthDay) == $0.certificateTime.dateToString(.yearMonthDay)
            }) {
                partner = .init(
                    certificateID: partnerModel.id,
                    user: .partner,
                    photoURL: URL(string: partnerModel.certificateImageUrl),
                    timeText: partnerModel.certificateTime.dateToString(.hourMinute)
                )
            }
            
            let cell = ChallengeHistory.ViewModel.CellInfo(
                dateText: current.dateToString(.monthDay),
                isToday: current.dateToString(.yearMonthDay) == today.dateToString(.yearMonthDay),
                my: my,
                partner: partner
            )
            cellInfoList.append(cell)
            
            // 다음 날짜로 이동 (1일 더하기)
            current = Calendar.current.date(byAdding: .day, value: 1, to: current)!
        }
        
        return cellInfoList.reversed()
    }
    
    /// 해당 일자에 유저의 인증 정보가 있는지 체크 후 매핑
    private func isUserCertificateInfo(pivDateText: String,
                                       userType: ChallengeHistory.ViewModel.UserType,
                                       certificateList: ChallengeHistory.Model.CertificateList)
    -> ChallengeHistory.ViewModel.CertificatePhotoViewModel? {
        if let info = certificateList
            .filter({ $0.certificateTime.dateToString(.monthDay) == pivDateText }).first {
            return .init(certificateID: info.id,
                         user: userType,
                         photoURL: URL(string: info.certificateImageUrl),
                         timeText: info.certificateTime.dateToString(.hourMinute))
        }
        return nil
    }
    
    /// 시작일부터 종료일까지 디데이 계산
    private func makedDayText(start: Date, end: Date, isFinished: Bool) -> String {
        if isFinished {
            self.isCompleted = true
            return "완료"
        }
        if let diffDay = Calendar.current.dateComponents([.day], from: start, to: end).day {
            return "D-\(diffDay)"
        }
        return ""
    }
    
    /// 시작일부터 종료일까지 날짜 배열 리턴, 최신순 정렬
    private func makeStartToEndDateList(start: Date, end: Date) -> [Date] {
        return sequence(first: start, next: { Calendar.current.date(byAdding: .day, value: 1, to: $0) })
            .prefix(while: { $0 <= end })
            .reversed()
    }
    
    /// 오늘인지 판별
    private func isToday(_ date: Date) -> Bool {
        let today = Date()
        return Calendar.current.isDate(today, inSameDayAs: date)
    }
    
    private func calculatePercentageText(certCount: Int?) -> String {
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

    private func calculatePercentageNumber(certCount: Int?) -> Double {
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
    
    
}
