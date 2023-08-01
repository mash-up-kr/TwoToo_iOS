//
//  MainTabBar.swift
//  
//
//  Created by 박건우 on 2023/07/06.
//

import CoreKit
import UIKit

final class MainTabBar: UITabBar {
    
    // MARK: - Layout
    
    private struct Appearance {
        static let height: CGFloat = 61.0
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        var sizeThatFits = super.sizeThatFits(size)
        sizeThatFits.height = Appearance.height + UIDevice.current.safeAreaBottomHeight
        return sizeThatFits
    }
}
