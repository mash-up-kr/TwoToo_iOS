//
//  TTButton.swift
//  
//
//  Created by Eddy on 2023/06/19.
//

import UIKit
import Util

public class TTButton: UIButton, UIComponentBased {

    /// title 변경 시 사용
    public var title: String = "" {
        didSet {
            self.setTitle(title, for: .normal)
        }
    }

    /// 인증하기 버튼이 enable 되었을 떄 사용
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


extension TTButton {
    public enum TTCommitButtonType {
        case longCommit
        case mediumCommit
        case smallCommit
    }

    /// 인증하기 버튼을 선택하여 생성해주는 함수
    /*

     longCommit: 인증하기 버튼 중 가장 긴 버튼(일반적으로 인증할 때 사용)
     mediumCommit: 인증하기 버튼 중간 사이즈 버튼
     smallCommit: 인증하기 버튼 작은 사이즈 버튼(히스토리에서 인증할 때 사용)

     사용 예시:
         ```swift
            TTButton.create(.mediumCommit)
         ```
     */
    public static func create(_ type: TTCommitButtonType) -> TTCommitButton {
        switch type {
        case .longCommit:
            return TTCommitButton(customButtonType: .longCommit)
        case .mediumCommit:
            return TTCommitButton(customButtonType: .mediumCommit)
        case .smallCommit:
            return TTCommitButton(customButtonType: .smallCommit)
        }
    }

    /// 인증하기 버튼 활성화 여부에 따른 background, enable 설정 변경 내부 함수
    func isCommitEnabled(_ isEnabled: Bool) {
        if isEnabled {
            self.backgroundColor = .primary
            self.isEnabled = true
        } else {
            self.backgroundColor = .grey400
            self.isEnabled = false
        }
    }
}
