//
//  FlowerMappingWorker.swift
//  
//
//  Created by Eddy on 2023/07/15.
//

import UIKit
import DesignSystem

public enum Flower {
    case rose
    case tulip
    case cotton
    case fig
    case chrysanthemum
    case sunflower
    case camellia
    case delphinium
}

final public class FlowerMappingWorker {
    public var flowerType: Flower

    public init(flowerType: Flower) {
        self.flowerType = flowerType
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
}
