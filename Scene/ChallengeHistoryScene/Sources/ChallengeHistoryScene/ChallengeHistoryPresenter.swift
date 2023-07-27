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
        // TODO: - 챌린지 그만두면 홈으로 가나 ? 라우팅..
    }
    
    func presentChallengeQuitError(error: Error) {
        self.viewController?.displayToast(message: error.localizedDescription)
    }
}

extension ChallengeHistoryPresenter {
    /// Model -> ViewModel
    func map(model: ChallengeHistory.Model.Challenge)
    -> ChallengeHistory.ViewModel.Challenge {
        return .init(id: model.id,
                     name: model.name,
                     dDayText: self.makedDayText(start: model.startDate,
                                                   end: model.endDate),
                     additionalInfo: model.additionalInfo,
                     myNickname: model.myInfo.nickname,
                     partnerNickname: model.partnerInfo.nickname,
                     cellInfo: self.makeCellInfoList(id: model.id,
                                                     myList: model.myInfo.certificates,
                                                     partnerList: model.partnerInfo.certificates))
    }
    /// cell 뷰모델 리스트 생성
    func makeCellInfoList(id: String,
                          myList: ChallengeHistory.Model.CertificateList,
                          partnerList: ChallengeHistory.Model.CertificateList)
    -> ChallengeHistory.ViewModel.CellInfoList {
        var cellInfoList: ChallengeHistory.ViewModel.CellInfoList = []
        // TODO: - 인증 날짜가 없으면 해당 배열엔 nil을 넣는다..?
        // O X
        // O O
        // X O
        for (my, partner) in zip(myList, partnerList) { // zip은 짧은 거 기준으로 나와서 짤리는 에러 발생
            guard let myPhotoURL = URL(string: my.certificateImageUrl),
                  let partenrPhotoURL = URL(string: partner.certificateImageUrl)
            else {
                print("ERROR: my(\(my.certificateImageUrl)), partner(\(partner.certificateImageUrl)) ImageURL not found ")
                return []
            }
            // TODO: - 인증 날짜로 정렬해야한다....
            let info = ChallengeHistory.ViewModel.CellInfo(dateText: my.certificateTime.fullDateString(.monthDay),
                                                           isToday: self.isToday(certificateDate: my.certificateTime),
                                                           my: .init(certificateID: my.id,
                                                                     user: .user,
                                                                     photoURL: myPhotoURL,
                                                                     timeText: my.certificateTime.fullDateString(.hourMinute)),
                                                           partner: .init(certificateID: partner.id,
                                                                          user: .partner,
                                                                          photoURL: partenrPhotoURL,
                                                                          timeText: partner.certificateTime.fullDateString(.hourMinute)))
            cellInfoList.append(info)
        }
        return cellInfoList
    }
    
    /// 시작일부터 종료일까지 디데이 계산
    func makedDayText(start: Date, end: Date) -> String {
        if let diffDay = Calendar.current.dateComponents([.day], from: start, to: end).day, diffDay > 0 {
            return "D-\(diffDay)"
        } else {
            return "완료"
        }
    }
    
    /// 시작일부터 종료일까지 날짜 배열 리턴
    func makeStartToEndDateText(start: Date, end: Date) -> [String] {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "M/d"

        return sequence(first: start, next: { Calendar.current.date(byAdding: .day, value: 1, to: $0) })
            .prefix(while: { $0 <= end })
            .map { dateFormatter.string(from: $0) }
    }
    
    /// 오늘인지 판별
    func isToday(certificateDate: Date) -> Bool {
        let today = Date()
        return Calendar.current.isDate(today, inSameDayAs: certificateDate)
    }
    
}
