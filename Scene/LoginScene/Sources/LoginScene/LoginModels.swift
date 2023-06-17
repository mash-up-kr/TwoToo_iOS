//
//  LoginModels.swift
//  TwoToo
//
//  Created by 박건우 on 2023/06/04.
//  Copyright (c) 2023 TwoToo. All rights reserved.
//

import UIKit

enum Login {
    
    // MARK: Entity
    
    enum Model {
        
        enum UserState {
             /// 닉네임이 설정되지 않음
             case nickname
             /// 초대가 전송되지 않음
             case invitationSend
             /// 매칭되지 않음
             case invitationWait
             /// 랜딩됨
             case home
         }
    }
    
    enum ViewModel {
        
        struct KakaoLogin {
            var isHidden: Bool?
        }
        
        struct AppleLogin {
            var isHidden: Bool?
        }
        
        struct Toast {
            var message: String?
        }
    }
}
