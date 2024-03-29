//
//  PraiseSendModels.swift
//  TwoToo
//
//  Created by 박건우 on 2023/06/04.
//  Copyright (c) 2023 TwoToo. All rights reserved.
//

import UIKit

enum PraiseSend {
    
    // MARK: Entity
    
    enum Model {
        
    }
    
    enum ViewModel {
        
        struct PraseCommentField {
            static let maxLength = 20
        }
        
        struct PraiseButton {
            var isEnabled: Bool?
        }
        
        struct Toast {
            var message: String?
        }
    }
}
