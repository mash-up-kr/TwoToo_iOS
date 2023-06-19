//
//  PrimaryButton.swift
//  
//
//  Created by Eddy on 2023/06/19.
//

import UIKit
import Util

/// 기본으로 사용되는 Button
public class PrimaryButton: UIButton, UIComponentBased {

    /// title 변경 시 사용
    public var title: String = "" {
        didSet {
            self.setTitle(title, for: .normal)
        }
    }

    /// 버튼이 enable 여부로 사용
    public var isCommitEnabled: Bool = false {
        didSet {
            self.isCommitEnabled(isCommitEnabled)
        }
    }

    override public init(frame: CGRect) {
        super.init(frame: .zero)

        self.attribute()
        self.layout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func layout() { }
    public func attribute() { }
}


extension PrimaryButton {
    public enum ButtonType {
        case large
        case medium
        case small
    }

    /// 버튼을 선택하여 생성해주는 함수
    /// large: 버튼 중 가장 긴 버튼
    /// medium: 버튼 중간 사이즈 버튼
    /// small: 버튼 작은 사이즈 버튼
    /// 사용 예시:
    ///    ```swift
    ///       PrimaryButton.create(.medium)
    ///    ```
    public static func create(_ type: ButtonType) -> PrimaryButtonType {
        switch type {
        case .large:
            return PrimaryButtonType(customButtonType: .large)
        case .medium:
            return PrimaryButtonType(customButtonType: .medium)
        case .small:
            return PrimaryButtonType(customButtonType: .small)
        }
    }

    /// 버튼 활성화 여부에 따른 background, enable 설정 변경 내부 함수
    func isCommitEnabled(_ isEnabled: Bool) {
        if isEnabled {
            self.backgroundColor = .primary
            self.isEnabled = true
        }
        else {
            self.backgroundColor = .grey400
            self.isEnabled = false
        }
    }
}
