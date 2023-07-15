//
//  NudgeSendModels.swift
//  TwoToo
//
//  Created by 박건우 on 2023/06/04.
//  Copyright (c) 2023 TwoToo. All rights reserved.
//

import UIKit

enum NudgeSend {
    
    // MARK: Entity
    
    enum Model {
        
    }
    
    enum ViewModel {
        
        struct Title {
            var text: String?
        }
        
        struct NudgeCommentField {
            static let maxLength = 30
        }
        
        struct NudgeButton {
            var isEnabled: Bool?
        }
        
        struct Toast {
            var message: String?
        }
    }
}
