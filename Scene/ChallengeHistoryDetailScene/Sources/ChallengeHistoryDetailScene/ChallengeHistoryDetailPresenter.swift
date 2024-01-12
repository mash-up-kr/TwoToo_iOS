//
//  ChallengeHistoryDetailPresenter.swift
//  TwoToo
//
//  Created by 박건우 on 2023/06/04.
//  Copyright (c) 2023 TwoToo. All rights reserved.
//

import UIKit
import SKPhotoBrowser

@MainActor
protocol ChallengeHistoryDetailPresentationLogic {
    func presentChallengeDetail(detail: ChallengeHistoryDetail.Model.ChallengeDetail)
    func presentPhoto(imageUrl: String)
    
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
    
    func presentPhoto(imageUrl: String) {
        var images = [SKPhoto]()
        let photo = SKPhoto.photoWithImageURL(imageUrl)
        photo.shouldCachePhotoURLImage = false
        images.append(photo)
        self.viewController?.displayPhoto(photo: .init(images: images))
    }
    
    // model -> viewModel
    private func map(_ model: ChallengeHistoryDetail.Model.ChallengeDetail)
    -> (ChallengeHistoryDetail.ViewModel.Challenge,
        ChallengeHistoryDetail.ViewModel.Compliment)
    {
        let dateText = model.certificateTime.dateToString(.hangleYearMonthDay)
        let timeText = "인증 시간  " + model.certificateTime.dateToString(.hourMinute)
        let title = "\(model.myNickname)의 기록"
        let certification = ChallengeHistoryDetail.ViewModel.Challenge(
          challengeName: model.challengeName,
          certificationDateText: dateText,
          navigationTitle: title,
          certificationImageURL: URL(string: model.certificateImageUrl),
          certificationComment: model.certificateComment,
          certificationTimeText: timeText
        )
        
        let complimentTitle = "\(model.partnerNickname)이 보낸 칭찬"
        let compliment = ChallengeHistoryDetail.ViewModel.Compliment(
          complimentTitle: complimentTitle,
          complimentComment: model.complicateComment, 
          isMyHitstoyDetail: model.isMine
        )
        return (certification, compliment)
    }

}
