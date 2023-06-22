//
//  TTPrimaryButton.swift
//  
//
//  Created by Eddy on 2023/06/19.
//

import UIKit
import Util

/// 기본으로 사용되는 Button
public class TTPrimaryButton: UIButton, UIComponentBased {

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


extension TTPrimaryButton {
    public enum ButtonType {
        case large
        case largeLine
        case small
        case tiny
    }

    /// 버튼을 선택하여 생성해주는 함수
    /// large: 버튼 중 가장 긴 버튼
    /// largeLine: 가장 긴 버튼에서 선으로 그려진 버튼
    /// small: 버튼 중간 사이즈 버튼
    /// tiny: 버튼 작은 사이즈 버튼
    /// 사용 예시:
    ///    ```swift
    ///       TTPrimaryButton.create(title: "다시 보내기", .largeLint)
    ///    ```
    public static func create(title: String, _ type: ButtonType) -> TTPrimaryButtonType {
        switch type {
        case .large:
            return TTPrimaryButtonType(title: title, customButtonType: .large)
        case .largeLine:
            return TTPrimaryButtonType(title: title, customButtonType: .largeLine)
        case .small:
            return TTPrimaryButtonType(title: title, customButtonType: .small)
        case .tiny:
            return TTPrimaryButtonType(title: title, customButtonType: .tiny)
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
