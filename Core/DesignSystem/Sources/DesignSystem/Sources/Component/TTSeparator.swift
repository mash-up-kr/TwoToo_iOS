//
//  TTSeparator.swift
//  
//
//  Created by Eddy on 2023/07/28.
//

import UIKit

/// Separator
public final class TTSeparator: UIView {
    private let color: UIColor?
    private let height: Double
    
    public init(color: UIColor?, height: Double) {
        self.color = color
        self.height = height
        super.init(frame: .zero)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Don't use storyboard")
    }
    
    private func setup() {
        backgroundColor = color
        self.snp.makeConstraints {
            $0.height.equalTo(height)
        }
    }
}
