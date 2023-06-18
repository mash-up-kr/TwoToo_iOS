//
//  InvitationWaitModels.swift
//  TwoToo
//
//  Created by 박건우 on 2023/06/04.
//  Copyright (c) 2023 TwoToo. All rights reserved.
//

import UIKit

enum InvitationWait {
    
    // MARK: Entity
    
    enum Model {
        
        struct Partner {
            var id: String
        }
    }
    
    enum ViewModel {
        
        struct Share {
            var message: String?
            
            init(invitationLink: String) {
                self.message =
                """
                [투투]에 초대합니다.
                👉 링크를 누르고 로그인하여 챌린지를 진행해보세요!
                \(invitationLink)
                """
            }
        }
        
        struct Toast {
            var message: String?
        }
    }
}
