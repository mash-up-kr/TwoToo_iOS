//
//  ChallengeRecommendModels.swift
//  TwoToo
//
//  Created by 박건우 on 2023/06/04.
//  Copyright (c) 2023 TwoToo. All rights reserved.
//

import UIKit

enum ChallengeRecommend {
    
    // MARK: Entity
    
    enum Model {
        
    }
    
    enum ViewModel {
        
        struct Challenges {
            var items: [Challenge]?
            
            struct Challenge {
                var title: (icon: String, challengeName: String)
            }
        }
    }
}
