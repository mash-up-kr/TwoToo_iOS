//
//  MyInfoModels.swift
//  TwoToo
//
//  Created by 박건우 on 2023/06/04.
//  Copyright (c) 2023 TwoToo. All rights reserved.
//

import UIKit

enum MyInfo {
    
    // MARK: Entity
    
    enum Model {
        struct Data {
            var myNickname: String
            var partnerNickname: String
            var challengeTotalCount: String?
        }
    }
    
    enum ViewModel {
        struct Lists {
            var items: [Item]?
            
            struct Item {
                var title: String
            }
        }

        struct Data {
            var myNickname: String
            var partnerNickname: String
            var challengeTotalCount: String?
        }
    }
}
