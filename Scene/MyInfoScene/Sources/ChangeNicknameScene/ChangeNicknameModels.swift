//
//  ChangeNicknameModels.swift
//  TwoToo
//
//  Created by Eddy on 2023/10/12.
//  Copyright (c) 2023 TwoToo. All rights reserved.
//

import UIKit

enum ChangeNickname {
    
    // MARK: Entity
    
    enum Model {
      struct Data {
        /// 내 닉네임
        var nickname: String
      }
    }
    
    enum ViewModel {
      
      struct Title {
        var text: String?
      }
      
      struct ChangeButton {
        var isEnabled: Bool?
      }
      
      struct Toast {
        var message: String?
      }
    }
}
