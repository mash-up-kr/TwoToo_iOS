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
        
    }
    
    enum ViewModel {

        struct createChallengeButton {
            var isHidden: Bool?
        }


        struct Toast {
            var message: String?
        }

        struct FlowerSelect {
            var isSelected: Bool?
        }

        struct Flower {
            var flowers: [FlowerMappingWorker]?
        }
    }
}
