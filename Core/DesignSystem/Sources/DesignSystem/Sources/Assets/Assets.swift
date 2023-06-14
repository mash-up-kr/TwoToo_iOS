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
    case flower_small_sunflower_small
    case flower_small_fig
    case flower_small_chrysanthemum
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

    public var image: UIImage? {
        return .init(named: self.rawValue, in: Bundle.module, with: nil)
    }
    
}
