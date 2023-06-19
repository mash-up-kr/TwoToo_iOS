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
        attribute()
        layout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func attribute() {
        self.layer.cornerRadius = 20
        self.contentEdgeInsets = .init(top: 10, left: 20, bottom: 10, right: 20)
        self.titleLabel?.font = .h4
        self.setTitleColor(.primary, for: .normal)
    }

    public func layout() {}
}

extension TTChallengeButton {
    /// 챌린지 title 설정해주는 함수
    public func setTitle(_ title: String) {
        self.setTitle(title, for: .normal)
    }

    /// 챌린지 선택되었을 때 배경색 바뀌도록 하는 함수
    public func isSelected(_ isSelected: Bool) {
        if isSelected {
            self.backgroundColor = .second01
        } else {
            self.backgroundColor = .mainWhite
        }
    }
}
