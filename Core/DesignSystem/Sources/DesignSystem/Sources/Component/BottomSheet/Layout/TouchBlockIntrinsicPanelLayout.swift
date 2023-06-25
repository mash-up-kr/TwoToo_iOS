//
//  TouchBlockIntrinsicPanelLayout.swift
//  
//
//  Created by Julia on 2023/06/23.
//

import Foundation
import FloatingPanel

final class TouchBlockIntrinsicPanelLayout: FloatingPanelBottomLayout {
    
    override var initialState: FloatingPanelState { .full }
    override var anchors: [FloatingPanelState : FloatingPanelLayoutAnchoring] {
        [ .full: FloatingPanelIntrinsicLayoutAnchor(fractionalOffset: 0, referenceGuide: .safeArea) ]
    }
    override func backdropAlpha(for state: FloatingPanelState) -> CGFloat {
        0.5
    }
    
}
