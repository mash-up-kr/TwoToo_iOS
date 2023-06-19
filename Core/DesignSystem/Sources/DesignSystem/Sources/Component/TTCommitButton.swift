//
//  TTCommitButton.swift
//  
//
//  Created by Eddy on 2023/06/19.
//

import UIKit

final class TTCommitButton: TTButton {

    var customButtonType: CustomButtonType = .longCommit

    convenience init(customButtonType: CustomButtonType) {
        self.init(frame: .zero)
        self.customButtonType = customButtonType
        attribute()
        layout()
    }

    override func attribute() {
        self.setTitle("인증하기", for: .normal)
        self.setTitleColor(.mainWhite, for: .normal)
        self.titleLabel?.font = customButtonType.fontSize
        self.backgroundColor = .grey400
        self.layer.cornerRadius = customButtonType.buttonCornerRadius ?? 0
        self.titleEdgeInsets = customButtonType.titlePadding ?? .init(top: 0, left: 0, bottom: 0, right: 0)
    }

    override func layout() {
        self.snp.makeConstraints { make in
            make.height.equalTo(customButtonType.buttonHeight)
            make.width.equalTo(customButtonType.buttonWidth)
        }
    }
}

extension TTCommitButton {
    public enum CustomButtonType {
        case longCommit
        case mediumCommit
        case smallCommit

        var fontSize: UIFont? {
            switch self {
            case .longCommit, .mediumCommit:
                return .h3
            case .smallCommit:
                return .body2
            }
        }

        var titlePadding: UIEdgeInsets? {
            switch self {
            case .longCommit:
                return .init(top: 18.5, left: 131, bottom: 18.5, right: 131)
            case .mediumCommit:
                return .init(top: 18.5, left: 56, bottom: 18.5, right: 56)
            case .smallCommit:
                return .init(top: 6, left: 11, bottom: 6, right: 11)
            }
        }

        var buttonCornerRadius: CGFloat? {
            switch self {
            case .longCommit, .mediumCommit:
                return 20
            case .smallCommit:
                return 10
            }
        }

        var buttonWidth: CGFloat {
            switch self {
            case .longCommit:
                return 327
            case .mediumCommit:
                return 177
            case .smallCommit:
                return 67
            }
        }

        var buttonHeight: CGFloat {
            switch self {
            case .longCommit, .mediumCommit:
                return 57
            case .smallCommit:
                return 27
            }
        }
    }
}
