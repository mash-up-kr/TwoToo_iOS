//
//  TTTagButton.swift
//  
//
//  Created by Eddy on 2023/06/14.
//

import UIKit
import Util

/// Tag에서 사용하는 Button
public class TTTagButton: UIButton, UIComponentBased {
    public init() {
        super.init(frame: .zero)
        self.attribute()
        self.layout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func attribute() {
        self.layer.cornerRadius = 20
        self.contentEdgeInsets = .init(top: 10, left: 20, bottom: 10, right: 20)
        self.titleLabel?.font = .h4
        self.setTitleColor(.primary, for: .normal)

        /// Tap 눌렀을 때 선택되었다는 상태와 backgroundColor 변경
        self.addTapAction { [weak self] in
            if self?.isSelected != nil {
                self?.isSelected = false
                self?.backgroundColor = .mainWhite
            }
            else {
                self?.isSelected = true
                self?.backgroundColor = .second01
            }
        }
    }

    public func layout() {}
}

extension TTTagButton {
    /// title 설정해주는 함수
    public func setTitle(_ title: String) {
        self.setTitle(title, for: .normal)
    }
}
