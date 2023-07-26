//
//  FlowerSelectModels.swift
//  TwoToo
//
//  Created by 박건우 on 2023/06/04.
//  Copyright (c) 2023 TwoToo. All rights reserved.
//

import UIKit
import Worker

enum FlowerSelect {
    
    // MARK: Entity
    
    enum Model {
        struct CreateChallengeButton {
            var isHidden: Bool
            var title: Title
            
            enum Title: String {
                case create = "챌린지 요청하기"
                case accpet = "챌린지 시작하기"
            }
        }
        
        struct FlowerSelect {
            var indexPath: Int?
        }
        
        struct Flower {
            var flowers: [FlowerMappingWorker]?
        }
    }
    
    enum ViewModel {

        struct createChallengeButton {
            var isHidden: Bool
            var title: String
        }

        struct Toast {
            var message: String?
        }

        struct FlowerSelect {
            var indexPath: Int?
        }

        struct Flower {
            var flowers: [FlowerMappingWorker]?
        }
    }
}
