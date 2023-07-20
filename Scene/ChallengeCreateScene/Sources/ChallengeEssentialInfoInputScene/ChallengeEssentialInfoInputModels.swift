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

    // Presenter -> VC 변환할떄 사용 Model -> VM 가도록
    enum Model {
        struct StartDate {
            let date: String?
        }
        struct EndDate {
            let date: String?
        }
    }
    
    enum ViewModel {

        struct Name {
            var text: String?
        }

        struct ChallengeCommentField {
            static let maxLength = 20
        }

        struct NextButton {
            var isEnabled: Bool?
        }

        struct Date {
            var startDate: String?
            var endDate: String?
        }
    }
}
