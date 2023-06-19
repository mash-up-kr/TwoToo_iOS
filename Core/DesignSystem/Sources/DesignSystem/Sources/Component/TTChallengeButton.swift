//
//  TTChallengeButton.swift
//  
//
//  Created by Eddy on 2023/06/14.
//

import UIKit
import Util
import SnapKit

public class TTChallengeButton: UIButton, UIComponentBased {
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
        self.addTapAction {
            if self.isSelected {
                self.isSelected = false
                self.backgroundColor = .mainWhite
            }
            else {
                self.isSelected = true
                self.backgroundColor = .second01
            }
        }
    }

    public func layout() {}
}

extension TTChallengeButton {
    /// 챌린지 title 설정해주는 함수
    public func setTitle(_ title: String) {
        self.setTitle(title, for: .normal)
    }
}
