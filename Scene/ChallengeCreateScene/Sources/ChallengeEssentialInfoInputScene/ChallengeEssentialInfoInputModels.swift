//
//  ChallengeEssentialInfoInputModels.swift
//  TwoToo
//
//  Created by 박건우 on 2023/06/04.
//  Copyright (c) 2023 TwoToo. All rights reserved.
//

import UIKit

enum ChallengeEssentialInfoInput {
    
    // MARK: Entity
    
    enum Model {
        
    }
    
    enum ViewModel {

        struct Name {
            var title: String = "챌린지명"
            var text: String
        }

        struct ChallengeCommentField {
            static let maxLength = 20
        }

        struct NextButton {
            var isEnabled: Bool?
        }

        struct Date {
            var startTitle: String = "시작일"
            var startDate: String
            var endTitle: String = "종료일"
            var endDate: String
        }
    }
}
