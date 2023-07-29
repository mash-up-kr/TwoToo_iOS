//
//  FlowerMappingWorker.swift
//  
//
//  Created by Eddy on 2023/07/15.
//

import UIKit
import DesignSystem

public enum Flower: Int, Equatable, CaseIterable {
    case rose
    case tulip
    case cotton
    case fig
    case chrysanthemum
    case sunflower
    case camellia
    case delphinium

    public var name: String {
        switch self {
        case .rose: return "rose"
        case .tulip: return "tulip"
        case .cotton: return "cotton"
        case .fig: return "fig"
        case .chrysanthemum: return "chrysanthemum"
        case .sunflower: return "sunflower"
        case .camellia: return "camellia"
        case .delphinium: return "delphinium"
        }
    }
}

public enum GrowsStatus: Equatable {
    /// Step 1 - 씨앗
    case seed
    /// Step 2 - 작은 새싹
    case sprout
    /// Step 3 - 어린 봉우리
    case bud
    /// Step 3 - 봉우리
    case peak
    /// Step 4 - 꽃
    case flower
    /// Step 5 - 만개한 꽃
    case bloom
}

final public class FlowerMappingWorker {
    public var flowerType: Flower

    public init(flowerType: Flower) {
        self.flowerType = flowerType
    }
    
    public func getSmallImage() -> UIImage {
        switch flowerType {
        case .rose:
            return .asset(.flower_small_rose)!
        case .tulip:
            return .asset(.flower_small_tulip)!
        case .cotton:
            return .asset(.flower_small_cotton)!
        case .fig:
            return .asset(.flower_small_fig)!
        case .chrysanthemum:
            return .asset(.flower_small_chrysanthemum)!
        case .sunflower:
            return .asset(.flower_small_sunflower)!
        case .camellia:
            return .asset(.flower_small_camellia)!
        case .delphinium:
            return .asset(.flower_small_delphinium)!
        }
    }

    public func getRegularImage() -> UIImage {
        switch flowerType {
        case .rose:
            return .asset(.flower_regular_rose)!
        case .tulip:
            return .asset(.flower_regular_tulip)!
        case .cotton:
            return .asset(.flower_regular_cotton)!
        case .fig:
            return .asset(.flower_regular_fig)!
        case .chrysanthemum:
            return .asset(.flower_regular_chrysanthemum)!
        case .sunflower:
            return .asset(.flower_regular_sunflower)!
        case .camellia:
            return .asset(.flower_regular_camellia)!
        case .delphinium:
            return .asset(.flower_regular_delphinium)!
        }
    }

    public func getBlingImage() -> UIImage {
        switch flowerType {
        case .rose:
            return .asset(.flower_bling_rose)!
        case .tulip:
            return .asset(.flower_bling_tulip)!
        case .cotton:
            return .asset(.flower_bling_cotton)!
        case .fig:
            return .asset(.flower_bling_fig)!
        case .chrysanthemum:
            return .asset(.flower_bling_chrysanthemum)!
        case .sunflower:
            return .asset(.flower_bling_sunflower)!
        case .camellia:
            return .asset(.flower_bling_camellia)!
        case .delphinium:
            return .asset(.flower_bling_delphinium)!
        }
    }

    public func getMateImage() -> UIImage {
        switch flowerType {
        case .rose:
            return .asset(.flower_success_mate_rose)!
        case .tulip:
            return .asset(.flower_success_mate_tulip)!
        case .cotton:
            return .asset(.flower_success_mate_cotton)!
        case .fig:
            return .asset(.flower_success_mate_fig)!
        case .chrysanthemum:
            return .asset(.flower_success_mate_chrysanthemum)!
        case .sunflower:
            return .asset(.flower_success_mate_sunflower)!
        case .camellia:
            return .asset(.flower_success_mate_camellia)!
        case .delphinium:
            return .asset(.flower_success_mate_delphinium)!
        }
    }

    public func getMateBlingImage() -> UIImage {
        switch flowerType {
        case .rose:
            return .asset(.flower_success_mate_bling_rose)!
        case .tulip:
            return .asset(.flower_success_mate_bling_tulip)!
        case .cotton:
            return .asset(.flower_success_mate_bling_cotton)!
        case .fig:
            return .asset(.flower_success_mate_bling_fig)!
        case .chrysanthemum:
            return .asset(.flower_success_mate_bling_chrysanthemum)!
        case .sunflower:
            return .asset(.flower_success_mate_bling_sunflower)!
        case .camellia:
            return .asset(.flower_success_mate_bling_camellia)!
        case .delphinium:
            return .asset(.flower_success_mate_bling_delphinium)!
        }
    }
    
    public func getMateImageByStep(growStatus: GrowsStatus) -> UIImage {
        switch growStatus {
        case .seed:
            return .asset(.icon_step0_mate)!
        case .sprout:
            return .asset(.icon_step1_mate)!
        case .bud:
            return .asset(.icon_step2_mate)!
        case .peak:
            return .asset(.icon_step3_mate)!
        case .flower:
            return self.getMateImage()
        case .bloom:
            return self.getMateBlingImage()
        }
    }

    public func getMyImage() -> UIImage {
        switch flowerType {
        case .rose:
            return .asset(.flower_success_my_rose)!
        case .tulip:
            return .asset(.flower_success_my_tulip)!
        case .cotton:
            return .asset(.flower_success_my_cotton)!
        case .fig:
            return .asset(.flower_success_my_fig)!
        case .chrysanthemum:
            return .asset(.flower_success_my_chrysanthemum)!
        case .sunflower:
            return .asset(.flower_success_my_sunflower)!
        case .camellia:
            return .asset(.flower_success_my_camellia)!
        case .delphinium:
            return .asset(.flower_success_my_delphinium)!
        }
    }

    public func getMyBlingImage() -> UIImage {
        switch flowerType {
        case .rose:
            return .asset(.flower_success_my_bling_rose)!
        case .tulip:
            return .asset(.flower_success_my_bling_tulip)!
        case .cotton:
            return .asset(.flower_success_my_bling_cotton)!
        case .fig:
            return .asset(.flower_success_my_bling_fig)!
        case .chrysanthemum:
            return .asset(.flower_success_my_bling_chrysanthemum)!
        case .sunflower:
            return .asset(.flower_success_my_bling_sunflower)!
        case .camellia:
            return .asset(.flower_success_my_bling_camellia)!
        case .delphinium:
            return .asset(.flower_success_my_bling_delphinium)!
        }
    }
    
    public func getBlurImage() -> UIImage {
        switch flowerType {
        case .rose:
            return .asset(.flower_blur_rose)!
        case .tulip:
            return .asset(.flower_blur_tulip)!
        case .cotton:
            return .asset(.flower_blur_cotton)!
        case .fig:
            return .asset(.flower_blur_fig)!
        case .chrysanthemum:
            return .asset(.flower_blur_chrysanthemum)!
        case .sunflower:
            return .asset(.flower_blur_sunflower_blur)!
        case .camellia:
            return .asset(.flower_blur_camellia)!
        case .delphinium:
            return .asset(.flower_blur_delphinium)!
        }
    }
    
    public func getMyImageByStep(growStatus: GrowsStatus) -> UIImage {
        switch growStatus {
        case .seed:
            return .asset(.icon_step0_my)!
        case .sprout:
            return .asset(.icon_step1_my)!
        case .bud:
            return .asset(.icon_step2_my)!
        case .peak:
            return .asset(.icon_step3_my)!
        case .flower:
            return self.getMyImage()
        case .bloom:
            return self.getMyBlingImage()
        }
    }
    
    public func getName() -> String {
        switch flowerType {
        case .rose:
            return "장미"
        case .tulip:
            return "튤립"
        case .cotton:
            return "목화"
        case .fig:
            return "무화과"
        case .chrysanthemum:
            return "퐁퐁국화"
        case .sunflower:
            return "해바라기"
        case .camellia:
            return "동백"
        case .delphinium:
            return "델피늄"
        }
    }
    
    public func getDesc() -> String {
        switch flowerType {
        case .rose:
            return "행복한 사랑을 이루어 봐요"
        case .tulip:
            return "수줍은 사랑을 주고 싶어요"
        case .cotton:
            return "온기를 담아 사랑해요"
        case .fig:
            return "사랑의 결실을 맺어봐요"
        case .chrysanthemum:
            return "제 마음은 늘 진심이에요"
        case .sunflower:
            return "당신을 바라보고 싶어요"
        case .camellia:
            return "그 누구보다도 사랑해요"
        case .delphinium:
            return "당신을 행복하게 해줄게요"
        }
    }
}
