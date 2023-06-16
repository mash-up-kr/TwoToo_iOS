//
//  SplashModels.swift
//  TwoToo
//
//  Created by 박건우 on 2023/06/03.
//  Copyright (c) 2023 TwoToo. All rights reserved.
//

import UIKit

enum Splash {
    
    // MARK: Entity
    
    enum Model {
        
        enum UserState {
            /// 로그인이 되지 않음
            case login
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
        
    }
}
