//
//  SelfSizingScrollView.swift
//  
//
//  Created by Julia on 2023/06/25.
//

import UIKit

public final class SelfSizingScrollView: UIScrollView {
    private var maxHeight: CGFloat = UIScreen.main.bounds.height * 0.67
    
    public override var intrinsicContentSize: CGSize {
        CGSize(width: contentSize.width,
               height: maxHeight)
    }

    public override func layoutSubviews() {
        super.layoutSubviews()
        invalidateIntrinsicContentSize()
    }
    
    public convenience init(maxHeight: CGFloat) {
        self.init()
        self.maxHeight = maxHeight
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
    }
 
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
