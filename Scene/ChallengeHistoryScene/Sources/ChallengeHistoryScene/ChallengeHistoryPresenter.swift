//
//  ChallengeHistoryPresenter.swift
//  TwoToo
//
//  Created by 박건우 on 2023/06/04.
//  Copyright (c) 2023 TwoToo. All rights reserved.
//

import UIKit

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
        
    }
    
    func presentOptionPopup() {
        
    }
    
    func presentQuitPopup() {
        
    }
    
    func dismissQuitPopup() {
        
    }
    
    func presentChallengeQuitSuccess() {
        
    }
    
    func presentChallengeQuitError(error: Error) {
        
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
        for (my, partner) in zip(myList, partnerList) {
            guard let myPhotoURL = URL(string: my.certificateImageUrl),
                  let partenrPhotoURL = URL(string: partner.certificateImageUrl)
            else {
                print("ERROR: URL(string: photo)")
                return []
            }
            
            let info = ChallengeHistory.ViewModel.CellInfo(dateText: self.translateDateToTime(date: my.certificateTime),
                                                           my: .init(certificateID: my.id,
                                                                     user: .user,
                                                                     photoURL: myPhotoURL,
                                                                     timeText: self.translateDateToTime(date: my.certificateTime)),
                                                           partner: .init(certificateID: partner.id,
                                                                          user: .partner,
                                                                          photoURL: partenrPhotoURL,
                                                                          timeText: self.translateDateToTime(date: partner.certificateTime)))
            cellInfoList.append(info)
        }
        return cellInfoList
    }
    
    
    func makedDayText(start: Date, end: Date) -> String {
        let diffDay = Calendar.current.dateComponents([.day], from: start, to: end).day ?? -1
        return "D-\(diffDay)"
    }
    
    /// 시작일부터 종료일까지 날짜 배열 리턴
    func makeStartToEndDateText(start: Date, end: Date) -> [String] {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "M/d"

        return sequence(first: start, next: { Calendar.current.date(byAdding: .day, value: 1, to: $0) })
            .prefix(while: { $0 <= end })
            .map { dateFormatter.string(from: $0) }
    }
    
    func translateDateToTime(date: Date) -> String {
        // TODO: - Date 타입에서 시간만 뽑아서 넘기기 HH:mm
        return ""
    }
    
}
