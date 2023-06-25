//
//  SelfSizingScrollView.swift
//  
//
//  Created by Julia on 2023/06/25.
//

import UIKit

final class SelfSizingScrollView: UIScrollView {
    
    override var intrinsicContentSize: CGSize {
        CGSize(width: contentSize.width,
               height: UIScreen.main.bounds.height * 0.75)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        invalidateIntrinsicContentSize()
    }
    
}
