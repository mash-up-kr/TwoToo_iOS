//
//  ChallengeHistoryDetailPresenter.swift
//  TwoToo
//
//  Created by 박건우 on 2023/06/04.
//  Copyright (c) 2023 TwoToo. All rights reserved.
//

import UIKit

@MainActor
protocol ChallengeHistoryDetailPresentationLogic {
    func presentChallengeDetail(detail: ChallengeHistoryDetail.Model.ChallengeDetail)
    
}

final class ChallengeHistoryDetailPresenter {
    weak var viewController: ChallengeHistoryDetailDisplayLogic?
    
}

// MARK: - Presentation Logic

extension ChallengeHistoryDetailPresenter: ChallengeHistoryDetailPresentationLogic {

    func presentChallengeDetail(detail: ChallengeHistoryDetail.Model.ChallengeDetail) {
        let (certification, compliment) = self.map(detail)
        self.viewController?.displayCertification(certification: certification)
        self.viewController?.displayCompliment(compliment: compliment)
    }
    
    // model -> viewModel
    private func map(_ model: ChallengeHistoryDetail.Model.ChallengeDetail)
    -> (ChallengeHistoryDetail.ViewModel.Challenge,
        ChallengeHistoryDetail.ViewModel.Compliment)
    {
        let dateText = model.certificateTime.dateToString(.hangleYearMonthDay)
        let timeText = "입력 시간  " + model.certificateTime.dateToString(.hourMinute)
        let title = "\(model.myNickname)의 기록"
        let certification = ChallengeHistoryDetail.ViewModel.Challenge(challengeName: model.challengeName,
                                                                       certificationDateText: dateText,
                                                                       navigationTitle: title,
                                                                       certificationImageURL: URL(string: model.certificateImageUrl),
                                                                       certificationComment: model.certificateComment,
                                                                       certificationTimeText: timeText)
        
        let complimentTitle = "\(model.partnerNickname)이 보낸 칭찬"
        let compliment = ChallengeHistoryDetail.ViewModel.Compliment(complimentTitle: complimentTitle,
                                                                     complimentComment: model.complicateComment)
        return (certification, compliment)
    }

}
