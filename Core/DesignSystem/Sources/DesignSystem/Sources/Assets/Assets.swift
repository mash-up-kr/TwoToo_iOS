//
//  AssetImages.swift
//  
//
//  Created by Julia on 2023/06/14.
//

import UIKit

public enum Assets: String {
    
    case flower_bling_cotton
    case flower_bling_tulip
    case flower_bling_delphinium
    case flower_bling_chrysanthemum
    case flower_bling_camellia
    case flower_bling_fig
    case flower_bling_rose
    case flower_bling_sunflower
    case flower_blur_delphinium
    case flower_blur_rose
    case flower_blur_cotton
    case flower_blur_chrysanthemum
    case flower_blur_fig
    case flower_blur_tulip
    case flower_blur_camellia
    case flower_blur_sunflower_blur
    case flower_regular_chrysanthemum
    case flower_regular_fig
    case flower_regular_cotton
    case flower_regular_sunflower
    case flower_regular_camellia
    case flower_regular_delphinium
    case flower_regular_rose
    case flower_regular_tulip
    case flower_small_camellia
    case flower_small_rose
    case flower_small_tulip
    case flower_small_delphinium
    case flower_small_cotton
    case flower_small_sunflower
    case flower_small_fig
    case flower_small_chrysanthemum
    case flower_success_mate_bling_camellia
    case flower_success_mate_bling_chrysanthemum
    case flower_success_mate_bling_cotton
    case flower_success_mate_bling_delphinium
    case flower_success_mate_bling_fig
    case flower_success_mate_bling_tulip
    case flower_success_mate_bling_rose
    case flower_success_mate_bling_sunflower
    case flower_success_mate_camellia
    case flower_success_mate_chrysanthemum
    case flower_success_mate_cotton
    case flower_success_mate_delphinium
    case flower_success_mate_fig
    case flower_success_mate_rose
    case flower_success_mate_sunflower
    case flower_success_mate_tulip
    case flower_success_my_bling_camellia
    case flower_success_my_bling_chrysanthemum
    case flower_success_my_bling_cotton
    case flower_success_my_bling_delphinium
    case flower_success_my_bling_fig
    case flower_success_my_bling_rose
    case flower_success_my_bling_sunflower
    case flower_success_my_bling_tulip
    case flower_success_my_camellia
    case flower_success_my_chrysanthemum
    case flower_success_my_cotton
    case flower_success_my_delphinium
    case flower_success_my_fig
    case flower_success_my_rose
    case flower_success_my_sunflower
    case flower_success_my_tulip
    case icon_cancel
    case icon_heart
    case icon_more
    case icon_back
    case icon_mypage_yellow
    case icon_home_brown
    case icon_history_yellow
    case icon_home_pink
    case icon_history_brown
    case icon_history_pink
    case icon_bubble_write
    case icon_bee
    case icon_mypage_pink
    case icon_bubble_not_mate
    case icon_mypage_brown
    case icon_info
    case home_ground
    case home_background
    case icon_airplane
    case icon_push_bee
    case icon_certificated
    case icon_failed
    case icon_flower_seed
    case icon_invitation
    case icon_leaf
    case icon_nicknam_my
    case icon_nickname_mate
    case icon_seed
    case icon_step0_mate
    case icon_step0_my
    case icon_step1_mate
    case icon_step1_my
    case icon_step2_mate
    case icon_step2_my
    case icon_step3_mate
    case icon_step3_my
    case icon_waiting
    case icon_delete
    case icon_sleepingseed
    case onboarding_1
    case onboarding_2
    case onboarding_3
    case icon_buds
    case icon_bubble_tail_my
    case icon_bubble_tail_partner
    case icon_check
    case icon_cryingseed
    case icon_blossome
    case icon_congratulation
    case icon_all_verified

    public var image: UIImage {
        return .init(named: self.rawValue, in: Bundle.module, with: nil)!
    }
    
}
