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
    
}

// MARK: - Presentation Logic

extension ChallengeHistoryPresenter: ChallengeHistoryPresentationLogic {
    
    func presentChallenge(challenge: ChallengeHistory.Model.Challenge) {
        let viewModel = self.map(model: challenge)
        self.viewController?.displayChallenge(viewModel: viewModel)
    }
    
    func presentOptionPopup() {
        self.viewController?.displayOptionPopup(title: "챌린지 그만두기")
    }
    
    func presentQuitPopup() {
        let viewModel = ChallengeHistory.ViewModel.QuitPopup(title: "챌린지 그만두기",
                                                             iconImage: .asset(.icon_delete)!,
                                                             description: "기존의 챌린지는 삭제 됩니다\n*(경고) 그만두기 시 양쪽 모두에게\n삭제 및 종료 됩니다!*",
                                                             buttonTitles: ["취소", "그만두기"])
        self.viewController?.displayQuitPopup(viewModel: viewModel)
    }
    
    func dismissQuitPopup() {
        self.viewController?.dismissQuitPopup()
    }
    
    func presentChallengeQuitSuccess() {
        // TODO: - 챌린지 그만두기 후 토스트 메세지?
//        self.viewController?.displayToast(message: "")
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
                     dDayText: self.makedDayText(start: model.startDate,
                                                   end: model.endDate),
                     additionalInfo: model.additionalInfo,
                     myNickname: model.myInfo.nickname,
                     partnerNickname: model.partnerInfo.nickname,
                     cellInfo: self.makeCellInfoList(startToEndDateList: self.makeStartToEndDateList(start: model.startDate,
                                                                                                     end: model.endDate),
                                                     myList: model.myInfo.certificates,
                                                     partnerList: model.partnerInfo.certificates))
    }
    /// cell 뷰모델 리스트 생성
    private func makeCellInfoList(startToEndDateList: [Date],
                          myList: ChallengeHistory.Model.CertificateList,
                          partnerList: ChallengeHistory.Model.CertificateList)
    -> ChallengeHistory.ViewModel.CellInfoList {
        var cellInfoList: ChallengeHistory.ViewModel.CellInfoList = []
        startToEndDateList.forEach { day in
            let dateText = day.dateToString(.monthDay)
            let my = self.isUserCertificateInfo(pivDateText: dateText, userType: .user, certificateList: myList)
            let partner = self.isUserCertificateInfo(pivDateText: dateText, userType: .partner, certificateList: partnerList)
            let cellInfo = ChallengeHistory.ViewModel.CellInfo(dateText: dateText,
                                                               isToday: self.isToday(day),
                                                               my: my,
                                                               partner: partner)
            
            cellInfoList.append(cellInfo)
        }
        
        return cellInfoList
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
    private func makedDayText(start: Date, end: Date) -> String {
        if let diffDay = Calendar.current.dateComponents([.day], from: start, to: end).day, diffDay > 0 {
            return "D-\(diffDay)"
        } else {
            return "완료"
        }
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
    
}
