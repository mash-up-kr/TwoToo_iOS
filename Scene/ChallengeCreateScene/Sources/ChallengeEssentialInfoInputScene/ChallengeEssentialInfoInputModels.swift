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

        struct Info {
            
            struct StartDate {
                let date: Date?
            }
            struct EndDate {
                let date: Date?
            }
            
            struct NextButton {
                var isEnabled: Bool?
            }

            struct Name {
                var text: String?
            }
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

        struct ChallengeDate {
            var startDate: Date?
            var endDate: Date?
        }
    }
}
