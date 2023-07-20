//
//  ChallengeRecommendPresenter.swift
//  TwoToo
//
//  Created by 박건우 on 2023/06/04.
//  Copyright (c) 2023 TwoToo. All rights reserved.
//

import UIKit

@MainActor
protocol ChallengeRecommendPresentationLogic {
    /// 추천 챌린지 리스트를 보여준다.
    func presentRecommendChallenges()
}

final class ChallengeRecommendPresenter {
    weak var viewController: ChallengeRecommendDisplayLogic?
    
}

// MARK: - Presentation Logic

extension ChallengeRecommendPresenter: ChallengeRecommendPresentationLogic {
    
    func presentRecommendChallenges() {
        self.viewController?.displayChallenges(viewModel: .init(items: [
            .init(title: ("💗", "사랑한다고 얘기 해주기")),
            .init(title: ("📝", "하루 한 문장 일상 공유하기")),
            .init(title: ("👍", "하루에 한번 칭찬 해주기")),
            .init(title: ("📷", "거울 셀카 찍기")),
            .init(title: ("👗", "패션 사진 OOTD 찍기")),
            .init(title: ("🥦", "하루 한끼 채식 식단 하기")),
            .init(title: ("💵", "하루 만원만 쓰기")),
            .init(title: ("🏃‍♀️", "매일 운동하기")),
            .init(title: ("🐷", "체중 감량하기")),
            .init(title: ("📘", "독서하기")),
            .init(title: ("🌞", "미라클 모닝하기"))
        ]))
    }
}
