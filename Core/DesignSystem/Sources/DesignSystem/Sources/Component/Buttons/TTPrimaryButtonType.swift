//
//  TTPrimaryButtonType.swift
//  
//
//  Created by Eddy on 2023/06/19.
//

import UIKit
import Util

/// 기본으로 사용되는 ButtonType
final public class TTPrimaryButtonType: UIButton, UIComponentBased {

    var customButtonType: CustomButtonType = .large

    convenience init(title: String, customButtonType: CustomButtonType) {
        self.init(frame: .zero)
        self.setTitle(title, for: .normal)
        self.customButtonType = customButtonType
        self.attribute()
        self.layout()
    }

    public func attribute() {
        self.setTitleColor(self.customButtonType.titleColor, for: .normal)
        self.titleLabel?.font = self.customButtonType.fontSize
        self.backgroundColor = self.customButtonType.backgroundColor
        self.layer.cornerRadius = self.customButtonType.buttonCornerRadius ?? 0
        self.layer.borderColor = self.customButtonType.borderColor
        self.layer.borderWidth = self.customButtonType.borderWidth
    }

    public func layout() {
        self.snp.makeConstraints { make in
            make.height.equalTo(self.customButtonType.buttonHeight)
        }
    }

    @MainActor
    public func didTapButton(completion: (() -> Void)? = nil) {
        self.addAction {
            completion?()
        }
    }
    
    /// 버튼 활성화 여부에 따른 background, enable 설정 변경 내부 함수
    public func setIsEnabled(_ isEnabled: Bool) {
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

extension TTPrimaryButtonType {
    public enum CustomButtonType {
        case large
        case largeLine
        case small
        case tiny

        var fontSize: UIFont? {
            switch self {
            case .large, .largeLine, .small:
                return .h3
            case .tiny:
                return .body2
            }
        }

        var titleColor: UIColor {
            switch self {
            case .large, .small, .tiny:
                return .mainWhite
            case .largeLine:
                return .primary
            }
        }

        var borderColor: CGColor {
            switch self {
            case .large, .small, .tiny:
                return UIColor.clear.cgColor
            case .largeLine:
                return UIColor.black.cgColor
            }
        }

        var borderWidth: CGFloat {
            switch self {
            case .large, .small, .tiny:
                return 0
            case .largeLine:
                return 1
            }
        }

        var backgroundColor: UIColor? {
            switch self {
            case .large, .small, .tiny:
                return .grey400
            case .largeLine:
                return .clear
            }
        }

        var buttonCornerRadius: CGFloat? {
            switch self {
            case .large, .largeLine, .small:
                return 20
            case .tiny:
                return 10
            }
        }

        var buttonHeight: CGFloat {
            switch self {
            case .large, .largeLine, .small:
                return 57
            case .tiny:
                return 27
            }
        }
    }
}
