//
//  SelfSizingScrollView.swift
//  
//
//  Created by Julia on 2023/06/25.
//

import UIKit

final class SelfSizingScrollView: UIScrollView {
    private let maxHeight: CGFloat
    
    override var intrinsicContentSize: CGSize {
        CGSize(width: contentSize.width, height: min(contentSize.height, maxHeight))
    }
    
    init(maxHeight: CGFloat) {
        self.maxHeight = maxHeight
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        invalidateIntrinsicContentSize()
    }
}
