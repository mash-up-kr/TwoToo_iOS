//
//  NicknameRegistModels.swift
//  TwoToo
//
//  Created by 박건우 on 2023/06/04.
//  Copyright (c) 2023 TwoToo. All rights reserved.
//

import UIKit

enum NicknameRegist {
    
    // MARK: Entity
    
    enum Model {
        
        struct InvitedUser {
            var name: String
        }
    }
    
    enum ViewModel {
        
        struct Nickname {
            let maxLength: Int = 4
        }
        
        struct Toast {
            var message: String?
        }
    }
}
