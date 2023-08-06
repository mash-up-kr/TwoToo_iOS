//
//  SelfSizingScrollView.swift
//  
//
//  Created by Julia on 2023/06/25.
//

import UIKit

public final class SelfSizingScrollView: UIScrollView {
    
    public override var intrinsicContentSize: CGSize {
        CGSize(width: contentSize.width,
               height: UIScreen.main.bounds.height * 0.75)
    }

    public override func layoutSubviews() {
        super.layoutSubviews()
        invalidateIntrinsicContentSize()
    }
    
}
